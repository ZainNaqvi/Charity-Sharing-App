import 'dart:typed_data';

// ok
import 'package:charity/Screens/Request/add_request.dart';
import 'package:charity/Screens/Volunteer/volunteer.dart';
import 'package:charity/Screens/auth_screens/signin_screen.dart';
import 'package:charity/provider/expiry_date.dart';
import 'package:charity/services/firebase_auth/firebase_auth.dart';
import 'package:charity/services/firebase_methods/firebase_methods.dart';
import 'package:charity/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../controllers/add_donation_controller.dart';
import 'add_more_items_details.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({Key? key}) : super(key: key);

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _titleOfDonation = TextEditingController();
  final TextEditingController _nameOfItem = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _pickUpLocation = TextEditingController();
  final TextEditingController _addAttachment = TextEditingController();
  final TextEditingController _addCategory = TextEditingController();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  String? _hour, _minute, _time;
  int count = 0;

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
    );
  }

  void chkLogOut() async {
    Firebaseauth firebaseauth = Firebaseauth();
    String res = await firebaseauth.signOut();
    if (res == 'success') {
      Get.to(const SignIn());
    } else {
      return;
    }
  }

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
                    {
                      chkLogOut(),
                    }
                  else if (btnId == 4)
                    {
                      Get.to(const VolunteerMain()),
                    }
                }),
            child: Text(
              btnName,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Rubik Medium",
                  color: Colors.black),
            ),
          )),
        )
      ],
    );
  }

  Uint8List? imageUrl;
  selectImage() async {
    print("clicked");
    Uint8List img = await pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = img;
    });
  }

  void clearText() {
    _titleOfDonation.clear();
    _nameOfItem.clear();
    _quantity.clear();
    _description.clear();
    _pickUpLocation.clear();
    _addCategory.clear();
    _addAttachment.clear();
  }

  FirebsaeMethods firebsaeMethods = FirebsaeMethods();

  String pickUpDate = '';
  String pickUpTime = '';
  String expDate = '';
  bool isLoading = false;
