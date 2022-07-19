import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/screen/add_party_screen.dart';
import 'package:snackparty/screen/party_screen.dart';
import 'package:snackparty/widget/add_party_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snackparty/model/party.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scroll = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamData = firestore.collection('party').snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('party').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildbody(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildbody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Party> parties = snapshot.map((d) => Party.fromSnapshot(d)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('파티 찾기'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell_fill))
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (c, i) => Divider(
                height: 20.0,
              ),
          itemCount: parties.length,
          controller: scroll,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(5)),
                      Text(parties[index].partytitle + '( 신청 인원 / 가능 인원 )'),
                      Text('시간 / ' + parties[index].place),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            PartyScreen(party: parties[index])));
              },
            );
          }),
      floatingActionButton: AddPartyButton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}
