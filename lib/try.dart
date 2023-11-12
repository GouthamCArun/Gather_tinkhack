import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
    for (var file in files) {
      print("File: ${file.path}");
    }

    if (!directory.existsSync()) {
      throw "Directory not found: $directoryPath";
    }

    if (files.isEmpty) {
      throw "No files found in the directory: $directoryPath";
    }

    files
        .sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    return files.first;
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
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: _fetchAndPrintMostRecentFile,
          child: const Icon(Icons.get_app),
        ),
      ),
    );
  }
}
