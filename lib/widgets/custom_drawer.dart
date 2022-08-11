import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_drawers_buttons.dart';

Drawer MyDrawer() {
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.orange,
          ),
          child: Expanded(
            child: Row(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                ListTile(
                  title: Text("Awais"),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        customButton("Donate", 1),
        SizedBox(
          height: 40.h,
        ),
        customButton("Request", 2),
        SizedBox(
          height: 40.h,
        ),
        customButton("Volunteer", 4),
        SizedBox(
          height: 40.h,
        ),
        customButton("Log out", 3),
      ],
    ),
  );
}
