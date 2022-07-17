import 'package:flutter/material.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({Key? key}) : super(key: key);

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('파티명'),
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
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: 500,
                  height: 200,
                  child: Text('썸네일'),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('시간 : 00:00'),
                      Text('장소 : 공학관 앞'),
                      Text('모집 현황 : 2 / 4'),
                      Text('\n현재가 고기 사준대여 얼른 신청하세요!'),
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
                        title: Text('파티원'),
                        subtitle: Text('전공 / 학번'),
                      ),
                  childCount: 10)),
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
