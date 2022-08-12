import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ElevatedButton DefaultButton({
  required String text,
  VoidCallback? onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      ),
    ),
  );
}
