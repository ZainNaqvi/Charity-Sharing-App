import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddAttachment extends ChangeNotifier {
  late final TextEditingController _attachmentController =
      TextEditingController();
  File? image;
  get attachment => _attachmentController;

  addAttachment() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);

      this.image = imageTemp;
    } catch (e) {
      Get.snackbar("Message", e.toString());
    }

    _attachmentController.text = image!.path;
    notifyListeners();
  }
}
