import 'dart:io';

import 'package:charity/Screens/DonorScreens/add_more_items_details.dart';
import 'package:charity/Screens/auth_screens/signin_screen.dart';
import 'package:charity/controllers/add_donation_controller.dart';
import 'package:charity/services/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../provider/add_attachment.dart';
import '../../provider/obsecure_pswd.dart';
import '../../widgets/app_logo_text.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/default_button.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({Key? key}) : super(key: key);

  @override
  State<AddDonation> createState() => _AddDonationState();
}
//noumana@devnatives.com

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
  File? image;

  Future pickmyImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } catch (e) {
      Get.snackbar("Message", e.toString());
    }
  }

  Widget build(BuildContext context) {
    Get.put(AddMoreList());
    // MY-LIST
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              pickmyImage();
            },
            child: const Text("Add Doantion")),
        actions: [
          image != null
              ? Image.file(
                  image!,
                  width: 160,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : ElevatedButton(
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
      drawer: MyDrawer(context),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       DataTable(columns: const [
                    //         DataColumn(
                    //           label: Text('Item Name'),
                    //         ),
                    //         DataColumn(
                    //           label: Text('Quantity'),
                    //         ),
                    //         DataColumn(
                    //           label: Text('Category'),
                    //         ),
                    //         DataColumn(
                    //           label: Text('Action'),
                    //         ),
                    //       ], rows: const []),
                    //     ],
                    //   ),
                    // ),
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
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Qty")),
                                  DataColumn(label: Text("cat")),
                                  DataColumn(label: Text("Action")),

                                  // nice
                                ], rows: [
                                  DataRow(cells: [
                                    DataCell(
                                      Text("${value.list[index]['itemName']}"),
                                    ),
                                    DataCell(
                                      Text("${value.list[index]['quantity']}"),
                                    ),
                                    DataCell(
                                      Text("${value.list[index]['category']}"),
                                    ),
                                    DataCell(
                                      IconButton(
                                          onPressed: () {
                                            setState(() {});
                                            value.list.removeAt(index);
                                            Get.snackbar("Message", "Deleted.");
                                          },
                                          icon: const Icon(Icons.delete)),
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
            myTextField("Donation Title", const Icon(Icons.title),
                _userTitleController),
            myTextField("Description", const Icon(Icons.description),
                _userDonationDescriptionController),
            myTextField(
                "PickUp location",
                const Icon(Icons.location_city_rounded),
                _userAddressController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultButton(
                  text: "Add Item",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // to open a dialogue box

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
                                    myTextField(
                                        "Item Name",
                                        const Icon(Icons.add),
                                        _itemNameController),
                                    myTextField(
                                        "Category",
                                        const Icon(Icons.category),
                                        _categoryController),
                                    myTextField(
                                        "Quantity",
                                        const Icon(Icons.numbers),
                                        _quantityController),

                                    // add attachement
                                    Consumer<AddAttachment>(
                                      builder: (context, value, child) =>
                                          TextFormField(
                                        controller: value.attachment,
                                        decoration: InputDecoration(
                                          hintText: "Attachment",
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
                                              Icons.file_copy,
                                              color: Colors.orange,
                                            ),
                                            onPressed: () {
                                              value.addAttachment();
                                            },
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.orange,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.orange,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                    myTextField(
                                        "Description",
                                        const Icon(Icons.details),
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

                                                Get.to(const AddDonation());
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
                          Get.to(const AddDonation());
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
