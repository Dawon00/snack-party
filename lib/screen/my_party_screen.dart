import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snack_party/screen/party_screen.dart';
import 'package:snack_party/widget/add_party_button.dart';

class MyPartyScreen extends StatefulWidget {
  const MyPartyScreen({Key? key}) : super(key: key);

  @override
  State<MyPartyScreen> createState() => _MyPartyScreenState();
}

class _MyPartyScreenState extends State<MyPartyScreen> {
  var scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 파티'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell_fill))
        ],
      ),
      body: Column(
        children: [
          // 예정됨
          Row(
            children: <Widget>[
              Expanded(child: Divider()),
              Text("예정됨"),
              Expanded(child: Divider()),
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (c, i) => const Divider(
                height: 20.0,
              ),
              itemCount: 5,
              controller: scroll,
              itemBuilder: (c, i) {
                return GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text('썸네일'),
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            '파티명 ( 신청 인원 / 가능 인원)',
                          ),
                          Text('시간 / 장소')
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (c) => PartyScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // 완료됨
          Row(
            children: <Widget>[
              Expanded(child: Divider()),
              Text("완료됨"),
              Expanded(child: Divider()),
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (c, i) => const Divider(
                height: 20.0,
              ),
              itemCount: 100,
              controller: scroll,
              itemBuilder: (c, i) {
                return GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text('썸네일'),
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            '파티명 ( 신청 인원 / 가능 인원)',
                          ),
                          Text('시간 / 장소')
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (c) => PartyScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AddPartyButton(),
    );
  }
}
