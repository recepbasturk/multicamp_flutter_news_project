// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsViewModel on _NewsViewModelBase, Store {
  final _$newsSourceAtom = Atom(name: '_NewsViewModelBase.newsSource');

  @override
  String get newsSource {
    _$newsSourceAtom.reportRead();
    return super.newsSource;
  }

  @override
  set newsSource(String value) {
    _$newsSourceAtom.reportWrite(value, super.newsSource, () {
      super.newsSource = value;
    });
  }

  final _$aalogoButtonValueAtom =
      Atom(name: '_NewsViewModelBase.aalogoButtonValue');

  @override
  bool get aalogoButtonValue {
    _$aalogoButtonValueAtom.reportRead();
    return super.aalogoButtonValue;
  }

  @override
  set aalogoButtonValue(bool value) {
    _$aalogoButtonValueAtom.reportWrite(value, super.aalogoButtonValue, () {
      super.aalogoButtonValue = value;
    });
  }

  final _$hurriyetlogoButtonValueAtom =
      Atom(name: '_NewsViewModelBase.hurriyetlogoButtonValue');

  @override
  bool get hurriyetlogoButtonValue {
    _$hurriyetlogoButtonValueAtom.reportRead();
    return super.hurriyetlogoButtonValue;
  }

  @override
  set hurriyetlogoButtonValue(bool value) {
    _$hurriyetlogoButtonValueAtom
        .reportWrite(value, super.hurriyetlogoButtonValue, () {
      super.hurriyetlogoButtonValue = value;
    });
  }

  final _$t24logoButtonValueAtom =
      Atom(name: '_NewsViewModelBase.t24logoButtonValue');

  @override
  bool get t24logoButtonValue {
    _$t24logoButtonValueAtom.reportRead();
    return super.t24logoButtonValue;
  }

  @override
  set t24logoButtonValue(bool value) {
    _$t24logoButtonValueAtom.reportWrite(value, super.t24logoButtonValue, () {
      super.t24logoButtonValue = value;
    });
  }

  final _$newsListAtom = Atom(name: '_NewsViewModelBase.newsList');

  @override
  ObservableList<News> get newsList {
    _$newsListAtom.reportRead();
    return super.newsList;
  }

  @override
  set newsList(ObservableList<News> value) {
    _$newsListAtom.reportWrite(value, super.newsList, () {
      super.newsList = value;
    });
  }

  final _$newsListGuncelAtom = Atom(name: '_NewsViewModelBase.newsListGuncel');

  @override
  ObservableList<News> get newsListGuncel {
    _$newsListGuncelAtom.reportRead();
    return super.newsListGuncel;
  }

  @override
  set newsListGuncel(ObservableList<News> value) {
    _$newsListGuncelAtom.reportWrite(value, super.newsListGuncel, () {
      super.newsListGuncel = value;
    });
  }

  final _$newsListSporAtom = Atom(name: '_NewsViewModelBase.newsListSpor');

  @override
  ObservableList<News> get newsListSpor {
    _$newsListSporAtom.reportRead();
    return super.newsListSpor;
  }

  @override
  set newsListSpor(ObservableList<News> value) {
    _$newsListSporAtom.reportWrite(value, super.newsListSpor, () {
      super.newsListSpor = value;
    });
  }

  final _$newsListDunyaAtom = Atom(name: '_NewsViewModelBase.newsListDunya');

  @override
  ObservableList<News> get newsListDunya {
    _$newsListDunyaAtom.reportRead();
    return super.newsListDunya;
  }

  @override
  set newsListDunya(ObservableList<News> value) {
    _$newsListDunyaAtom.reportWrite(value, super.newsListDunya, () {
      super.newsListDunya = value;
    });
  }

  final _$newsListTeknolojiAtom =
      Atom(name: '_NewsViewModelBase.newsListTeknoloji');

  @override
  ObservableList<News> get newsListTeknoloji {
    _$newsListTeknolojiAtom.reportRead();
    return super.newsListTeknoloji;
  }

  @override
  set newsListTeknoloji(ObservableList<News> value) {
    _$newsListTeknolojiAtom.reportWrite(value, super.newsListTeknoloji, () {
      super.newsListTeknoloji = value;
    });
  }

  final _$loadingNewsAtom = Atom(name: '_NewsViewModelBase.loadingNews');

  @override
  bool get loadingNews {
    _$loadingNewsAtom.reportRead();
    return super.loadingNews;
  }

  @override
  set loadingNews(bool value) {
    _$loadingNewsAtom.reportWrite(value, super.loadingNews, () {
      super.loadingNews = value;
    });
  }

  final _$loadFeedItemsFutureAtom =
      Atom(name: '_NewsViewModelBase.loadFeedItemsFuture');

  @override
  ObservableFuture<dynamic> get loadFeedItemsFuture {
    _$loadFeedItemsFutureAtom.reportRead();
    return super.loadFeedItemsFuture;
  }

  @override
  set loadFeedItemsFuture(ObservableFuture<dynamic> value) {
    _$loadFeedItemsFutureAtom.reportWrite(value, super.loadFeedItemsFuture, () {
      super.loadFeedItemsFuture = value;
    });
  }

  final _$selectNewsSourceAsyncAction =
      AsyncAction('_NewsViewModelBase.selectNewsSource');

  @override
  Future<void> selectNewsSource(String newsSource) {
    return _$selectNewsSourceAsyncAction
        .run(() => super.selectNewsSource(newsSource));
  }

  final _$getNewsAsyncAction = AsyncAction('_NewsViewModelBase.getNews');

  @override
  Future<void> getNews(dynamic newsSource) {
    return _$getNewsAsyncAction.run(() => super.getNews(newsSource));
  }

  final _$_getSporNewsAsyncAction =
      AsyncAction('_NewsViewModelBase._getSporNews');

  @override
  Future<void> _getSporNews(String newsSource) {
    return _$_getSporNewsAsyncAction.run(() => super._getSporNews(newsSource));
  }

  final _$_getDunyaNewsAsyncAction =
      AsyncAction('_NewsViewModelBase._getDunyaNews');

  @override
  Future<void> _getDunyaNews(String newsSource) {
    return _$_getDunyaNewsAsyncAction
        .run(() => super._getDunyaNews(newsSource));
  }

  final _$_getTeknolojiNewsAsyncAction =
      AsyncAction('_NewsViewModelBase._getTeknolojiNews');

  @override
  Future<void> _getTeknolojiNews(String newsSource) {
    return _$_getTeknolojiNewsAsyncAction
        .run(() => super._getTeknolojiNews(newsSource));
  }

  final _$getNewsCategoryAsyncAction =
      AsyncAction('_NewsViewModelBase.getNewsCategory');

  @override
  Future<void> getNewsCategory(dynamic category) {
    return _$getNewsCategoryAsyncAction
        .run(() => super.getNewsCategory(category));
  }

  final _$_loadFirstPageStoriesAsyncAction =
      AsyncAction('_NewsViewModelBase._loadFirstPageStories');

  @override
  Future<void> _loadFirstPageStories(dynamic newsSource) {
    return _$_loadFirstPageStoriesAsyncAction
        .run(() => super._loadFirstPageStories(newsSource));
  }

  final _$_NewsViewModelBaseActionController =
      ActionController(name: '_NewsViewModelBase');

  @override
  void newsSourceButton(String value) {
    final _$actionInfo = _$_NewsViewModelBaseActionController.startAction(
        name: '_NewsViewModelBase.newsSourceButton');
    try {
      return super.newsSourceButton(value);
    } finally {
      _$_NewsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> refresh(dynamic newsSource) {
    final _$actionInfo = _$_NewsViewModelBaseActionController.startAction(
        name: '_NewsViewModelBase.refresh');
    try {
      return super.refresh(newsSource);
    } finally {
      _$_NewsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> retry(dynamic newsSource) {
    final _$actionInfo = _$_NewsViewModelBaseActionController.startAction(
        name: '_NewsViewModelBase.retry');
    try {
      return super.retry(newsSource);
    } finally {
      _$_NewsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadInitialNews(dynamic newsSource) {
    final _$actionInfo = _$_NewsViewModelBaseActionController.startAction(
        name: '_NewsViewModelBase.loadInitialNews');
    try {
      return super.loadInitialNews(newsSource);
    } finally {
      _$_NewsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String newsSearch(String keyword) {
    final _$actionInfo = _$_NewsViewModelBaseActionController.startAction(
        name: '_NewsViewModelBase.newsSearch');
    try {
      return super.newsSearch(keyword);
    } finally {
      _$_NewsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetSearch() {
    final _$actionInfo = _$_NewsViewModelBaseActionController.startAction(
        name: '_NewsViewModelBase.resetSearch');
    try {
      return super.resetSearch();
    } finally {
      _$_NewsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newsSource: ${newsSource},
aalogoButtonValue: ${aalogoButtonValue},
hurriyetlogoButtonValue: ${hurriyetlogoButtonValue},
t24logoButtonValue: ${t24logoButtonValue},
newsList: ${newsList},
newsListGuncel: ${newsListGuncel},
newsListSpor: ${newsListSpor},
newsListDunya: ${newsListDunya},
newsListTeknoloji: ${newsListTeknoloji},
loadingNews: ${loadingNews},
loadFeedItemsFuture: ${loadFeedItemsFuture}
    ''';
  }
}
