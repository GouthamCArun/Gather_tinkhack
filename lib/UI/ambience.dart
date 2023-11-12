import 'dart:convert';

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
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final result = await http.post(
                        Uri.parse(
                            'https://web-production-9a03d.up.railway.app/whats'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{"num": "9400244505"}),
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
                  child: const Text("Accept")),
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
