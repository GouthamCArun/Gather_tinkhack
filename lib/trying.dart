import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdPage extends StatefulWidget {
  ThirdPage({
    Key? key,
    required this.cmpname,
    required this.pname,
    required this.ppos,
    required this.abt,
  }) : super(key: key);

  final String cmpname;
  final String pname;
  final String ppos;
  final String abt;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

Future<Album> createAlbum(String cmpname, String pname, String ppos, String abt,
    String email, String rname) async {
  ;
  final result = await http.post(
    Uri.parse('https://web-production-77cb.up.railway.app/mail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "abt_event": cmpname,
      "r_name": rname,
      "y_name": pname,
      "y_pos": ppos,
      "y_comp": abt,
      "email_list": email,
    }),
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

class _ThirdPageState extends State<ThirdPage> {
  late final TextEditingController _email;
  late final TextEditingController _name;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(20)),
                Text(
                  'Whom all do you want to Invite?',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 40,
                    ),
                  ),
                ),
                Text(
                  "Enter the names of the people you want to invite",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: TextField(
                    cursorColor: const Color(0xFFea4c89),
                    cursorWidth: 5,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "enter email id's",
                    ),
                  ),
                ),
                Text(
                  "Enter the email id of the person you want to invite",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: TextField(
                    cursorColor: const Color(0xFFea4c89),
                    cursorWidth: 5,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _email,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "enter email id's",
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 55,
                  width: 350,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 253, 190, 208),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final email = _email.text;
                      final name = _name.text;
                      try {
                        print('Email: $email');
                        print('rName: $name');
                        print('Company Name: ${widget.cmpname}');
                        print('Person Name: ${widget.pname}');
                        print('Person Position: ${widget.ppos}');
                        print('About: ${widget.abt}');

                        // Making API call
                        final result = await createAlbum(widget.cmpname,
                            widget.pname, widget.ppos, widget.abt, email, name);
                        print('API Response: ${result.answer}');
                      } catch (e) {
                        print('Error: $e');
                      }
                    },
                    child: Text(
                      'Next',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
