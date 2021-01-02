import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multicamp_flutter_project/models/account.dart';

class FireStoreDBService {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  Future<bool> saveAccount(Account account) async {
    DocumentSnapshot _readAccount =
        await _firebaseDB.collection('accounts').doc('${account.uid}').get();

    if (_readAccount.data() == null) {
      await _firebaseDB
          .collection('accounts')
          .doc(account.uid)
          .set(account.toMap());
      return true;
    } else {
      return true;
    }
  }

  Future<Account> readAccount(String accountID) async {
    DocumentSnapshot _readAccount =
        await _firebaseDB.collection('accounts').doc(accountID).get();
    Map<String, dynamic> _readAccountInformationMap = _readAccount.data();
    Account _readAccountObject = Account.fromMap(_readAccountInformationMap);
    return _readAccountObject;
  }

  Future<bool> updateFullName(String accountID, String fullName) async {
    var account = await _firebaseDB
        .collection('accounts')
        .where('fullName', isEqualTo: fullName)
        .get();
    if (account.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection('accounts')
          .doc(accountID)
          .update({'fullName': fullName});
      return true;
    }
  }

  Future<bool> updatePhotoUrl(String accountID, String photoUrl) async {
    await _firebaseDB
        .collection('accounts')
        .doc(accountID)
        .update({'photoUrl': photoUrl});
    return true;
  }
}
