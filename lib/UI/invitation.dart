import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
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
                "Invite Peoples",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white60,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isSend == true ? Colors.green : Colors.red,
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "alfred@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
                tileColor: Colors.white54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isSend == true ? Colors.green : Colors.red,
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "alfred@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
                tileColor: Colors.white54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isSend == true ? Colors.green : Colors.red,
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "alfred@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
                tileColor: Colors.white54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isSend = true;
                      sendInvites();
                    });
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Send Ai Invites")),
            )
          ],
        ),
      ),
    );
  }

  void sendInvites() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshotUserInfo;
    await db.collection('Users').doc("person").get().then((value) {
      snapshotUserInfo = value;
      print(snapshotUserInfo.get('event'));
      
    });
  }
}
