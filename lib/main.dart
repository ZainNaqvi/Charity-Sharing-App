
import 'package:charity/provider/expiry_date.dart';
import 'package:charity/provider/obsecure_pswd.dart';
import 'package:charity/widgets/customSnakeBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'Screens/DonorScreens/add_donation.dart';
import 'Screens/auth_screens/signup_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();// only for android // do some changings for web and ios
  await Firebase.initializeApp();
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
          primaryColor: Colors.white,
          backgroundColor: Colors.white,
      
       primarySwatch: Colors.orange,
       // see
        ),
        home:StreamBuilder(
          stream: FirebaseAuth.instance.idTokenChanges(),
          builder: (context, snapshot)
           {

              if(snapshot.connectionState==ConnectionState.active) {
                    if(snapshot.hasData) {

return const AddDonation() ;   }

else if(snapshot.hasError){
  return showSnakeBar("No internet connection.", context);
}
              }

if(snapshot.connectionState==ConnectionState.waiting) {
return const Center(child: CircularProgressIndicator(),);
}
          return const SignUp();
        },)
        
        
        );
   
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

