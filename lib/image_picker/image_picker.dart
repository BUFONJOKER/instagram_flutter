import 'package:image_picker/image_picker.dart';

selectImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image =  await imagePicker.pickImage(source: source);

  if(image !=null){
    return await image.readAsBytes();
  }
}
