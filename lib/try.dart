import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.isSend}) : super(key: key);
  final isSend;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String directoryPath =
      '/storage/emulated/0/MIUI/sound_recorder/call_rec/';

  get io => null;

  Future<File> getMostRecentFile(String directoryPath) async {
    Directory directory = Directory(directoryPath);
    print(directory);

    List<File> files = await getFilesFromDirectory(directoryPath);

    // Do something with the list of files, such as printing their paths.
    files.forEach((file) {
      print("File: ${file.path}");
    });

    if (!directory.existsSync()) {
      throw "Directory not found: $directoryPath";
    }

    if (files.isEmpty) {
      throw "No files found in the directory: $directoryPath";
    }

    files
        .sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    return files.first as File;
  }

  Future<List<File>> getFilesFromDirectory(String directoryPath) async {
    Directory directory = Directory(directoryPath);

    if (!directory.existsSync()) {
      throw "Directory not found: $directoryPath";
    }

    List<FileSystemEntity> entities = directory.listSync();

    List<File> files = entities.whereType<File>().toList();

    print(files);

    return files;
  }

  void _fetchAndPrintMostRecentFile() async {
    try {
      // Request storage permission
      await _requestPermissions();

      File mostRecentFile = await getMostRecentFile(directoryPath);
      print('Most recent file: ${mostRecentFile.path}');
      await uploadFile(mostRecentFile.path);

      String downloadUrl = await getDownloadUrl();
      print(downloadUrl);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  void initState() {
    _listofFiles(); // TODO: implement initState
    super.initState();
  }

  // Make New Function
  void _listofFiles() async {
    try {
      // Request storage permission
      await _requestPermissions();

      var directory = (await getApplicationDocumentsDirectory()).path;
      setState(() {
        var files =
            io.Directory("$directory/resume/").listSync(); // Your folder path
        files.forEach((file) {
          print("File: ${file.path}");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
          style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
          onPressed: _fetchAndPrintMostRecentFile,
          icon: const Icon(Icons.send),
          label: const Text("Analyse the Call")),
    );
  }

  Future<void> uploadFile(String filePath) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('audio.mp3');
      File file = File(filePath);
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() async {
        print('File uploaded');
        final result = await http.post(
          Uri.parse('https://web-production-9823.up.railway.app/voice'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{"call": "yes"}),
        );

        if (result.statusCode == 200) {
          print("response vannu");
          return jsonDecode(result.body);
        } else {
          throw Exception('Failed to create album');
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getDownloadUrl() async {
    try {
      // Implement the logic to get the download URL from Cloud Storage here
      // For example, if you stored the reference when uploading, you can retrieve it.
      // Replace 'your_storage_reference' with the actual reference you used.
      Reference storageReference =
          FirebaseStorage.instance.ref().child('your_storage_reference');
      String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return ''; // Handle the error case appropriately
    }
  }
}
