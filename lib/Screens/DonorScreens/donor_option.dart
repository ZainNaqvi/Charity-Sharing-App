import 'package:charity/Screens/DonorScreens/add_donation.dart';
import 'package:charity/Screens/DonorScreens/view_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/firebase_auth/firebase_auth.dart';
import '../auth_screens/signin_screen.dart';

class DonorOption extends StatefulWidget {
  const DonorOption({Key? key}) : super(key: key);

  @override
  State<DonorOption> createState() => _DonorOptionState();
}

class _DonorOptionState extends State<DonorOption> {

void chkLogOut() async
{
   Firebaseauth firebaseauth = Firebaseauth();
                String res = await firebaseauth.signOut();
                if (res == 'success') {
                  Get.to(const SignIn());
                } else {
                  return;
                }
}

Widget customButton(String btnName, int btnId)
  {
    return  Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  border: Border.all(
                    color: Colors.orange,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.9),
              spreadRadius: 10,
              blurRadius: 12
            )
          ]
                  ),
                  width: 150.w,
                  height: 50.h,
                  child: Center(child: InkWell(
                    onTap: (() => {
                      if(btnId==1)
                      {
                        Get.to(const AddDonation()),
                      }
                      else if(btnId==2)
                      {
                        Get.to(const ViewRequest()),
                      }
                       else if(btnId==3)
                      {
                     chkLogOut(),
                      }
                    }
                    ),
                    child: Text(btnName,style:  const TextStyle(
                              fontSize: 16, fontFamily: "Rubik Medium", color: Colors.black),),
                  )),
            )
          ],
        ),
      );
   
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor Option"),
        actions: [
          ElevatedButton(
              onPressed: () async {
             chkLogOut();
              },
              child: const Text("log out "))
        ],
      
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customButton("Add Donation",1),

          SizedBox(height: 40.h,),

          customButton("View Requests",2),

            SizedBox(height: 40.h,), 

          customButton("Log out",3),

           SizedBox(height: 40.h,), 
        ],
      )
    );
  }
}
