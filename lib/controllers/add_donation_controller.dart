import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddMoreList extends GetxController {
  var list = [];

  addToList({
    required String title,
    required String name,
    required String quantity,
    required String description,
    required String pickUpLocation,
    required String pickUpDate,
    required String pickUpTime,
    required String expDate,
    required String category,
    required Uint8List urlOfImg,
  }) {

    list.add({
      "title": title,
      "name": name,
      "quantity": quantity,
      "description": description,
      "category":category,
      "pickUpLock": pickUpLocation,
      "pickUpDate": pickUpDate,
      "pickUpTime": pickUpTime,
      "expDate": expDate,
      "url": urlOfImg,
    });
    // yarrr mein print karana chaaa raha tha k mein check karon k list me object save ho rahe hain k nhii aur next page pe 
    // tabular form me object k through hi print kar sakte hain wase wo page konsa hai jahan pe 
    // list tile lagi hain ?
    // woh hm list k object ko hio show krwa ray hain 
    // addmoreitem_details k name say pageh hai 
     Get.snackbar(
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.black,
                                  "Message",
                                  "item added successfully"); 
print(list.length);
    update();
  }
}
