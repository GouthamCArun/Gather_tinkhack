import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../try.dart';

class AmbiencePage extends StatefulWidget {
  const AmbiencePage({super.key});

  @override
  State<AmbiencePage> createState() => _AmbiencePageState();
}

class _AmbiencePageState extends State<AmbiencePage> {
  String delivery = '';
  String time = '';
  String single = '';
  String total = '';
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    fetchMails();
    super.initState();
  }

  void fetchMails() async {
    DocumentSnapshot snapshotUserInfo;
    await db.collection('details').doc("payment").get().then((val) {
      setState(() {
        snapshotUserInfo = val;
        delivery = snapshotUserInfo.get('delivery');
        single = snapshotUserInfo.get('single');
        time = snapshotUserInfo.get('time');
        total = snapshotUserInfo.get('total');
      });
    });
  }

  bool isSend = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151628),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Ambience Work near us",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white60,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                trailing: GestureDetector(
                  onTap: () async {
                    launch("tel:+919400244505");
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: const Text(
                  "Cherupushpam",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text("open"),
                tileColor: Colors.white54,
              ),
            ),
            Visibility(
              visible: isSend,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final result = await http.post(
                          Uri.parse(
                              'https://web-production-9a03d.up.railway.app/whats'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body:
                              jsonEncode(<String, String>{"num": "9400244505"}),
                        );

                        if (result.statusCode == 200) {
                          print("response vannu");
                          return jsonDecode(result.body);
                        } else {
                          throw Exception(result.statusCode);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text("Accept"),
                  ),
                  DataTable(
                      dividerThickness: 2,
                      columnSpacing: 20,
                      dataRowColor: const MaterialStatePropertyAll(
                          Color.fromARGB(149, 0, 60, 110)),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Delivery',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Single',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Time',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Total',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(
                            delivery,
                            style: const TextStyle(color: Colors.white),
                          )),
                          DataCell(Text(
                            single,
                            style: const TextStyle(color: Colors.white),
                          )),
                          DataCell(Text(
                            time,
                            style: const TextStyle(color: Colors.white),
                          )),
                          DataCell(Text(
                            total,
                            style: const TextStyle(color: Colors.white),
                          )),
                        ])
                      ])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                trailing: GestureDetector(
                  onTap: () async {
                    launch("tel:+919400244505");
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: const Text(
                  "Firefly",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text("open"),
                tileColor: Colors.white54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                trailing: GestureDetector(
                  onTap: () async {
                    launch("tel:+919400244505");
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: const Text(
                  "Color Rings",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text("open"),
                tileColor: Colors.white54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSend = true;
                  });
                },
                child: HomeScreen(
                  isSend: isSend,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
