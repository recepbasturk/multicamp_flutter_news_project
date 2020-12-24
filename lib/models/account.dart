import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Account {
  final String accountID;
  String email;
  String fullName;
  String profilePhoto;
  DateTime createdAt;

  Account({@required this.accountID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      "accountID": accountID,
      "email": email,
      "fullName": fullName,
      "profilePhoto": profilePhoto ?? "images/avatar.jpg",
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  Account.fromMap(Map<String, dynamic> map)
      : accountID = map["accountID"],
        email = map["email"],
        fullName = map["fullName"],
        profilePhoto = map["profilePhoto"],
        createdAt = (map["createdAt"] as Timestamp).toDate();

  Account.accountIDAndPhoto(
      {@required this.accountID, @required this.profilePhoto});

  @override
  String toString() {
    return 'Account{accountID: $accountID, email: $email, fullName: $fullName, profilePhoto: $profilePhoto, createdAt: $createdAt}';
  }
}
