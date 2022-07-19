import 'package:flutter/material.dart';
import 'package:snackparty/model/party.dart';

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
        child: RaisedButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('신청 하기'),
        ),
      ),
    );
  }
}
