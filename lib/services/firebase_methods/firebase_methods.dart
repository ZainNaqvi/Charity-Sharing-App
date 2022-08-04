import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../Model/add_donation_model.dart';

class FirebsaeMethods {
  // firebase firestore k methods fucntion
  // first to create the instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<String> addDonation({
    required String title,
    required String name,
    required String quantity,
    required String description,
    required String pickUpLock,
     required String pickUpDate,
    required String pickUpTime,
    required String expDate,
  })async {
    // good now the loign
    String res = "Some error occured";
    try {
      // creating and initailizing the add donotion modeln here
      AddDonationModel addDonationModel = AddDonationModel(
          id: FirebaseAuth.instance.currentUser!.uid,
          name: name,
          title: title,
          quantity: quantity,
          description: description,
          pickUpLock: pickUpLock,
          pickUpDate: pickUpDate,
          pickUpTime: pickUpTime,
          expiryDate: expDate);
   
   String id = const Uuid().v1();


    await  _firestore
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
