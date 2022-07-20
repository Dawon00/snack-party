import 'package:flutter/material.dart';
import 'package:snackparty/screen/home_screen.dart';
import 'package:snackparty/screen/my_info_screen.dart';
import 'package:snackparty/screen/my_party_screen.dart';

class IndexScreen extends StatefulWidget {
  IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.search_outlined), label: '파티 찾기'),
      BottomNavigationBarItem(icon: new Icon(Icons.people), label: '내 파티'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보')
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(),
        MyPartyScreen(),
        Scaffold(
          body: Center(
            child: Text('내 정보 화면'),
          ),
        )
        // MyInfoScreen(uid: '~~'),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
