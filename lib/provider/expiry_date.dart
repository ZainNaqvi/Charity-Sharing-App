
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
class ExpiryDate extends ChangeNotifier{


   final  TextEditingController _dateOfBirthController = TextEditingController();
   final TextEditingController _pickUpTimeController=TextEditingController();
   final TextEditingController _pickUpDateController=TextEditingController();
  

    get dob =>_dateOfBirthController; 
    get pickTime => _pickUpTimeController;
    get pickDate => _pickUpDateController;
 

      setExpDate(value)
    {
      // for expiry date 
         _dateOfBirthController.text= DateFormat.yMd().format(value) ;
         notifyListeners();
        
    }
       setPickUpDate(value)
    {
      // for date pick 
         _pickUpDateController.text= DateFormat.yMd().format(value) ;
           notifyListeners();
    
       
    }
       setPickUpTime(value)
    {    

      // for pick time 

        // _hour = value
        // /.hour.toString();
        // _minute= value.minute.toString();
        // _time= "$_hour : $_minute";
        _pickUpTimeController.text= value;
         _pickUpTimeController.text= formatDate(
          DateTime(2019,08,1,value.hour,value.minute), [hh, ':', nn, " ", am]).toString();
              notifyListeners();
      
         
        
    }
}