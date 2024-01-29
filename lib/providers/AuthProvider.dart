import 'package:flutter/foundation.dart';
import '../models/Account.dart';

class AuthProvider with ChangeNotifier {
  Account? _account;

  Account? get account => _account;

  void setLoggedInAccount(Account account) {
    _account = account;
    notifyListeners();
  }

  Account? getCurrentAccount() {
    return _account;
  }

  void logout(){
    //set the account to null
    _account = null;
    notifyListeners();
  }

}
