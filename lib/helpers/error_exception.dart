class Errors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'The email address is already in use by another account.':
        return 'E-posta adresi zaten başka bir hesap tarafından kullanılıyor.';
      case 'There is no user record corresponding to this identifier. The user may have been deleted.':
        return 'Bu tanımlayıcıya karşılık gelen bir kullanıcı kaydı yok. Kullanıcı silinmiş olabilir.';
      case 'The password is invalid or the user does not have a password.':
        return 'Parola geçersiz veya kullanıcının parolası yok.';
      case 'The email address is badly formatted.':
        return 'E-posta adresi kötü biçimlendirilmiş.';
      default:
        return 'Hata Mesajı: ' + errorCode;
    }
  }
}
