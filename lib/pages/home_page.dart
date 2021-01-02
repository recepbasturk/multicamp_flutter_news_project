import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:multicamp_flutter_project/helpers/time_ago.dart';
import 'package:multicamp_flutter_project/pages/news_details_page.dart';
import 'package:multicamp_flutter_project/view_models/news_view_model.dart';
import 'package:multicamp_flutter_project/widgets/drawer_menu_widget.dart';

import '../locator.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final box = Hive.box(settingsBox);
  final TextEditingController _searchController = TextEditingController();
  final Map<String, String> categories = {
    'guncel': 'Güncel',
    'spor': 'Spor',
    'dunya': 'Dünya',
    'teknoloji': 'Teknoloji',
  };
  List<Widget> categoryWidgets = List<Widget>();

  @override
  void initState() {
    final NewsViewModel _newsViewModel = locator<NewsViewModel>();
    getCategoryWidgets(_newsViewModel);
    _newsViewModel.loadInitialNews(
        box.get('newsSource') ?? 'https://www.aa.com.tr/tr/rss/default?cat=');
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NewsViewModel _newsViewModel = locator<NewsViewModel>();
    return Theme(
      data: ThemeData(
        primaryIconTheme: IconThemeData(
          color: Colors.blueGrey,
        ),
        primarySwatch: Colors.blueGrey,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerMenuWidget(),
        endDrawerEnableOpenDragGesture: false,
        body: RefreshIndicator(
          onRefresh: () {
            return _newsViewModel.refresh(box.get('newsSource') ??
                'https://www.aa.com.tr/tr/rss/default?cat=');
          },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                collapsedHeight: 70,
                floating: true,
                pinned: false,
                snap: false,
                backgroundColor: Colors.white,
                title: buildSearchField(_newsViewModel),
                actions: [
                  buildIconButtonClose(_newsViewModel),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: categoryWidgets,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(15),
                sliver: Observer(
                  builder: (_) {
                    switch (_newsViewModel.loadFeedItemsFuture.status) {
                      case FutureStatus.rejected:
                        return buildNewsErrorRejected(_newsViewModel);
                      case FutureStatus.fulfilled:
                        return buildNewsSuccessfulFulfilled(_newsViewModel);
                      case FutureStatus.pending:
                      default:
                        return buildNewsPending();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField buildSearchField(NewsViewModel _newsViewModel) {
    return TextField(
        controller: _searchController,
        decoration:
            InputDecoration(hintText: "Ara...", border: InputBorder.none),
        onSubmitted: (String _searchController) {
          var result = _newsViewModel.newsSearch(_searchController);
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(result)));
        });
  }

  IconButton buildIconButtonClose(NewsViewModel _newsViewModel) {
    return IconButton(
      onPressed: () {
        if (_searchController != null) {
          _newsViewModel.resetSearch();
          _searchController.clear();
        }
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      icon: Icon(Icons.close, color: Colors.black),
    );
  }

  SliverList buildNewsSuccessfulFulfilled(NewsViewModel _newsViewModel) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Card(
          elevation: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailsPage(
                    link: _newsViewModel.newsList[index].link,
                    title: _newsViewModel.newsList[index].title,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                CachedNetworkImage(
                  errorWidget: (context, url, object) =>
                      buildCacheImageErrorWidget(),
                  placeholder: (context, url) => buildCacheImagePlaceHolder,
                  imageUrl: _newsViewModel.newsList[index].imageUrl,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
                ListTile(
                  title: Text(_newsViewModel.newsList[index].title),
                  subtitle: Text(_newsViewModel.newsList[index].description),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, top: 5.0, bottom: 5.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        TimeAgo.timeAgoSinceDate(
                          _newsViewModel.newsList[index].pubDate.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: _newsViewModel.newsList.length),
    );
  }

  SliverToBoxAdapter buildNewsErrorRejected(NewsViewModel _newsViewModel) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hoop! Birşeyler yanlış gitti'),
            RaisedButton(
              child: Text('Yenile'),
              onPressed: () async {
                await _newsViewModel.retry(box.get('newsSource') ??
                    'https://www.aa.com.tr/tr/rss/default?cat=');
              },
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildNewsPending() {
    return SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container buildCacheImageErrorWidget() => Container(
        height: 210,
        color: Colors.grey[200],
        child: Center(
          child: Icon(Icons.broken_image_rounded),
        ),
      );

  Container get buildCacheImagePlaceHolder => Container(
        height: 210,
        color: Colors.grey[200],
      );

  List<Widget> getCategoryWidgets(NewsViewModel _newsViewModel) {
    categories.forEach((key, value) {
      categoryWidgets.add(getCategoryWidget(key, value, _newsViewModel));
    });

    return categoryWidgets;
  }

  Widget getCategoryWidget(key, value, NewsViewModel _newsViewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FlatButton(
        onPressed: () {
          _newsViewModel.getNewsCategory(key);
        },
        child: Text(
          value,
          style: TextStyle(color: Colors.blueGrey),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
