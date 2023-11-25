import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gather/UI/dashboard.dart';
import 'package:gather/UI/emailpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

Future<Album> createAlbum(String det) async {
  final result = await http.post(
    Uri.parse('https://web-production-9823.up.railway.app/details'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"detail": det}),
  );

  if (result.statusCode == 200) {
    return Album.fromJson(jsonDecode(result.body));
  } else {
    throw Exception('Failed to create album');
  }
}

class Album {
  final String answer;

  const Album({required this.answer});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      answer: json['result'],
    );
  }
}

class _SplashPageState extends State<SplashPage> {
  late final TextEditingController inputController = TextEditingController();
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff201f47),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Image.asset("assets/event.jpg"),
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext) =>
                                        const DashBoard()));
                          },
                          mini: true,
                          backgroundColor:
                              const Color.fromARGB(53, 93, 72, 184),
                          child: const Icon(Icons.skip_next_rounded)),
                    ),
                  ),
                  const SizedBox(
                    height: 550,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(53, 93, 72, 184),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(53, 93, 72, 184),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: inputController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: "Tell about Your amazing event..",
                                  hintStyle: TextStyle(color: Colors.white54),
                                  border: InputBorder.none),
                              autocorrect: true,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final inputController1 = inputController.text;
                              final result = await http.post(
                                Uri.parse(
                                    'https://web-production-9823.up.railway.app/details'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  "detail": inputController1
                                }),
                              );

                              if (result.statusCode == 200) {
                                print('API Response: ${result.body}');
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EmailPage(),
                                  ),
                                );
                                return jsonDecode(result.body);
                              } else {
                                throw Exception(
                                    'Failed to create album ,${result.statusCode}');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(53, 93, 72,
                                  184), // Set the background color here
                            ),
                            child: const Text("Neext"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
