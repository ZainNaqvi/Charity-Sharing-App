import 'package:charity/Screens/DonorScreens/add_donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Screens/auth_screens/signin_screen.dart';
import '../services/firebase_auth/firebase_auth.dart';
import 'custom_drawers_buttons.dart';
import '../../widgets/default_button.dart';

Container MyDrawer(BuildContext context) {
  return Container(
    width: 250.h,
    child: Drawer(
      backgroundColor: Colors.orange,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Hussnul Maab"),
            accountEmail: Text("mabi123@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "H",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text("Donate"),
            onTap: () {
              Get.defaultDialog(
                title: "",
                content: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: Column(
                    children: [
                      DefaultButton(
                          text: "Add Donation",
                          onPressed: () {
                            Get.to(const AddDonation());
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      DefaultButton(text: "View Request", onPressed: () {}),
                    ],
                  ),
                ),
                radius: 10.0,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Request"),
            onTap: () {
              Get.defaultDialog(
                title: "",
                content: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: Column(
                    children: [
                      DefaultButton(
                          text: "Add Request",
                          onPressed: () {
                            Get.to(const AddDonation());
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      DefaultButton(
                          text: "View Active Donation", onPressed: () {}),
                    ],
                  ),
                ),
                radius: 10.0,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text("Volunteer"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text("Log out"),
            onTap: () async {
              Firebaseauth firebaseauth = Firebaseauth();
              String res = await firebaseauth.signOut();
              if (res == 'success') {
                Get.to(const SignIn());
              } else {
                return;
              }
            },
          ),
        ],
      ),
    ),
  );
}
