import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Screens/DonorScreens/add_donation.dart';
import '../Screens/Request/add_request.dart';
import '../Screens/Volunteer/volunteer.dart';

Widget customButton(String btnName, int btnId) {
  return Column(
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
                  blurRadius: 12)
            ]),
        width: 150.w,
        height: 50.h,
        child: Center(
            child: InkWell(
          onTap: (() => {
                if (btnId == 1)
                  {
                    Get.to(const AddDonation()),
                  }
                else if (btnId == 2)
                  {
                    Get.to(const AddRequest()),
                  }
                else if (btnId == 3)
                  {}
                else if (btnId == 4)
                  {
                    Get.to(const VolunteerMain()),
                  }
              }),
          child: Text(
            btnName,
            style: const TextStyle(
                fontSize: 16, fontFamily: "Rubik Medium", color: Colors.black),
          ),
        )),
      )
    ],
  );
}
