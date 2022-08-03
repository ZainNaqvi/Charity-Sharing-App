
import 'package:charity/provider/expiry_date.dart';
import 'package:charity/provider/obsecure_pswd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'Screens/auth_screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
        
        ChangeNotifierProvider(create:(_) => ObsecurePassword()),
        ChangeNotifierProvider(create:(_) => ExpiryDate()),
    ],
   child: ScreenUtilInit(
       designSize: const Size(360, 690),
         minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) { 
    return GetMaterialApp(
        
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
       primarySwatch: Colors.orange,
        ),
        home:const SignUp());
   
       },
   ),
    );
    
    
    
    
 
  //   return ScreenUtilInit(
  //      designSize: const Size(360, 690),
  //        minTextAdapt: true,
  //     splitScreenMode: true,
  //     builder: (BuildContext context, Widget? child) { 
  //   return MaterialApp(
        
  //       title: 'Flutter Demo',
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeData(
       
  //       ),
  //       home:const SignUp());
   
  //      },
  //  );
  
  }
}

