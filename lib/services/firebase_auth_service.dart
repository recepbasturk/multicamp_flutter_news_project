import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multicamp_flutter_project/models/account.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Account> currentAccount() async {
    try {
      User _account = _auth.currentUser;
      return _accountFromFirebase(_account);
    } catch (e) {
      print("Current Account Error" + e.toString());
    }
    return null;
  }

  Future<Account> createUserWithEmailPassword(
      String email, String password, String fullName) async {
    UserCredential _result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _accountFromFirebase(_result.user, fullName);
  }

  Future<Account> signInWithEmailPassword(String email, String password) async {
    UserCredential _result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return _accountFromFirebase(_result.user);
  }

  Future<Account> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential _result = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: _googleAuth.idToken,
              accessToken: _googleAuth.accessToken),
        );
        User _account = _result.user;
        return _accountFromFirebase(
            _account, _account.displayName, _account.photoURL);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      final _googleSignIn = GoogleSignIn();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      }
      return true;
    } catch (e) {
      print("Sign out error" + e.toString());
    }
    return false;
  }

  Account _accountFromFirebase(User user, [String fullName, String photoUrl]) {
    if (user == null) {
      return null;
    } else {
      return Account(
        uid: user.uid,
        email: user.email,
        fullName: fullName,
        photoUrl: photoUrl,
      );
    }
  }
}
