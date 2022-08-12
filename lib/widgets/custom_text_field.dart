import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myTextField(
    String hintText, Icon preIcon, TextEditingController mycontroller) {
  return Column(
    children: [
      TextFormField(
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 16, fontFamily: "Rubik Medium", color: Colors.black),
          fillColor: Colors.orange,
          prefixIcon: preIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: ((value) {
          if (value!.isEmpty) {
            if (hintText == "Enter Title of Doantion") {
              return "Enter Title Please";
            }
            if (hintText == "Enter Name of Item") {
              return "Enter Name Please";
            }
            if (hintText == "Enter Quantity") {
              return "Enter Quantity Please";
            }
            if (hintText == "Enter Description") {
              return "Enter Description Please";
            }
            if (hintText == "Enter PickUp location") {
              return "Choose PickUp Please";
            }
            if (hintText == "Enter destination location") {
              return "Choose PickUp Please";
            }
          }
          return null;
        }),
      ),
      SizedBox(height: 14.h),
    ],
  );
}
