import 'package:charity/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebaseauth {
  // now first we have to craate the instance of the firebase auth

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // this is the firebase auth instance now we also have to use the firestore so lets do it

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // as we know that we have to  sign up or create the user first so what we do lets see
  // first we have to create the function
  Future<String> createUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String location,
  }) 
  async {
// Function return the fucture Responce in String so
    String res = "Some Error occured ";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

// creating the user model object here
      UserModel user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        location: location,
      );
// creating the collection and setting it a value of UserModel
      await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());
// if collection is genertaed successfully and data is set to it then
      res = "success";
    } catch (e) {
      // else any error occurs
      res = e.toString();
    }
    return res;
  }
  
  // here the sign up is completed and now the sign In 
  
  
  Future<String> signIn({
    required String email,
    required String password,
  }) 
  async {
// Function return the fucture Responce in String so
    String res = "Some Error occured ";

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
   
      // if successfully signed in then 
      res = "success";
    } catch (e) {
      //else display the error!
      res = e.toString();
    }
    return res;
  }

  // signout
  
  Future<String> signOut() async {
    String res = "Some error Occured";
    try {
      await _auth.signOut();
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
