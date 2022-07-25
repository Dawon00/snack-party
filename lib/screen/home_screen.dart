import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/screen/party_screen.dart';
import 'package:snackparty/widget/add_party_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snackparty/model/party.dart';
import 'package:snackparty/widget/party_card.dart';

final firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          '파티 찾기',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
        //   IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell_fill))
        // ],
      ),
      body: StreamBuilder(
        stream: firestore.collection('party').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: docs.length,
            itemBuilder: (context, index) => GestureDetector(
              child: PartyCard(
                party: Party.fromSnap(docs[index]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PartyScreen(
                      party: Party.fromSnap(docs[index]),
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: const AddPartyButton(),
    );
  }
}
