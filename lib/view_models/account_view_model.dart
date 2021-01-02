import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:multicamp_flutter_project/models/account.dart';
import 'package:multicamp_flutter_project/services/firebase_auth_service.dart';
import 'package:multicamp_flutter_project/services/firebase_storage_service.dart';
import 'package:multicamp_flutter_project/services/firestore_db_service.dart';

import '../locator.dart';
part 'account_view_model.g.dart';

enum AccountState { Idle, Busy }

class AccountViewModel = _AccountViewModelBase with _$AccountViewModel;

abstract class _AccountViewModelBase with Store {
  final FirebaseAuthService _authService = locator<FirebaseAuthService>();
  final FireStoreDBService _dbService = locator<FireStoreDBService>();
  final FirebaseStorageService _storageService =
      locator<FirebaseStorageService>();
  @observable
  AccountState accountState = AccountState.Busy;

  @observable
  Account account;

  @observable
  bool isLogin = false;

  @action
  Future<Account> currentAccount() async {
    try {
      accountState = AccountState.Busy;
      account = await _authService.currentAccount();
      if (account != null) {
        account = await _dbService.readAccount(account.uid);
        isLogin = true;
        return account;
      } else {
        return null;
      }
    } catch (e) {
      print("View model current account error:" + e.toString());
      return null;
    } finally {
      accountState = AccountState.Idle;
    }
  }

  @action
  Future<bool> signOut() async {
    try {
      accountState = AccountState.Busy;
      bool _accountResult = await _authService.signOut();

      isLogin = false;
      return _accountResult;
    } catch (e) {
      print("View model signOut error:" + e.toString());
      return false;
    } finally {
      accountState = AccountState.Idle;
    }
  }

  @action
  Future<Account> signInWithGoogle() async {
    try {
      accountState = AccountState.Busy;
      var _authAccountResult = await _authService.signInWithGoogle();
      if (_authAccountResult != null) {
        bool _result = await _dbService.saveAccount(_authAccountResult);
        if (_result) {
          account = await _dbService.readAccount(_authAccountResult.uid);
          isLogin = true;
          return account;
        } else {
          await _authService.signOut();
          return null;
        }
      } else
        return null;
    } finally {
      accountState = AccountState.Idle;
    }
  }

  @action
  Future<Account> createUserWithEmailPassword(
      String email, String password, String fullName) async {
    try {
      accountState = AccountState.Busy;
      var _authAccountResult = await _authService.createUserWithEmailPassword(
          email, password, fullName);
      bool _result = await _dbService.saveAccount(_authAccountResult);
      if (_result) {
        account = await _dbService.readAccount(_authAccountResult.uid);
        isLogin = true;
        return account;
      } else {
        return null;
      }
    } finally {
      accountState = AccountState.Idle;
    }
  }

  @action
  Future<Account> signInWithEmailPassword(String email, String password) async {
    try {
      accountState = AccountState.Busy;
      var _authAccountResult =
          await _authService.signInWithEmailPassword(email, password);
      account = await _dbService.readAccount(_authAccountResult.uid);
      isLogin = true;
      return account;
    } finally {
      accountState = AccountState.Idle;
    }
  }

  @action
  Future<String> uploadFile(
      String accoutID, String fileType, File uploadingFile) async {
    var urlResult =
        await _storageService.uploadFile(accoutID, fileType, uploadingFile);
    await _dbService.updatePhotoUrl(accoutID, urlResult);
    return urlResult;
  }

  @action
  Future<bool> fullNameUpdate(String accoutID, String newFullName) async {
    var result = await _dbService.updateFullName(accoutID, newFullName);
    if (result) {
      account.fullName = newFullName;
    }
    return result;
  }
}