// submit function
  submit() async {
    setState(() {
      isLoading = true;
    });
    for (var i = 0; i < Get.find<AddMoreList>().list.length; i++) {
      String res = await firebsaeMethods.addDonation(
        title: Get.find<AddMoreList>().list[i]['title'],
        name: Get.find<AddMoreList>().list[i]['name'],
        quantity: Get.find<AddMoreList>().list[i]['quantity'],
        description: Get.find<AddMoreList>().list[i]['description'],
        category: Get.find<AddMoreList>().list[i]['category'],
        pickUpLock: Get.find<AddMoreList>().list[i]['pickUpLock'],
        pickUpDate: Get.find<AddMoreList>().list[i]['pickUpDate'],
        pickUpTime: Get.find<AddMoreList>().list[i]['pickUpTime'],
        expDate: Get.find<AddMoreList>().list[i]['expDate'],
      );
      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
        Get.snackbar('Message', 'Successfully');
      } else {
        setState(() {
          isLoading = false;
        });
        Get.snackbar('Message', res.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AddMoreList());
    // test
    expDate = Provider.of<ExpiryDate>(context).dob.text;
    pickUpDate = Provider.of<ExpiryDate>(context).pickDate.text;
    pickUpTime = Provider.of<ExpiryDate>(context).pickTime.text;

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
      drawer: Container(
        width: 250.w,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            //      crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ),
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
            // Add Donation Text
            const Center(
                child: Text(
              "Add Your Donation ",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Rubik Medium',
                  color: Colors.black),
            )),

            SizedBox(
              height: 14.h,
            ),

            const Center(
                child: Text(
              "Feeding someOne is the Highest \nReward You can Give to Humanity",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik Regular',
                  color: Colors.orange),
            )),
            GetBuilder<AddMoreList>(builder: (value) {
              return Card(
                elevation: 1,
                borderOnForeground: true,
                color: Colors.orange,
                child: ListTile(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddMoreItemDetails()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  tileColor: Colors.green,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  leading: const CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.light,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    'Donated ${value.list.length} item succesfully',
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Rubik Medium",
                        color: Colors.black),
                  ),
                  subtitle: const Text('Tap here to check details'),
                ),
              );
            }),
            // text Fields
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    //  Enter Title field,
                    myTextField("Enter Title of Doantion",
                        const Icon(Icons.title), _titleOfDonation),
                    SizedBox(height: 10.h),
                    // Enter category
                    myTextField("Add Category", const Icon(Icons.category),
                        _addCategory),
                    SizedBox(height: 10.h),
                    // Enter name of Item
                    myTextField("Enter Name of Item",
                        const Icon(Icons.description_sharp), _nameOfItem),
                    SizedBox(height: 10.h),
                    // Enter Quantity
                    myTextField(
                        "Enter Quantity", const Icon(Icons.numbers), _quantity),
                    SizedBox(height: 10.h),
                    // Enter Description
                    myTextField("Enter Description",
                        const Icon(Icons.description_sharp), _description),
                    SizedBox(height: 10.h),
                    // Enter pickUp location
                    myTextField("Enter PickUp location",
                        const Icon(Icons.location_on), _pickUpLocation),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () async {
                        await selectImage();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 12.w),
                        width: double.maxFinite,
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(children: [
                          const Icon(Icons.attachment_outlined),
                          imageUrl == null
                              ? const Text("No selected image")
                              : Image(
                                  image: MemoryImage(imageUrl!),
                                ),
                        ]),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // choose pick up date
                    Consumer<ExpiryDate>(
                      builder: (context, value, child) => TextFormField(
                        controller: value.pickDate,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Enter PickUp Date ",
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik Medium',
                              color: Colors.black),
                          fillColor: Colors.orange,
                          prefixIcon: const Icon(
                            Icons.calendar_month_sharp,
                            color: Colors.orange,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(days: 1500)),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 1500)))
                                  .then((pickedDate) {
                                if (pickedDate != null) {
                                  value.setPickUpDate(pickedDate);
                                }
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            return "Enter Expiry Date First";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // choose pick up time

                    Consumer<ExpiryDate>(
                      builder: (context, value, child) => TextFormField(
                        controller: value.pickTime,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Enter PickUp Time ",
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik Medium',
                              color: Colors.black),
                          fillColor: Colors.orange,
                          prefixIcon: const Icon(
                            Icons.timelapse_sharp,
                            color: Colors.orange,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              ).then((pickedTime) {
                                if (pickedTime != null) {
                                  _hour = pickedTime.hour.toString();
                                  _minute = pickedTime.minute.toString();
                                  _time = "$_hour : $_minute";
                                  value.setPickUpTime(_time);
                                }
                              });
                            },
                            icon: const Icon(Icons.punch_clock),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            return "Enter Expiry Date First";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // choose Expiry Date

                    Consumer<ExpiryDate>(
                      builder: (context, value, child) => TextFormField(
                        controller: value.dob,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Enter Expiry Date ",
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik Medium',
                              color: Colors.black),
                          fillColor: Colors.orange,
                          prefixIcon: const Icon(
                            Icons.calendar_month_sharp,
                            color: Colors.orange,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 1500)))
                                  .then((pickedDate) {
                                if (pickedDate != null) {
                                  value.setExpDate(pickedDate);
                                }
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            return "Enter Expiry Date First";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),
            //Donate button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (() {
                    if (formKey.currentState!.validate()) {
                      submit();
                      //ok
                      Get.snackbar(
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.black,
                          "Message",
                          "item Donated successfully");
                      clearText();
                    }
                  }),
                  child: Container(
                    height: 30.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text("Donate"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GetBuilder<AddMoreList>(builder: (value) {
                        return InkWell(
                          onTap: (() {
                            if (formKey.currentState!.validate()) {
                              //
                              value.addToList(
                                title: _titleOfDonation.text,
                                name: _nameOfItem.text,
                                quantity: _quantity.text,
                                category: _addCategory.text,
                                description: _description.text,
                                pickUpLocation: _pickUpLocation.text,
                                pickUpDate: pickUpDate,
                                pickUpTime: pickUpTime,
                                expDate: expDate,
                                urlOfImg: imageUrl!,
                              );
                              print(value.list.length);

                              clearText();
                            }
                          }),
                          child: Container(
                            height: 30.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text("Add more item"),
                            ),
                          ),
                        );
                      }),
              ],
            ),

            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    ));
  }
}
