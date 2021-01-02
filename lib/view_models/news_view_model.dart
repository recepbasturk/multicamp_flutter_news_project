import 'package:mobx/mobx.dart';
import 'package:multicamp_flutter_project/models/news.dart';
import 'package:multicamp_flutter_project/services/news_feed.dart';

import '../locator.dart';
part 'news_view_model.g.dart';

class NewsViewModel = _NewsViewModelBase with _$NewsViewModel;

abstract class _NewsViewModelBase with Store {
  final NewsFeed _newsFeed = locator<NewsFeed>();

  @observable
  String newsSource;

  @observable
  bool aalogoButtonValue = false;

  @observable
  bool hurriyetlogoButtonValue = false;

  @observable
  bool t24logoButtonValue = false;

  @observable
  ObservableList<News> newsList = ObservableList<News>();

  @observable
  ObservableList<News> newsListGuncel = ObservableList<News>();

  @observable
  ObservableList<News> newsListSpor = ObservableList<News>();

  @observable
  ObservableList<News> newsListDunya = ObservableList<News>();

  @observable
  ObservableList<News> newsListTeknoloji = ObservableList<News>();

  @observable
  bool loadingNews = false;

  @observable
  ObservableFuture loadFeedItemsFuture;

  @action
  void newsSourceButton(String value) {
    if (value == 'https://www.aa.com.tr/tr/rss/default?cat=') {
      aalogoButtonValue = true;
      hurriyetlogoButtonValue = false;
      t24logoButtonValue = false;
      newsSource = 'https://www.aa.com.tr/tr/rss/default?cat=';
    } else if (value == 'http://www.hurriyet.com.tr/rss/') {
      aalogoButtonValue = false;
      hurriyetlogoButtonValue = true;
      t24logoButtonValue = false;
      newsSource = 'http://www.hurriyet.com.tr/rss/';
    } else if (value == 'https://t24.com.tr/rss/haber/') {
      aalogoButtonValue = false;
      hurriyetlogoButtonValue = false;
      t24logoButtonValue = true;
      newsSource = 'https://t24.com.tr/rss/haber/';
    }
  }

  @action
  Future<void> selectNewsSource(String newsSource) async {
    newsSource = newsSource;
    await loadInitialNews(newsSource);
  }

  @action
  Future<void> refresh(newsSource) {
    return _loadFirstPageStories(newsSource);
  }

  @action
  Future<void> retry(newsSource) {
    return loadFeedItemsFuture =
        ObservableFuture(_loadFirstPageStories(newsSource));
  }

  @action
  Future<void> loadInitialNews(newsSource) {
    return loadFeedItemsFuture =
        ObservableFuture(_loadFirstPageStories(newsSource));
  }

  @action
  Future<void> getNews(newsSource) async {
    List<News> resultList = [];

    if (newsSource == 'https://www.aa.com.tr/tr/rss/default?cat=') {
      resultList =
          await _newsFeed.getNewsfeed(url: newsSource, urlCategory: 'guncel');
    } else {
      resultList =
          await _newsFeed.getNewsfeed(url: newsSource, urlCategory: 'gundem');
    }
    newsListGuncel.clear();
    newsListGuncel.addAll(resultList);
    newsList.addAll(resultList);
    await _getSporNews(newsSource);
    await _getDunyaNews(newsSource);
    await _getTeknolojiNews(newsSource);
    return true;
  }

  @action
  Future<void> _getSporNews(String newsSource) async {
    List<News> resultList = [];
    resultList =
        await _newsFeed.getNewsfeed(url: newsSource, urlCategory: 'spor');
    newsListSpor.clear();
    newsListSpor.addAll(resultList);
  }

  @action
  Future<void> _getDunyaNews(String newsSource) async {
    List<News> resultList = [];
    resultList =
        await _newsFeed.getNewsfeed(url: newsSource, urlCategory: 'dunya');
    newsListDunya.clear();
    newsListDunya.addAll(resultList);
  }

  @action
  Future<void> _getTeknolojiNews(String newsSource) async {
    List<News> resultList = [];
    if (newsSource == 'http://www.hurriyet.com.tr/rss/') {
      resultList = await _newsFeed.getNewsfeed(
          url: newsSource, urlCategory: 'teknoloji');
    } else {
      resultList = await _newsFeed.getNewsfeed(
          url: newsSource, urlCategory: 'bilim-teknoloji');
    }
    newsListTeknoloji.clear();
    newsListTeknoloji.addAll(resultList);
  }

  @action
  Future<void> getNewsCategory(category) async {
    List<News> resultList = [];
    if (category == 'guncel') {
      newsList.clear();
      resultList.addAll(newsListGuncel);
    } else if (category == 'spor') {
      newsList.clear();
      resultList.addAll(newsListSpor);
    } else if (category == 'dunya') {
      newsList.clear();
      resultList.addAll(newsListDunya);
    } else if (category == 'teknoloji') {
      newsList.clear();
      resultList.addAll(newsListTeknoloji);
    }
    return newsList.addAll(resultList);
  }

  @action
  String newsSearch(String keyword) {
    List<News> resultList;
    List<News> allNewsList = [
      ...?newsListGuncel,
      ...?newsListSpor,
      ...?newsListDunya,
      ...?newsListTeknoloji,
    ];
    resultList = allNewsList
        .where(
            (news) => news.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    if (resultList.length >= 1) {
      newsList.clear();
      newsList.addAll(resultList);
    } else {
      return '$keyword ile haber bulunamadı';
    }
    return '$keyword ile ilgili haberler getirildi';
  }

  @action
  void resetSearch() {
    newsList.clear();
    newsList.addAll(newsListGuncel);
  }

  @action
  Future<void> _loadFirstPageStories(newsSource) async {
    newsList.clear();
    newsListGuncel.clear();
    await getNews(newsSource);
  }
}
