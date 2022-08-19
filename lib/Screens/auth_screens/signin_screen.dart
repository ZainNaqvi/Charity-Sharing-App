import 'package:charity/Screens/DonorScreens/add_donation.dart';
import 'package:charity/Screens/auth_screens/signup_screen.dart';
import 'package:charity/services/firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../provider/obsecure_pswd.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String result = " my result";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswordControler = TextEditingController();

  final Firebaseauth _auth = Firebaseauth();
  String errorlabel = "";
  bool isLoading = false;
  signInUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await _auth.signIn(
        email: _emailController.text.trim(), password: _paswordControler.text);
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });
      Get.snackbar("Message", "Successfully loged in.");
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddDonation()));
      _emailController.clear();
      _paswordControler.clear();
    } else {
      setState(() {
        isLoading = false;
        errorlabel = res.split("]")[1];
        result = res;
      });

      Get.snackbar("Message", res.trimLeft());
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
          if (hintText == "Enter Email") {
            return "Enter Email Please";
          }
        }
        return null;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        // main column for body
        body: SingleChildScrollView(
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
              // Sign In Text
              const Center(
                  child: Text(
                "Sign In",
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
                "Sadaqa is charity given voluntarily in order to please God.",
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
                      // Enter email
                      myTextField("Enter Email", const Icon(Icons.email),
                          _emailController),

                      SizedBox(height: 10.h),

                      // Enter Password
                      Consumer<ObsecurePassword>(
                        builder: (context, value, child) => TextFormField(
                          controller: _paswordControler,
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
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                errorlabel,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Rubik Medium",
                    color: Colors.red),
              ),
              // Sign Up button
              isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : InkWell(
                      onTap: () {
                        if ((formKey.currentState!.validate())) {
                          signInUser();
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
                          child: Text("Sign In"),
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
                    "Don't have an Account ?",
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
                              builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontFamily: 'Rubik Medium',
                          color: Colors.orange),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
