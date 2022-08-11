 import 'package:image_picker/image_picker.dart';

pickImage(
  {
    required ImageSource source
  }

 )
 async
{

final ImagePicker img= ImagePicker();
XFile? file= await img.pickImage(source: source);
if(file!=null)
{
  return await file.readAsBytes();
}
print('no file found');
}