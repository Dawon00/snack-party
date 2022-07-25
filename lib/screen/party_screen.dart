import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/model/party.dart';
import 'package:snackparty/model/user.dart';
import 'package:snackparty/screen/home_screen.dart';
import 'package:snackparty/widget/bar_button.dart';

class PartyScreen extends StatefulWidget {
  final Party party;
  final String uid;
  const PartyScreen({Key? key, required this.party, required this.uid})
      : super(key: key);

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  bool isMember = true;

  Future getData() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      if (!widget.party.partymember.contains((widget.uid))) {
        setState(() {
          isMember = false;
        });
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          widget.party.partytitle,
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
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
                      Text('파티장 : ' + widget.party.author),
                      Text('시간 : ' + widget.party.datetime.toString()),
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
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (c, i) => ListTile(
                        tileColor: Colors.blue.shade50,
                        contentPadding: const EdgeInsets.all(10),
                        // shape: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        //   borderSide: BorderSide(color: Colors.blue.shade50),
                        // ),
                        leading: Icon(Icons.account_circle),
                        title: Text(widget.party.partymember[i]),
                        subtitle: Text('전공 / 학번'),
                      ),
                  childCount: widget.party.partymember.length)),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: isMember
            ? BarButton(
                child: Text('신청 취소하기',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  //user 모델에 신청한 party 삭제
                  CollectionReference user = firestore.collection('users');
                  user.doc(widget.uid).update({
                    'parties': FieldValue.arrayRemove([widget.party.id])
                  });
                  //party 모델에 신청한 user 삭제
                  CollectionReference party = firestore.collection('party');
                  party.doc(widget.party.id).update({
                    'partymember': FieldValue.arrayRemove([widget.uid])
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
                                "취소되었습니다.",
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            new ElevatedButton(
                              child: new Text("확인"),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                  //setState(() {});
                },
              )
            : BarButton(
                child: Text('신청 하기',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  //user 모델에 신청한 party 추가
                  CollectionReference user = firestore.collection('users');
                  user.doc(widget.uid).update({
                    'parties': FieldValue.arrayUnion([widget.party.id])
                  });
                  //party 모델에 신청한 user 추가
                  CollectionReference party = firestore.collection('party');

                  party.doc(widget.party.id).update({
                    'partymember': FieldValue.arrayUnion([widget.uid])
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
                            new ElevatedButton(
                              child: new Text("확인"),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                  //setState(() {});
                },
              ),
      ),
    );
  }
}
