import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snack_party/screen/add_party_screen.dart';
import 'package:snack_party/screen/party_screen.dart';
import 'package:snack_party/widget/add_party_button.dart';

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
          itemCount: 20,
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
                Navigator.push(context,
                    CupertinoPageRoute(builder: (c) => AddPartyScreen()));
              },
            );
          }),
      floatingActionButton: AddPartyButton(),
    );
  }
}
