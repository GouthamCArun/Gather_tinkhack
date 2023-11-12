import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late bool _imagePresent;
  late int nq;
  File? _image;
  File? _comp_image;
  final _imagePicker = ImagePicker();
  late final TextEditingController _question;
  late final TextEditingController _op1;
  late final TextEditingController _op2;
  late final TextEditingController _op3;
  late final TextEditingController _op4;
  late final TextEditingController _correctAns;
  late String img = " ";
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _imagePresent = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Do you want to add an image?',
                      style: GoogleFonts.getFont('Poppins',
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: SizedBox(
                        width: 250,
                        height: 130,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: _imagePresent
                                  ? FileImage(_image!)
                                  : const AssetImage("assets/im.png")
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: FloatingActionButton(
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              if (_imagePresent) {
                                // Remove the image
                                setState(() {
                                  _imagePresent = false;
                                  _image = null; // Clear the image reference
                                });
                              } else {
                                // Pick an image
                                pickImage();
                              }
                            },
                            tooltip: 'Pick Image',
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 350,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 225, 225, 225),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              side: BorderSide(
                                color: Color.fromARGB(255, 243, 238, 238),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _uploading = true;
                          });

                          final imagePresent = _imagePresent;

                          if (imagePresent) {
                            img = (await uploadImageToFirebase(
                                _image!, 'image'))!;
                          }

                          try {} on Exception {
                            setState(() {
                              _uploading = true;
                            });
                          }
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.getFont("Poppins",
                              textStyle: const TextStyle(
                                color: Colors.teal,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_uploading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  pickImage() async {
    try {
      var image = await _imagePicker.pickImage(source: ImageSource.gallery);
      print(image?.path);
      if (image == null) return null;

      final compressedFile = await FlutterImageCompress.compressWithFile(
        image.path,
        quality: 50, // Adjust the compression quality (0-100) as needed
      );

      if (compressedFile != null) {
        setState(() {
          _imagePresent = true;
          _image = File(image.path);
        });
      } else {
        print('Image compression failed or not necessary.');
      }
    } catch (e) {
      print('Error while picking and compressing image: $e');
    }
  }

  Future<String?> uploadImageToFirebase(
      File imageFile, String imageName) async {
    try {
      print("uploading started");
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imageName);
      UploadTask? uploadTask = storageReference.putFile(imageFile);

      if (uploadTask != null) {
        TaskSnapshot storageTaskSnapshot = await uploadTask;
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        print('Upload task is null.');
        return null;
      }
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}
