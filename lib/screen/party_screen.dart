import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/model/party.dart';
import 'package:snackparty/model/user.dart' as model;
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
  var members;

  Future getData() async {
    try {
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

  Future<List> getMembers() async {
    List partyMembers = [];
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      for (String id in widget.party.partymember) {
        final DocumentSnapshot snapshot =
            await firestore.collection('users').doc(id).get();
        partyMembers.add(model.User.fromSnap(snapshot));
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    }

    return partyMembers;
  }

  @override
  void initState() {
    super.initState();
    getData();
    members = getMembers();
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
          style: const TextStyle(
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: FutureBuilder(
                      future: firestore
                          .collection('users')
                          .doc(widget.party.author)
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) =>
                          snapshot.hasData
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("파티장 : ${snapshot.data['username']}"),
                                    Text(
                                        "시간 : ${widget.party.datetime.toString()}"),
                                    Text("장소 : ${widget.party.place}"),
                                    const Text('모집 현황 : 2 / 4'),
                                    Text("\n${widget.party.info}"),
                                  ],
                                )
                              : Container()),
                ),
              ],
            ),
          ),
          const SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              '파티원 목록',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
          ),
          FutureBuilder(
            future: members,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (c, i) => ListTile(
                                  tileColor: Colors.blue.shade50,
                                  contentPadding: const EdgeInsets.all(10),
                                  leading: const Icon(Icons.account_circle),
                                  title: Text(
                                      snapshot.data![i].toJson()['username']),
                                  subtitle: const Text('전공 / 학번'),
                                ),
                            childCount: widget.party.partymember.length),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (c, i) => const LinearProgressIndicator(),
                            childCount: 1),
                      ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: isMember
            ? BarButton(
                child: const Text('신청 취소하기',
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
                          children: const <Widget>[
                            Text("파티 신청"),
                          ],
                        ),
                        //
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "취소되었습니다.",
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text("확인"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            : BarButton(
                child: const Text('신청 하기',
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
                          children: const <Widget>[
                            Text("파티 신청"),
                          ],
                        ),
                        //
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "완료되었습니다.",
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text("확인"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
