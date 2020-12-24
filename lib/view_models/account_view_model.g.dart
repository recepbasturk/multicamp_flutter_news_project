// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountViewModel on _AccountViewModelBase, Store {
  final _$accountStateAtom = Atom(name: '_AccountViewModelBase.accountState');

  @override
  AccountState get accountState {
    _$accountStateAtom.reportRead();
    return super.accountState;
  }

  @override
  set accountState(AccountState value) {
    _$accountStateAtom.reportWrite(value, super.accountState, () {
      super.accountState = value;
    });
  }

  final _$accountAtom = Atom(name: '_AccountViewModelBase.account');

  @override
  Account get account {
    _$accountAtom.reportRead();
    return super.account;
  }

  @override
  set account(Account value) {
    _$accountAtom.reportWrite(value, super.account, () {
      super.account = value;
    });
  }

  final _$currentAccountAsyncAction =
      AsyncAction('_AccountViewModelBase.currentAccount');

  @override
  Future<Account> currentAccount() {
    return _$currentAccountAsyncAction.run(() => super.currentAccount());
  }

  final _$signOutAsyncAction = AsyncAction('_AccountViewModelBase.signOut');

  @override
  Future<bool> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$signInWithGoogleAsyncAction =
      AsyncAction('_AccountViewModelBase.signInWithGoogle');

  @override
  Future<Account> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  final _$createUserWithEmailPasswordAsyncAction =
      AsyncAction('_AccountViewModelBase.createUserWithEmailPassword');

  @override
  Future<Account> createUserWithEmailPassword(String email, String password) {
    return _$createUserWithEmailPasswordAsyncAction
        .run(() => super.createUserWithEmailPassword(email, password));
  }

  final _$signInWithEmailPasswordAsyncAction =
      AsyncAction('_AccountViewModelBase.signInWithEmailPassword');

  @override
  Future<Account> signInWithEmailPassword(String email, String password) {
    return _$signInWithEmailPasswordAsyncAction
        .run(() => super.signInWithEmailPassword(email, password));
  }

  @override
  String toString() {
    return '''
accountState: ${accountState},
account: ${account}
    ''';
  }
}
