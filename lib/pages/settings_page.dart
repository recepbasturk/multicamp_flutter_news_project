import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:multicamp_flutter_project/view_models/account_view_model.dart';
import 'package:multicamp_flutter_project/view_models/news_view_model.dart';

import '../locator.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final box = Hive.box(settingsBox);
  final NewsViewModel _newsViewModel = locator<NewsViewModel>();
  final AccountViewModel _accountViewModel = locator<AccountViewModel>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _newsViewModel
        .newsSourceButton(box.get('newsSource') ?? _newsViewModel.newsSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Ayarlar'),
        actions: [
          FlatButton(
            onPressed: () => _signOutValid(context),
            child: Text(
              'Çıkış Yap',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_accountViewModel.isLogin == false) {
            Future.delayed(Duration(milliseconds: 1), () {
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            });
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Text(
                  'Haber Kaynağı Seçimi',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _newsViewModel.newsSourceButton(
                            'https://www.aa.com.tr/tr/rss/default?cat=');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _newsViewModel.aalogoButtonValue
                                  ? Colors.green
                                  : Colors.grey,
                              width: 7.0,
                              style: BorderStyle.solid),
                        ),
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/aalogo.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _newsViewModel.newsSourceButton(
                            'http://www.hurriyet.com.tr/rss/');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _newsViewModel.hurriyetlogoButtonValue
                                  ? Colors.green
                                  : Colors.grey,
                              width: 7.0,
                              style: BorderStyle.solid),
                        ),
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/hurriyetlogo.jpg'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _newsViewModel
                            .newsSourceButton('https://t24.com.tr/rss/haber/');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _newsViewModel.t24logoButtonValue
                                  ? Colors.green
                                  : Colors.grey,
                              width: 7.0,
                              style: BorderStyle.solid),
                        ),
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/t24logo.jpg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    height: 50.0,
                    child: Text(
                      'Değişiklikleri kaydet',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.blueGrey,
                    onPressed: () async {
                      await _newsViewModel
                          .selectNewsSource(_newsViewModel.newsSource);
                      box.clear();
                      box.put('newsSource', _newsViewModel.newsSource);
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text('Haber Kaynağı Değişti')));
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Text('Uygulama Hakkında',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Uygulama Adı'),
                        subtitle: Text('MultiCamp Flutter Haberler Projesi'),
                      ),
                      ListTile(
                        title: Text('Uygulama versiyonu'),
                        subtitle: Text('1.0.0'),
                      ),
                      ListTile(
                        title: Text('Geliştirci adı'),
                        subtitle: Text('Recep Baştürk'),
                      ),
                      ListTile(
                        title: Text('Geliştirci E-posta'),
                        subtitle: Text('recepbasturk@gmail.com'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LicensePage(),
                          ));
                        },
                        child: ListTile(
                          title: Text('Lisanslar'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _signOutValid(context) async {
    final AccountViewModel _accountViewModel = locator<AccountViewModel>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emin misiniz?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Uygulamadan oturum kapatmak istediğinizden emin misiniz?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Onayla'),
              onPressed: () async {
                try {
                  await _accountViewModel.signOut();
                } on PlatformException catch (e) {
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text(e.message)));
                } catch (e) {
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text(e.message)));
                }
              },
            ),
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
