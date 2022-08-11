import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/add_donation_controller.dart';
import '../../services/firebase_methods/firebase_methods.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("show details of items")),
      body: Column(
        children: [
          GetBuilder<AddMoreList>(builder: (value) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: value.list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.orange,
                      ),
                      title: Text("${value.list[index]['title']}"),
                      subtitle: Text("${value.list[index]['name']}"),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      await submit();
                    },
                    child: const Text("Donate"))
              ],
            );
          })
        ],
      ),
    );
  }
}
