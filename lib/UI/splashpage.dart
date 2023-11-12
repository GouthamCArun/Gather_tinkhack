import 'package:flutter/material.dart';
import 'package:gather/UI/emailpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TextEditingController inputController = TextEditingController();
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
                                        const EmailPage()));
                          },
                          mini: true,
                          backgroundColor: Color.fromARGB(53, 93, 72, 184),
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
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(53, 93, 72, 184),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: inputController,
                          decoration: const InputDecoration(
                              hintText: "Tell about Your amazing event..",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                          autocorrect: true,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
