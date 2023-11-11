import 'dart:io';

import 'package:file_manager/file_manager.dart';
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

  final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return ControlBackButton(
      controller: controller,
      child: Scaffold(
        body: Center(
          child: FloatingActionButton(
            onPressed: _fetchAndPrintMostRecentFile,
            child: const Icon(Icons.get_app),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () => createFolder(context),
          icon: const Icon(Icons.create_new_folder_outlined),
        ),
        IconButton(
          onPressed: () => sort(context),
          icon: const Icon(Icons.sort_rounded),
        ),
        IconButton(
          onPressed: () => selectStorage(context),
          icon: const Icon(Icons.sd_storage_rounded),
        )
      ],
      title: ValueListenableBuilder<String>(
        valueListenable: controller.titleNotifier,
        builder: (context, title, _) => Text(title),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          await controller.goToParentDirectory();
        },
      ),
    );
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data!.size;

            return Text(
              "${FileManager.formatBytes(size)}",
            );
          }
          return Text(
            "${snapshot.data!.modified}".substring(0, 10),
          );
        } else {
          return const Text("");
        }
      },
    );
  }

  Future<void> selectStorage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: FutureBuilder<List<Directory>>(
          future: FileManager.getStorageList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<FileSystemEntity> storageList = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: storageList
                        .map((e) => ListTile(
                              title: Text(
                                "${FileManager.basename(e)}",
                              ),
                              onTap: () {
                                controller.openDirectory(e);
                                Navigator.pop(context);
                              },
                            ))
                        .toList()),
              );
            }
            return const Dialog(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  sort(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: const Text("Name"),
                  onTap: () {
                    controller.sortBy(SortBy.name);
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Size"),
                  onTap: () {
                    controller.sortBy(SortBy.size);
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Date"),
                  onTap: () {
                    controller.sortBy(SortBy.date);
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("type"),
                  onTap: () {
                    controller.sortBy(SortBy.type);
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  createFolder(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController folderName = TextEditingController();
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: TextField(
                    controller: folderName,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Create Folder
                      await FileManager.createFolder(
                          controller.getCurrentPath, folderName.text);
                      // Open Created Folder
                      controller.setCurrentPath =
                          controller.getCurrentPath + "/" + folderName.text;
                    } catch (e) {}

                    Navigator.pop(context);
                  },
                  child: const Text('Create Folder'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
