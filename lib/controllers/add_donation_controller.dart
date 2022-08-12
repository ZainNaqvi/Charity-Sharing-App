
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddMoreList extends GetxController {
  var list = [];

  addToList({
    required String title,
    required String itemName,
    required String quantity,
    required String donationDescription,
    required String pickUpLocation,
    required String description,
    required String attachment,
    required String category,
    // required Uint8List urlOfImg,
  }) {

    list.add({
      "title": title,
      "itemName": itemName,
      "quantity": quantity,
      "description": description,
      "category":category,
      "pickUpLocation": pickUpLocation,
      "donationDescription": donationDescription,
      "attachment": attachment,
    });

     Get.snackbar(
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.black,
                                  "Message",
                                  "item added successfully"); 
print(list.length);
    update();
  }
}
