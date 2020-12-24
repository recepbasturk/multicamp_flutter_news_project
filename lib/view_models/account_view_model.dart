import 'package:mobx/mobx.dart';
import 'package:multicamp_flutter_project/models/account.dart';
import 'package:multicamp_flutter_project/services/firebase_auth_service.dart';

import '../locator.dart';
part 'account_view_model.g.dart';

enum AccountState { Idle, Busy }

class AccountViewModel = _AccountViewModelBase with _$AccountViewModel;

abstract class _AccountViewModelBase with Store {
  final FirebaseAuthService _authService = locator<FirebaseAuthService>();

  @observable
  AccountState accountState = AccountState.Busy;

  @observable
  Account account;

  @action
  Future<Account> currentAccount() async {
    try {
      accountState = AccountState.Busy;
      account = await _authService.currentAccount();
      if (account != null) {
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
      bool accountResult = await _authService.signOut();
      account = null;
      return accountResult;
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
      account = await _authService.signInWithGoogle();
      if (account != null)
        return account;
      else
        return null;
    } finally {
      accountState = AccountState.Idle;
    }
  }

  @action
  Future<Account> createUserWithEmailPassword(
      String email, String password) async {
    try {
      accountState = AccountState.Busy;
      account = await _authService.createUserWithEmailPassword(email, password);
      return account;
    } finally {
      accountState = AccountState.Idle;
    }
  }

  @action
  Future<Account> signInWithEmailPassword(String email, String password) async {
    try {
      accountState = AccountState.Busy;
      account = await _authService.signInWithEmailPassword(email, password);
      return account;
    } finally {
      accountState = AccountState.Idle;
    }
  }
}
