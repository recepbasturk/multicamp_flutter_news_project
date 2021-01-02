import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:multicamp_flutter_project/pages/profile_page.dart';
import 'package:multicamp_flutter_project/pages/settings_page.dart';
import 'package:multicamp_flutter_project/view_models/account_view_model.dart';

import '../locator.dart';

class DrawerMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Observer(
      builder: (_) {
        final AccountViewModel _accountViewModel = locator<AccountViewModel>();
        return Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                _accountViewModel.account.fullName,
                style: TextStyle(fontSize: 20),
              ),
              accountEmail: Text(_accountViewModel.account.email,
                  style: TextStyle(fontSize: 15)),
              currentAccountPicture: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  backgroundImage: _accountViewModel.account.photoUrl ==
                          "assets/images/avatar.png"
                      ? AssetImage(_accountViewModel.account.photoUrl)
                      : NetworkImage(_accountViewModel.account.photoUrl)),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ));
                    },
                    splashColor: Colors.blueGrey,
                    child: ListTile(
                      leading: Icon(Icons.account_box),
                      title: Text("Profil"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ));
                    },
                    splashColor: Colors.cyan,
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Ayarlar"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LicensePage(),
                      ));
                    },
                    splashColor: Colors.cyan,
                    child: ListTile(
                      leading: Icon(Icons.wysiwyg),
                      title: Text("Lisanslar"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  AboutListTile(
                    applicationName: "MultiCamp Flutter News Project",
                    applicationIcon: Icon(Icons.save),
                    applicationVersion: "1.0.0",
                    child: Text("Hakkında"),
                    applicationLegalese: "MultiCamp Flutter Haberler Projesi",
                    icon: Icon(Icons.keyboard),
                    aboutBoxChildren: <Widget>[
                      Text("Geliştirici : Recep Baştürk"),
                      Text("E-posta : recepbasturk@gmail.com"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ));
  }
}
