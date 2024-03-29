import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/model/user.dart' as model;
import 'package:snackparty/screen/index_screen.dart';
import 'package:snackparty/screen/login_screen.dart';
import 'package:snackparty/widget/bar_button.dart';
import 'package:snackparty/widget/input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _admissionYearController =
      TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  bool _isLoading = false;

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String email = _emailController.text;
      String password = _passwordController.text;
      String username = _usernameController.text;
      int admissionYear = int.parse(_admissionYearController.text);
      String major = _majorController.text;

      // 모든 필드 값이 isNotEmpty일 경우 회원가입 진행
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          _admissionYearController.text.isNotEmpty &&
          major.isNotEmpty) {
        // Authentication에 user 추가
        UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // database에 user 추가
        model.User user = model.User(
          username: username,
          email: email,
          admissionYear: admissionYear,
          major: major,
          uid: cred.user!.uid,
          parties: [],
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        // HomeScreen으로 화면 전환
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: ((context) => const IndexScreen()),
          ),
        );
      } else {
        // 필드 값이 비어있는 경우 SnackBar에 필드 입력 메시지 출력
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter all the fields"),
          ),
        );
      }
    } catch (err) {
      // 오류 발생시 SnackBar에 오류 출력
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // logo
              Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    'SNACK PARTY',
                    style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.indigo.shade700,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    'SNACK PARTY',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.amber.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              // username
              InputField(
                  minLines: 1,
                  maxLines: 1,
                  textEditingController: _usernameController,
                  hintText: 'Enter your username'),
              // email
              InputField(
                minLines: 1,
                maxLines: 1,
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              // password
              InputField(
                minLines: 1,
                maxLines: 1,
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                isPass: true,
              ),
              // admission year
              InputField(
                minLines: 1,
                maxLines: 1,
                textEditingController: _admissionYearController,
                hintText: 'Enter your year of admisison',
                textInputType: TextInputType.number,
              ),
              // major
              InputField(
                minLines: 1,
                maxLines: 1,
                textEditingController: _majorController,
                hintText: 'Enter your major',
              ),
              const SizedBox(
                height: 12,
              ),
              // signup button
              BarButton(
                onPressed: signupUser,
                child: !_isLoading
                    ? const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // signup button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Already have an account?',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _admissionYearController.dispose();
    _majorController.dispose();
  }
}
