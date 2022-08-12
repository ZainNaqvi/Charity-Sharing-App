
import 'package:charity/Screens/DonorScreens/add_more_items_details.dart';

import 'dart:typed_data';
import 'package:charity/Screens/Request/add_request.dart';
import 'package:charity/Screens/Volunteer/volunteer.dart';
import 'package:charity/Screens/auth_screens/signin_screen.dart';
import 'package:charity/controllers/add_donation_controller.dart';
import 'package:charity/services/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/app_logo_text.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/default_button.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({Key? key}) : super(key: key);

  @override
  State<AddDonation> createState() => _AddDonationState();
} // wo khaan hai detail screen

class _AddDonationState extends State<AddDonation> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userTitleController = TextEditingController();
  final TextEditingController _userDonationDescriptionController =
      TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _attachmentController = TextEditingController();
  final TextEditingController _addItemDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(AddMoreList());
    // MY-LIST
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
      drawer: Container(
        width: 250.h,
        child: Drawer(
            child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: const Text("Maab"),
              accountEmail: Text("maab977@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: const Text(
                  "A",
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
      ),
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

              GetBuilder<AddMoreList>(builder: (value) {
                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          DataTable(columns: [
                            DataColumn(
                              label: Text('Title'),
                            ),
                            DataColumn(
                              label: Text('Item Name'),
                            ),
                            DataColumn(
                              label: Text('Quantity'),

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
                            DataColumn(
                              label: Text('Donation Desc'),
                            ),
                            DataColumn(
                              label: Text('Location'),
                            ),
                            DataColumn(
                              label: Text('Description'),
                            ),
                            DataColumn(
                              label: Text('Attachment'),
                            ),
                            DataColumn(
                              label: Text('Category'),
                            ),
                            DataColumn(
                              label: Text('Edit'),
                            ),
                            DataColumn(
                              label: Text('Delete'),
                            )
                          ], rows: []),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        // column empty nai ho sakta
                        return Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                DataTable(columns: const [
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("")),
                                  // nice
                                ], rows: [
                                  DataRow(cells: [
                                    DataCell(
                                      Text("${value.list[index]['title']}"),
                                    ),
                                    DataCell(
                                      Text("${value.list[index]['itemName']}"),
                                    ),
                                    DataCell(
                                      Text("${value.list[index]['quantity']}"),
                                    ),
                                    DataCell(
                                      Text(
                                          "${value.list[index]['donationDescription']}"),
                                    ),
                                    DataCell(
                                      Text(
                                          "${value.list[index]['pickUpLocation']}"),
                                    ),
                                    DataCell(
                                      Text(
                                          "${value.list[index]['description']}"),
                                    ),
                                    DataCell(
                                      Text(
                                          "${value.list[index]['attachment']}"),
                                    ),
                                    DataCell(
                                      Text("${value.list[index]['category']}"),
                                    ),
                                    DataCell(
                                      IconButton(
                                          onPressed: () {
                                            final TextEditingController
                                                _updateitemNameController =
                                                TextEditingController(
                                                    text: value.list[index]
                                                        ['itemName']);
                                            final TextEditingController
                                                _updatecategoryController =
                                                TextEditingController(
                                                    text: value.list[index]
                                                        ['category']);
                                            final TextEditingController
                                                _updatequantityController =
                                                TextEditingController(
                                                    text: value.list[index]
                                                        ['quantity']);
                                            final TextEditingController
                                                _updateattachmentController =
                                                TextEditingController(
                                                    text: value.list[index]
                                                        ['attachment']);
                                            final TextEditingController
                                                _updateaddItemDescriptionController =
                                                TextEditingController(
                                                    text: value.list[index]
                                                        ['description']);
                                            Get.defaultDialog(
                                              title: '',
                                              content: Expanded(
                                                child: SingleChildScrollView(
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      children: [
                                                        AppLogoText(),
                                                        SizedBox(
                                                          height: 30.0.h,
                                                        ),
                                                        myTextField(
                                                            "",
                                                            Icon(Icons.person),
                                                            _updateitemNameController),
                                                        myTextField(
                                                            "",
                                                            Icon(Icons.person),
                                                            _updatecategoryController),
                                                        myTextField(
                                                            "",
                                                            Icon(Icons.person),
                                                            _updatequantityController),
                                                        myTextField(
                                                            "",
                                                            Icon(Icons.person),
                                                            _updateattachmentController),
                                                        myTextField(
                                                            "",
                                                            Icon(Icons.person),
                                                            _updateaddItemDescriptionController),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            DefaultButton(
                                                                text: "Update",
                                                                onPressed: () {
                                                                  value.list[index]
                                                                          [
                                                                          'itemName'] =
                                                                      _updateitemNameController
                                                                          .text;
                                                                  value.list[index]
                                                                          [
                                                                          'category'] =
                                                                      _updatecategoryController
                                                                          .text;
                                                                  value.list[index]
                                                                          [
                                                                          'quantity'] =
                                                                      _updatequantityController
                                                                          .text;
                                                                  value.list[index]
                                                                          [
                                                                          'quantity'] =
                                                                      _updatequantityController
                                                                          .text;
                                                                  value.list[index]
                                                                          [
                                                                          'attachment'] =
                                                                      _updateattachmentController
                                                                          .text;
                                                                  value.list[index]
                                                                          [
                                                                          'description'] =
                                                                      _updateaddItemDescriptionController
                                                                          .text;
                                                                }),
                                                            DefaultButton(
                                                                text: "Cancel"),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.edit)),
                                    ),
                                    DataCell(
                                      IconButton(
                                          onPressed: () {
                                            setState(() {});
                                            value.list.removeAt(index);
                                            Get.snackbar("Message", "Deleted.");
                                          },
                                          icon: Icon(Icons.delete)),
                                    ),
                                  ])
                                ]),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    ));
  }

// TEXT-FORM-FIELDS
  Widget MyForm() {
    return GetBuilder<AddMoreList>(builder: (value) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            myTextField(
                "Enter title", Icon(Icons.person), _userTitleController),
            myTextField("Enter Description", Icon(Icons.person),
                _userDonationDescriptionController),
            myTextField(
                "Enter Address", Icon(Icons.person), _userAddressController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButton(
                  text: "Add More Item",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.defaultDialog(
                          title: '',
                          content: Expanded(
                            flex: 4,
                            child: SingleChildScrollView(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    AppLogoText(),
                                    SizedBox(
                                      height: 30.0.h,
                                    ),
                                    myTextField("Item Name", Icon(Icons.add),
                                        _itemNameController),
                                    myTextField(
                                        "Category",
                                        Icon(Icons.category),
                                        _categoryController),
                                    myTextField("Quantity", Icon(Icons.numbers),
                                        _quantityController),
                                    myTextField(
                                        "Attachment",
                                        Icon(Icons.attachment),
                                        _attachmentController),
                                    myTextField(
                                        "Description",
                                        Icon(Icons.details),
                                        _itemDescriptionController),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GetBuilder<AddMoreList>(
                                          builder: (addList) {
                                            return DefaultButton(
                                              text: 'Save',
                                              onPressed: () {
                                                addList.addToList(
                                                  donationDescription:
                                                      _userDonationDescriptionController
                                                          .text,
                                                  title:
                                                      _userTitleController.text,
                                                  itemName:
                                                      _itemNameController.text,
                                                  quantity:
                                                      _quantityController.text,
                                                  description:
                                                      _itemDescriptionController
                                                          .text,
                                                  pickUpLocation:
                                                      _userAddressController
                                                          .text,
                                                  attachment:
                                                      _attachmentController
                                                          .text,
                                                  category:
                                                      _categoryController.text,
                                                );
                                                // NAVIGATING-TO-DETAIL-PAGE

                                                Get.to(AddDonation());
                                              },
                                            );
                                          },
                                        ),
                                        DefaultButton(
                                            text: 'Cancel', onPressed: () {}),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          radius: 10.0);
                    } else {
                      Get.snackbar("Message", "All Field required.");
                    }
                  },
                ),
                value.list.isEmpty
                    ? DefaultButton(
                        text: "Donate",
                        onPressed: null,
                      )
                    : DefaultButton(
                        text: "Donate",
                        onPressed: () async {
                          await submit();
                        },
                      ),
                value.list.isEmpty
                    ? DefaultButton(
                        text: "Cancel",
                        onPressed: null,
                      )
                    : DefaultButton(
                        text: "Cancel",
                        onPressed: () async {
                          Get.to(AddDonation());
                        },
                      ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // SUBMITING-TO-DATABASE
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
        pickUpLocation: Get.find<AddMoreList>().list[i]['pickUpLocation'],
        donationDescription: Get.find<AddMoreList>().list[i]
            ['donationDescription'],
        attachment: Get.find<AddMoreList>().list[i]['attachment'],
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
}
