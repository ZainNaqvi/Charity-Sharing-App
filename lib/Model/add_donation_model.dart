import 'dart:typed_data';

class AddDonationModel {
  late String id;
  late String name;
  late String title;
  late String quantity;
  late String description;
  late String category;
  late String pickUpLock;
  late String pickUpDate;
  late String pickUpTime;
  late String expiryDate;

  AddDonationModel({
    required this.id,
    required this.name,
    required this.title,
    required this.quantity,
    required this.category,
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
  String getCategoty() => category;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "quantity": quantity,
        "description": description,
        "category": category,
        "pickUpLock": pickUpLock,
        "pickUpDate": pickUpDate,
        "pickUpTime": pickUpTime,
        "expiryDate": expiryDate,
      };
  AddDonationModel.fromJson(Map<String, dynamic> json) {
    AddDonationModel(
      id: json['id'],
      name: json['name'],
      title: json["title"],
      quantity: json["quantity"],
      category: json["category"],
      description: json["description"],
      pickUpLock: json["pickUpLock"],
      pickUpDate: json["pickUpDate"],
      pickUpTime: json["pickUpTime"],
      expiryDate: json["expiryDate"],
    );
  }
}
