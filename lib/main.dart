import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/screen/home_screen.dart';
import 'package:snackparty/screen/index_screen.dart';
import 'package:snackparty/screen/login_screen.dart';
// import 'package:snackparty/screen/my_info_screen.dart';
// import 'package:snackparty/screen/my_party_screen.dart';
// import 'package:snackparty/screen/signup_screen.dart';
// import 'package:snackparty/widget/bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      debugShowCheckedModeBanner: false,
      title: 'Snack Party',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 데이터가 들어온 경우
          if (snapshot.connectionState == ConnectionState.active) {
            // 데이터가 정상인 경우 HomeScreen 반환
            if (snapshot.hasData) {
              return IndexScreen();
            } else if (snapshot.hasError) {
              // 데이터에 에러가 있는 경우 error Text 페이지 반환
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터가 들어오는 중인 경우 CircularProgressIndecator 반환
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // 데이터가 없는 경우 LoginScreen 반환
          return const LoginScreen();
        },
      ),
      // home: DefaultTabController(
      //   length: 3,
      //   child: Scaffold(
      //     body: TabBarView(
      //       physics: NeverScrollableScrollPhysics(),
      //       children: [
      //         HomeScreen(),
      //         MyPartyScreen(),
      //         // MyInfoScreen(),
      //         LoginScreen(),
      //       ],
      //     ),
      //     bottomNavigationBar: Bottom(),
      //   ),
      // ),
    );
  }
}
