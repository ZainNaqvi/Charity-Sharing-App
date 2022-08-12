import 'package:charity/Screens/auth_screens/signin_screen.dart';
import 'package:charity/services/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/app_logo_text.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/default_button.dart';

class DonationItems extends StatefulWidget {
  const DonationItems({Key? key}) : super(key: key);

  @override
  State<DonationItems> createState() => _DonationItemsState();
}

class _DonationItemsState extends State<DonationItems> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userTitleController = TextEditingController();
  final TextEditingController _userDescriptionController =
      TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Add Doantion"),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Firebaseauth firebaseauth = Firebaseauth();
                String res = await firebaseauth.signOut();
                if (res == 'success') {
                  Get.to(const SignIn());
                } else {
                  return;
                }
              },
              child: const Text("log out "))
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // APP-LOGO APP-TITLE-TEXT
              AppLogoText(),
              MyForm(),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    ));
  }

// TEXT-FORM-FIELDS
  Form MyForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          myTextField("Enter title", Icon(Icons.person), _userTitleController),
          myTextField("Enter Description", Icon(Icons.person),
              _userDescriptionController),
          myTextField(
              "Enter Address", Icon(Icons.person), _userAddressController),
          DefaultButton(
              text: "Add Item",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                } else {
                  Get.snackbar("Message", "All Field required.");
                }
              }),
        ],
      ),
    );
  }
}
