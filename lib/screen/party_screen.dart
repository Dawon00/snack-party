import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/model/party.dart';
import 'package:snackparty/model/user.dart';
import 'package:snackparty/screen/home_screen.dart';

class PartyScreen extends StatefulWidget {
  final Party party;
  const PartyScreen({Key? key, required this.party}) : super(key: key);

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.party.partytitle),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('시간 : 00:00'),
                      Text('장소 : ' + widget.party.place),
                      Text('모집 현황 : 2 / 4'),
                      Text('\n' + widget.party.info),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              '파티원 목록',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (c, i) => ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(widget.party.partymember[i]),
                        subtitle: Text('전공 / 학번'),
                      ),
                  childCount: widget.party.partymember.length)),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          child: Text('신청 하기'),
          onPressed: () {
            CollectionReference user = firestore.collection('users');
            user.doc(FirebaseAuth.instance.currentUser!.uid).update({
              'parties': FieldValue.arrayUnion([widget.party.uid])
            });
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    //Dialog Main Title
                    title: Column(
                      children: <Widget>[
                        new Text("파티 신청"),
                      ],
                    ),
                    //
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "완료되었습니다.",
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("확인"),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
