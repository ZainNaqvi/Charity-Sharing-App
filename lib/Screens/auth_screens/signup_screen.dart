import 'package:charity/Screens/DonorScreens/add_donation.dart';
import 'package:charity/Screens/auth_screens/signin_screen.dart';
import 'package:charity/services/firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/obsecure_pswd.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // creating teh firebase class  auth instance

  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final Firebaseauth _auth = Firebaseauth();
  String errorlabel = "";
  // create the bool here
  bool isLoading = false; // this is for loader
// create the funcitoin here
  registerUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await _auth.createUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
      phoneNumber: _mobileNumberController.text.trim(),
      location: _locationController.text,
    );
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddDonation()));
    } else {
      setState(() {
        isLoading = false;
        errorlabel = res.split("]")[1];
      });
      Get.snackbar("Message", res);
    }
  }

  Widget myTextField(
      String hintText, Icon preIcon, TextEditingController mycontroller) {
    return TextFormField(
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
          if (hintText == "Enter Your Name") {
            return "Enter Your Name Please";
          }
          if (hintText == "Enter Mobile number") {
            return "Enter mobile number ";
          }
          if (hintText == "Enter Email") {
            return "Enter Email Please";
          }
          if (hintText == "Enter Password") {
            return "Enter Password Please";
          }
          if (hintText == "Choose location") {
            return "Choose Location Please";
          }
        }
        return null;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          //
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              // logo + app name

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
              // Sign Up Text
              const Center(
                  child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik Medium',
                    color: Colors.black),
              )),

              SizedBox(
                height: 14.h,
              ),
              // quote text
              const Center(
                  child: Text(
                "Feeding some one is the highest \nReward you can give to humanity",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Regular',
                    color: Colors.orange),
              )),

              // text Fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      // Enter name field,
                      myTextField("Enter Your Name", const Icon(Icons.person),
                          _nameController),
                      SizedBox(height: 10.h),

                      // Enter mobile no
                      myTextField(
                          "Enter Mobile number",
                          const Icon(Icons.phone_android),
                          _mobileNumberController),
                      SizedBox(height: 10.h),

                      // Enter email
                      myTextField("Enter Email", const Icon(Icons.email),
                          _emailController),
                      SizedBox(height: 10.h),

                      // Enter Password
                      Consumer<ObsecurePassword>(
                        builder: (context, value, child) => TextFormField(
                          controller: _passwordController,
                          obscureText: value.obsecure,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Rubik Medium',
                                color: Colors.black),
                            fillColor: Colors.orange,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.orange,
                            ),
                            // const Icon(Icons.visibility,color: Colors.orange,),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                value.checkMyObsecure();
                              },
                            ),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password First";
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // choose location
                      myTextField(
                          "Choose location",
                          const Icon(Icons.location_city_sharp),
                          _locationController),
                    ],
                  ),
                ),
              ),
              Text(
                errorlabel,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Rubik Medium",
                    color: Colors.red),
              ),
              SizedBox(height: 20.h),
              // Sign Up button
              isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          registerUser();
                        } else {
                          return;
                        }
                      },
                      child: Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text("SignUp"),
                        ),
                      ),
                    ),

              SizedBox(
                height: 10.h,
              ),
              // Already have an account text ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account ?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontFamily: 'Rubik Medium',
                          color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
