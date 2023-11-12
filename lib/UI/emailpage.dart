import 'package:flutter/material.dart';
import 'package:gather/UI/dashboard.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xff201f47),
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/start.gif"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Expand your Event",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: controller1,
                    decoration: const InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: controller2,
                    decoration: const InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: controller3,
                    decoration: const InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: controller4,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        focusColor: Colors.white,
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 248, 218, 107))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) => const DashBoard(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.next_plan_rounded,
                    color: Color.fromARGB(255, 5, 0, 38),
                  ),
                  label: const Text(
                    "Go to Dashboard",
                    style: TextStyle(color: Color.fromARGB(255, 24, 0, 66)),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
