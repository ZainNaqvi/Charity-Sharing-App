import 'package:charity/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/add_donation_controller.dart';
import '../../services/firebase_methods/firebase_methods.dart';
import '../../widgets/app_logo_text.dart';

class AddMoreItemDetails extends StatefulWidget {
  const AddMoreItemDetails({Key? key}) : super(key: key);

  @override
  State<AddMoreItemDetails> createState() => _AddMoreItemDetailsState();
}

bool isLoading = false;
FirebsaeMethods firebsaeMethods = FirebsaeMethods();

class _AddMoreItemDetailsState extends State<AddMoreItemDetails> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("show details of items")),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                                    Text("${value.list[index]['description']}"),
                                  ),
                                  DataCell(
                                    Text("${value.list[index]['attachment']}"),
                                  ),
                                  DataCell(
                                    Text("${value.list[index]['category']}"),
                                  ),
                                  DataCell(
                                    IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: '',
                                            content: Expanded(
                                              child: SingleChildScrollView(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    children: [
                                                      AppLogoText(),
                                                      SizedBox(
                                                        height: 30.0.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          DefaultButton(
                                                              text: "Update"),
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
                  DefaultButton(
                      text: "Donate",
                      onPressed: () async {
                        await submit();
                      })
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
