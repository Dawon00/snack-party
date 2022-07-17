import 'package:flutter/material.dart';
import 'package:snack_party/screen/home_screen.dart';
import 'package:snack_party/screen/login_screen.dart';
import 'package:snack_party/widget/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snack Party',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              Container(), //my_party_screen
              LoginScreen(), //my_info_screen
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
