import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../Model/add_donation_model.dart';

class FirebsaeMethods {
  // firebase firestore k methods fucntion
  // first to create the instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // instance

  Future<String> addDonation({
    required String title,
    required String name,
    required String quantity,
    required String category,
    required String description,
    required String pickUpLocation,
    required String donationDescription,
    required String attachment,

  }) async {
    String res = "Some error occured";
    try {
      // creating and initailizing the add donotion model  here
      AddDonationModel addDonationModel = AddDonationModel(
        id: FirebaseAuth.instance.currentUser!.uid,
        name: name,
        title: title,
        quantity: quantity,
        category: category,
        description: description,
        pickUpLocation: pickUpLocation,
        donationDescription: donationDescription,
        attachment: attachment,
   
      );

      String id = const Uuid().v1();
      // this is becasue q k ager user more then one entery karta hai
      // to woh sari enteries show hoon is lye id ka variable use kia aur us k lye  uuid package  install kia pub
      //pubspec.yaml file main
      await _firestore
          .collection("DonatedItems")
          .doc(id)
          .set(addDonationModel.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
