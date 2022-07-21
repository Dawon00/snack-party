import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/model/user.dart';
import 'package:snackparty/screen/add_party_screen.dart';
import 'package:snackparty/screen/party_screen.dart';
import 'package:snackparty/widget/add_party_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snackparty/model/party.dart';

final firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scroll = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('파티 찾기'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell_fill))
        ],
      ),
      body: StreamBuilder(
        stream: firestore.collection('party').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                                docs[index]['partytitle'] + ' (신청 인원 / 가능 인원)'),
                            Text('00 : 00 ' + docs[index]['place']),
                          ],
                        ))
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PartyScreen(
                            party: Party.fromMap(docs[index].data()))),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: AddPartyButton(),
    );
  }
}
