import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multicamp_flutter_project/view_models/account_view_model.dart';

import '../locator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controllerFullName;
  File _profilePhoto;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controllerFullName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerFullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AccountViewModel _accountViewModel = locator<AccountViewModel>();
    _controllerFullName.text = _accountViewModel.account.fullName;
    return Observer(
      builder: (_) {
        if (_accountViewModel.isLogin == false) {
          Future.delayed(Duration(milliseconds: 1), () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          });
        }
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Profil Sayfası'),
            actions: [
              FlatButton(
                onPressed: () => _signOutValid(context),
                child: Text(
                  'Çıkış Yap',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 160,
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.camera),
                                      title: Text('Kamera ile çek'),
                                      onTap: () {
                                        try {
                                          _shootWithCamera();
                                        } catch (e) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                                  content: Text(e.toString())));
                                          return null;
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text('Galeriden Seç'),
                                      onTap: () {
                                        try {
                                          _selectFromGallery();
                                        } catch (e) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                                  content: Text(e.toString())));
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 75.0,
                            backgroundColor: Colors.white,
                            backgroundImage: _profilePhoto == null
                                ? _accountViewModel.account.photoUrl ==
                                        "assets/images/avatar.png"
                                    ? AssetImage(
                                        _accountViewModel.account.photoUrl)
                                    : NetworkImage(
                                        _accountViewModel.account.photoUrl)
                                : FileImage(_profilePhoto),
                          ),
                          Positioned(
                            bottom: 10.0,
                            right: 5.0,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.blueAccent,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: TextFormField(
                      controller: _controllerFullName,
                      decoration: InputDecoration(
                        labelText: 'Adı Soyadı',
                        hintText: 'Adı Soyadı',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 10),
                    child: TextFormField(
                      initialValue: _accountViewModel.account.email,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'E-posta Adresiniz',
                        hintText: 'E-posta',
                      ),
                    ),
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
                      onPressed: () {
                        _fullNameUpdate(context);
                        _profilePhotoUpdate(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

  void _shootWithCamera() async {
    try {
      var newPhoto = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        _profilePhoto = File(newPhoto.path);
        Navigator.of(context).pop();
      });
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  void _selectFromGallery() async {
    try {
      var newPhoto = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _profilePhoto = File(newPhoto.path);
        Navigator.of(context).pop();
      });
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  void _profilePhotoUpdate(BuildContext context) async {
    final AccountViewModel _accountViewModel = locator<AccountViewModel>();
    if (_profilePhoto != null) {
      var url = await _accountViewModel.uploadFile(
          _accountViewModel.account.uid, 'profile_photo', _profilePhoto);
      if (url != null) {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text('Profil Fotoğrafı başarıyla değiştirildi')));
      }
    }
  }

  bool _fullNameValidator(String name) {
    RegExp regex = RegExp(r'^[a-z A-ZğüşöçİĞÜŞÖÇ]+$');
    if (!regex.hasMatch(name))
      return false;
    else
      return true;
  }

  void _fullNameUpdate(BuildContext context) async {
    final AccountViewModel _accountViewModel = locator<AccountViewModel>();

    if (_fullNameValidator(_controllerFullName.text)) {
      if (_accountViewModel.account.fullName != _controllerFullName.text) {
        var updateResult = await _accountViewModel.fullNameUpdate(
            _accountViewModel.account.uid, _controllerFullName.text);
        if (updateResult == true) {
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('Adı Soyadı başarıyla değiştirildi.')));
        }
      }
    } else {
      _controllerFullName.text = _accountViewModel.account.fullName;
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Adı Soyadı boş olamaz ve numara içeremez')));
    }
  }
}
