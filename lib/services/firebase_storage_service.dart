import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference _storageReference;
  Future<String> uploadFile(
      String userID, String fileType, File uploadingFile) async {
    _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child('profile_photo.png');
    TaskSnapshot uploadTask = await _storageReference.putFile(uploadingFile);
    var urlResult = await (uploadTask).ref.getDownloadURL();
    return urlResult;
  }
}
