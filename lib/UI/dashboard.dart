import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xff151628)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Image.asset("assets/backdash.jpg"),
                      Positioned.fill(
                          child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.transparent,
                              Color(0xff151628)
                            ])),
                      ))
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 250,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Invitations",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    const Text(
                                      "Finished",
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    const Text(
                                      "via Mail",
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child:
                                          Image.asset("assets/invitation.png"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 250,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Photography",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    const Text(
                                      "On going",
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    const Text(
                                      "via Call",
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset("assets/photo.png"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 250,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Food",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    const Text(
                                      "Pending",
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    const Text(
                                      "via Call",
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset("assets/food.png"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 250,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Ambience",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    const Text(
                                      "Pending",
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    const Text(
                                      "via Call",
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset("assets/ambience.png"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(59, 24, 0, 65)),
                  child: const Text(
                    "TinkHack",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
