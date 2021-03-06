import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/model/party.dart';
import 'package:snackparty/screen/party_screen.dart';
import 'package:snackparty/widget/add_party_button.dart';
import 'package:snackparty/widget/party_card.dart';

class MyPartyScreen extends StatefulWidget {
  final String uid;
  const MyPartyScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MyPartyScreen> createState() => _MyPartyScreenState();
}

class _MyPartyScreenState extends State<MyPartyScreen> {
  var scroll = ScrollController();
  var myParties;

  Future<List> getData() async {
    List parties = [];

    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      var userSnap = await firestore.collection('users').doc(widget.uid).get();

      for (String id in userSnap.data()!['parties']) {
        final DocumentSnapshot snapshot =
            await firestore.collection('party').doc(id).get();
        parties.add(
          Party.fromSnap(snapshot),
        );
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    }

    return parties;
  }

  @override
  void initState() {
    super.initState();
    myParties = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          '내 파티',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.bell_fill))
        ],
      ),
      body: FutureBuilder(
        future: myParties,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return PartyScreen(
                                party: snapshot.data![index],
                                uid: FirebaseAuth.instance.currentUser!.uid,
                              );
                            },
                          ),
                        );
                      },
                      child: PartyCard(
                        party: snapshot.data![index],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
      floatingActionButton: const AddPartyButton(),
    );
  }
}
