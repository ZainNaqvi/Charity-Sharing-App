
class AddDonationModel {
  late String id;
  late String name;
  late String title;
  late String quantity;
  late String description;
  late String category;
  late String pickUpLocation;
  late String donationDescription;

  late String attachment;
  AddDonationModel({
    required this.id,
    required this.name,
    required this.title,
    required this.quantity,
    required this.category,
    required this.description,
    required this.pickUpLocation,
    required this.donationDescription,
    required this.attachment,

  });

  String getId() => id;
  String getTitle() => title;
  String getName() => name;
  String getQuantity() => quantity;
  String getDescription() => description;
  String getPickUpLocation() => pickUpLocation;
  String getdonationDescription() => donationDescription;
  String getCategoty() => category;
  String getattachment() => attachment;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "quantity": quantity,
        "description": description,
        "category": category,
        "pickUpLocation": pickUpLocation,
        "donationDescription": donationDescription,
        "attachment": attachment,
   
      };
  AddDonationModel.fromJson(Map<String, dynamic> json) {
    AddDonationModel(
   
      id: json['id'],
      name: json['name'],
      title: json["title"],
      quantity: json["quantity"],
      category: json["category"],
      description: json["description"],
      pickUpLocation: json["pickUpLocation"],
      donationDescription: json["donationDescription"],
      attachment: json["attachment"],

    );
  }
}
