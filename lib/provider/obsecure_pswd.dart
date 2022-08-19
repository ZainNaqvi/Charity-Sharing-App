import 'package:flutter/cupertino.dart';

class ObsecurePassword extends ChangeNotifier {
  bool isObsecure = true;

  bool get obsecure => isObsecure;

  void checkMyObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }
}
