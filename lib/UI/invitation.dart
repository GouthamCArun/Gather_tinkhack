import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  bool isSend = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List email = [];
  @override
  void initState() {
    fetchMails();
    super.initState();
  }

  void fetchMails() async {
    DocumentSnapshot snapshotUserInfo;
    await db.collection('details').doc("person").get().then((val) {
      setState(() {
        snapshotUserInfo = val;
        email = snapshotUserInfo.get("email");
      });
    });
  }

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
            Container(
              height: 300,
              width: 300,
              child: ListView.builder(
                  itemCount: email.length,
                  itemBuilder: (context, index) {
                    if (email.isEmpty) {
                      return const CircularProgressIndicator();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                isSend == true ? Colors.green : Colors.red,
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            email[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          tileColor: Colors.white54,
                        ),
                      );
                    }
                  }),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isSend = true;
                    sendInvites();
                  });
                },
                icon: const Icon(Icons.send),
                label: const Text("Send Ai Invites"))
          ],
        ),
      ),
    );
  }

  void sendInvites() async {
    DocumentSnapshot snapshotUserInfo;
    await db.collection('details').doc("person").get().then((value) async {
      snapshotUserInfo = value;
      print(snapshotUserInfo.get('eventdet'));
      print(snapshotUserInfo.get('name'));
      print(snapshotUserInfo.get('position'));
      print(snapshotUserInfo.get('email'));

      final result = await http.post(
        Uri.parse('https://web-production-77cb.up.railway.app/mail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "abt_event": snapshotUserInfo.get('eventdet'),
          "r_name": "sir",
          "y_name": snapshotUserInfo.get('name'),
          "y_pos": snapshotUserInfo.get('position'),
          "y_comp": snapshotUserInfo.get('event'),
          "email_list": "gouthamchennamakkal@gmail.com"
        }),
      );

      if (result.statusCode == 200) {
        return jsonDecode(result.body);
      } else {
        throw Exception('Failed to create album');
      }
    });
  }
}
