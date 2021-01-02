import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Account {
  final String uid;
  String email;
  String fullName;
  String photoUrl;
  DateTime createdAt;

  Account(
      {@required this.uid,
      @required this.email,
      @required this.fullName,
      this.photoUrl,
      this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "fullName": fullName,
      "photoUrl": photoUrl ?? "assets/images/avatar.jpg",
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  Account.fromMap(Map<String, dynamic> map)
      : uid = map["uid"],
        email = map["email"],
        fullName = map["fullName"],
        photoUrl = map["photoUrl"],
        createdAt = (map["createdAt"] as Timestamp).toDate();

  Account.uidAndPhotoUrl({@required this.uid, @required this.photoUrl});

  @override
  String toString() {
    return 'Account{uid: $uid, email: $email, fullName: $fullName, photoUrl: $photoUrl, createdAt: $createdAt}';
  }
}
