import 'package:flutter/cupertino.dart';
class ExpiryDate extends ChangeNotifier{


   final _dateOfBirthController = TextEditingController();
    get dob =>_dateOfBirthController; 

    void setExpDate(value)
    {
         _dateOfBirthController.text=value.toString();
         notifyListeners();
    }
}