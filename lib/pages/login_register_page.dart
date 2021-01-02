import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:multicamp_flutter_project/helpers/error_exception.dart';
import 'package:multicamp_flutter_project/view_models/account_view_model.dart';

import '../locator.dart';

enum FormType { Login, Register }

class LoginRegisterWidget extends StatefulWidget {
  final FormType formType;

  const LoginRegisterWidget({Key key, this.formType}) : super(key: key);

  @override
  _LoginRegisterWidgetState createState() =>
      _LoginRegisterWidgetState(this.formType);
}

class _LoginRegisterWidgetState extends State<LoginRegisterWidget> {
  FormType formType;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  bool _passwordVisible = true;
  String _titleAndButtonText, _linkText, _googleText;

  _LoginRegisterWidgetState(this.formType);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _titleAndButtonText = formType == FormType.Login ? 'Giriş Yap' : 'Kaydol';
    _linkText = formType == FormType.Login
        ? 'Hesabın yok mu? Kaydol'
        : 'Hesabın var mı? Giriş yap';
    _googleText = formType == FormType.Login
        ? 'Google ile Giriş Yap'
        : 'Google ile kaydol';

    final AccountViewModel _accountViewModel = locator<AccountViewModel>();
    return Observer(
      builder: (_) {
        if (_accountViewModel.isLogin == true) {
          Future.delayed(Duration(milliseconds: 1), () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          });
        }
        return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(_titleAndButtonText),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: 150.0),
                SizedBox(height: 10.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextFormFieldFullName,
                      SizedBox(height: 10.0),
                      buildTextFormFieldEmail,
                      SizedBox(height: 10.0),
                      buildTextFormFieldPassword,
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: RaisedButton(
                          color: Color(0xFF4267b2),
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _formSubmit();
                          },
                          child: Text(
                            _titleAndButtonText,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.blueGrey,
                              thickness: 2,
                            ),
                          ),
                          Text(' YA DA ', style: TextStyle(fontSize: 15)),
                          Expanded(
                            child: Divider(
                              color: Colors.blueGrey,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0, left: 50.0),
                        child: InkWell(
                          onTap: () {
                            _googleSignIn(_accountViewModel);
                          },
                          child: Card(
                            elevation: 12,
                            child: ListTile(
                              leading: Image.asset(
                                'assets/images/google-logo.png',
                                height: 30.0,
                              ),
                              title: Text(
                                _googleText,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          _formTypeChange();
                        },
                        child: Text(
                          _linkText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get buildTextFormFieldFullName {
    if (formType == FormType.Register) {
      return TextFormField(
        controller: _fullName,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.supervised_user_circle),
          hintText: 'Adı Soyadı',
          contentPadding: EdgeInsets.all(16.0),
        ),
        validator: _fullNameValidator,
      );
    } else {
      return SizedBox();
    }
  }

  TextFormField get buildTextFormFieldEmail {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        hintText: 'E-posta',
        contentPadding: EdgeInsets.all(16.0),
      ),
      validator: _emailValidator,
    );
  }

  TextFormField get buildTextFormFieldPassword {
    return TextFormField(
      controller: _passwordController,
      obscureText: _passwordVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        suffix: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.blue,
            size: 20.0,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        hintText: 'Şifre',
        hintStyle: TextStyle(fontSize: 20),
        contentPadding: EdgeInsets.all(2.0),
      ),
      validator: _passwordValidator,
    );
  }

  void _formSubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final AccountViewModel _accountViewModel = locator<AccountViewModel>();

      if (formType == FormType.Login) {
        try {
          await _accountViewModel.signInWithEmailPassword(
              _emailController.text, _passwordController.text);
        } on PlatformException catch (e) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(Errors.show(e.message))));
        } catch (e) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(Errors.show(e.message))));
        }
      } else {
        try {
          await _accountViewModel.createUserWithEmailPassword(
              _emailController.text, _passwordController.text, _fullName.text);
        } on PlatformException catch (e) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(Errors.show(e.message))));
        } catch (e) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(Errors.show(e.message))));
        }
      }
    }
  }

  String _emailValidator(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(mail)) {
      return 'Geçersiz E-posta adresi';
    } else {
      return null;
    }
  }

  String _passwordValidator(String password) {
    if (password.length < 6) {
      return "En az 6 karakter gereki";
    } else {
      return null;
    }
  }

  String _fullNameValidator(String fullName) {
    RegExp regex = RegExp(r'^[a-z A-ZğüşöçİĞÜŞÖÇ]+$');
    if (!regex.hasMatch(fullName))
      return 'Boş olamaz ve numara içeremez';
    else
      return null;
  }

  Future<void> _googleSignIn(AccountViewModel _accountViewModel) async {
    try {
      await _accountViewModel.signInWithGoogle();
    } on PlatformException catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _formTypeChange() {
    setState(() {
      formType =
          formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }
}
