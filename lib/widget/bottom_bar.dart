import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      height: 60,
      child: TabBar(
        labelColor: Colors.blueAccent[700],
        tabs: const [
          Tab(
            child: Text('파티 찾기'),
          ),
          Tab(
            child: Text('내 파티'),
          ),
          Tab(
            child: Text('내 정보'),
          )
        ],
      ),
    );
  }
}
