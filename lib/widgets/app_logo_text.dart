import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Column AppLogoText() {
  return Column(
    children: [
      SizedBox(
        height: 24.h,
      ),
// APP-LOGO APP-TITLE-TEXT
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: 50.h,
            image: const AssetImage("assets/logo/donateLogo.jpg"),
          ),
          SizedBox(
            width: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Charity Sharing",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik Medium',
                    color: Colors.black),
              ),
              Text(
                "App",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik Medium',
                    color: Colors.orange),
              ),
            ],
          )
        ],
      ),

      SizedBox(
        height: 20.h,
      ),
      // Add Donation Text
      const Center(
          child: Text(
        "Add Your Donation ",
        style: TextStyle(
            fontSize: 24, fontFamily: 'Rubik Medium', color: Colors.black),
      )),

      SizedBox(
        height: 14.h,
      ),

      const Center(
          child: Text(
        "Feeding some one is the highest \nReward you can give to humanity",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontFamily: 'Rubik Regular', color: Colors.orange),
      )),
      SizedBox(
        height: 24.h,
      ),
    ],
  );
}
