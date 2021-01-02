import 'package:flutter/material.dart';

import 'login_register_page.dart';

class LoginRegisterSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('MultiCamp Flutter Haber'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.only(right: 50.0, left: 50.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => LoginRegisterWidget(
                      formType: FormType.Login,
                    ),
                  ));
                },
                child: Card(
                  color: Color(0xFF4267b2),
                  elevation: 12,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Giriş Yap',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.only(right: 50.0, left: 50.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => LoginRegisterWidget(
                      formType: FormType.Register,
                    ),
                  ));
                },
                child: Card(
                  color: Color(0xFFfd4350),
                  elevation: 12,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Kaydol',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
