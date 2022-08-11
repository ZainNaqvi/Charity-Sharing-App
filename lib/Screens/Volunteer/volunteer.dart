import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/firebase_auth/firebase_auth.dart';
import '../auth_screens/signin_screen.dart';

class VolunteerMain extends StatefulWidget {
  const VolunteerMain({Key? key}) : super(key: key);

  @override
  State<VolunteerMain> createState() => _VolunteerMainState();
}

class _VolunteerMainState extends State<VolunteerMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Volunteer"),
         actions: [
          ElevatedButton(
              onPressed: () async {
                Firebaseauth firebaseauth = Firebaseauth();
                String res = await firebaseauth.signOut();
                if (res == 'success') {
                  Get.to(const SignIn());
                } else {
                  return;
                }
              },
              child: const Text("log out "))
        ],
      ),
    );
  }
}