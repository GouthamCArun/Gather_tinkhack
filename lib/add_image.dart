import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<String?> uploadImageToFirebase(File imageFile, String imageName) async {
  try {
    Reference storageReference =
        FirebaseStorage.instance.ref().child(imageName);
    UploadTask uploadTask = storageReference.putFile(imageFile);

    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    print("sucess");

    return downloadUrl;
  } catch (e) {
    print('Error uploading image to Firebase Storage: $e');
    return null;
  }
}
