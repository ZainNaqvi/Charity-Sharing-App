import 'dart:math';

import 'package:get/get_connect/http/src/utils/utils.dart';

class AddDonationModel {
  late String id;
  late String name;
  late String title;
  late String quantity;
  late String description;
  late String pickUpLock;
  late String pickUpDate;
  late String pickUpTime;
  late String expiryDate;
  AddDonationModel({
    required this.id,
    required this.name,
    required this.title,
    required this.quantity,
    required this.description,
    required this.pickUpLock,
     required this.pickUpDate,
    required this.pickUpTime,
    required this.expiryDate,
  });

  String getId() => id;
  String getTitle() => title;
  String getName() => name;
  String getQuantity() => quantity;
  String getDescription() => description;
  String getPickUpLocation() => pickUpLock;
   String getPickUpDate() => pickUpDate;
  String getPickUpTime() => pickUpTime;
  String getExpDate() => expiryDate;
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "quantity": quantity,
        "description": description,
        "pickUpLock": pickUpLock,
        "pickUpDate": pickUpDate,
        "pickUpTime": pickUpTime,
        "expiryDate": expiryDate,

        // i am back
      };
  AddDonationModel.fromJson(Map<String, dynamic> json) {
    // ok main jaldi jaldi likhta hoon

    AddDonationModel(
        id: json['id'],
        name: json['name'],
        title: json["title"],
        quantity: json["quantity"],
        description: json["description"],
        pickUpLock: json["pickUpLock"],
        pickUpDate: json["pickUpDate"],
        pickUpTime: json["pickUpTime"],
        expiryDate: json["expiryDate"]);
  }
}
