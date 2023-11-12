
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'second.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late final TextEditingController _abt;
  late final TextEditingController _mail;
  late final TextEditingController _name;
  late final TextEditingController _pos;
  late final TextEditingController _compname;
  @override
  void initState() {
    _abt = TextEditingController();
    _mail = TextEditingController();
    _name = TextEditingController();
    _pos = TextEditingController();
    _compname = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  const Padding(padding: EdgeInsets.all(20)),
                  Text(
                    'What You want to Simplify today?',
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 40,
                      ),
                    ),
                  ),
                  // Image.asset(
                  //   'assets/images/firstpage.png',
                  //   height: 300,
                  //   width: 300,
                  // ),
                  Text(
                    "What is your Name?",
                    style: GoogleFonts.getFont("Poppins",
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                        )),
                  ),
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
                          hintText: "enter your name",
                        )),
                  ),
                  Text(
                    "What is your company name?",
                    style: GoogleFonts.getFont("Poppins",
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                        )),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextField(
                        cursorColor: const Color(0xFFea4c89),
                        cursorWidth: 5,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _compname,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "enter your company name",
                        )),
                  ),
                  Text(
                    "What is your position in your company?",
                    style: GoogleFonts.getFont("Poppins",
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                        )),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextField(
                        cursorColor: const Color(0xFFea4c89),
                        cursorWidth: 5,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _pos,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "enter your position in your company",
                        )),
                  ),

                  Text(
                    "What is your event about?",
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextField(
                      cursorColor: const Color(0xFFea4c89),
                      cursorWidth: 5,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _abt,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "Say us about your event",
                      )),

                  const SizedBox(height: 30),
                  SizedBox(
                    height: 55,
                    width: 350,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 253, 190, 208)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 243, 238, 238))))),
                      onPressed: () async {
                        final abt = _abt.text;
                        final mail = _mail.text;
                        final name = _name.text;
                        final pos = _pos.text;
                        final compname = _compname.text;
                        print("presed");
                        try {
                          print('------------------------$abt---------');
                          print('------------------------$mail---------');
                          print('------------------------$name---------');
                          print('------------------------$pos---------');
                          print(//here we are printing the values
                              '------------------------$compname---------');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Questions()),
                          );

                          //                   super.key,
                          // required this.cmpname,
                          // required this.pname,
                          // required this.ppos,
                          // required this.abt,
                        } catch (e) {}
                      },
                      child: Text(
                        'Next',
                        style: GoogleFonts.getFont("Poppins",
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
