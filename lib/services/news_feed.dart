import 'package:http/http.dart' as http;
import 'package:multicamp_flutter_project/models/news.dart';
import 'package:webfeed/webfeed.dart';

class NewsFeed {
  Future<List<News>> getNewsfeed({String url, String urlCategory}) async {
    var client = http.Client();
    List<News> newsListResult = [];
    var response = await client.get(url+urlCategory);

    var result = RssFeed.parse(response.body);
    for (int i = 0; i < result.items.length; i++) {
      newsListResult.add(News(
        title: result.items[i].title ?? '',
        link: result.items[i].link,
        imageUrl: result.items[i].imageUrl ?? result.items[i].enclosure.url,
        description: result.items[i].description ?? '',
        pubDate: result.items[i].pubDate,
      ));
    }
    client.close();
    return newsListResult;
  }
}
