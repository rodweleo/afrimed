import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/Account.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  Account? _account;

  User? get user => _user;
  Account? get account => _account;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void setAccount(Account? account) {
    _account = account;
    notifyListeners();
  }
}
