import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:multicamp_flutter_project/view_models/account_view_model.dart';

import '../locator.dart';
import 'home_page.dart';
import 'login_register_select_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      final AccountViewModel _accountViewModel = locator<AccountViewModel>();
      _accountViewModel.currentAccount();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AccountViewModel _accountViewModel = locator<AccountViewModel>();
    return Observer(
      builder: (_) {
        if (_accountViewModel.accountState == AccountState.Idle) {
          if (_accountViewModel.isLogin == false) {
            return LoginRegisterSelectPage();
          } else {
            return HomePage();
          }
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
