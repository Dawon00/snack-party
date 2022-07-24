import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/screen/home_screen.dart';
import 'package:snackparty/screen/index_screen.dart';
import 'package:snackparty/screen/signup_screen.dart';
import 'package:snackparty/widget/bar_button.dart';
import 'package:snackparty/widget/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String email = _emailController.text;
      String password = _passwordController.text;

      // 모든 필드 값이 isNotEmpty일 경우 로그인 진행
      if (email.isNotEmpty && password.isNotEmpty) {
        // 로그인 진행
        await auth.signInWithEmailAndPassword(email: email, password: password);

        // HomeScreen으로 화면 전환
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: ((context) => IndexScreen()),
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
              Image.network(
                'https://upload.wikimedia.org/wikipedia/en/thumb/3/37/MapleStory.SVG/1200px-MapleStory.SVG.png',
                height: 64,
              ),
              const SizedBox(
                height: 12,
              ),
              // email input field
              InputField(
                minLines: 1,
                maxLines: 1,
                textEditingController: _emailController,
                hintText: '메일주소',
                textInputType: TextInputType.emailAddress,
              ),
              // password input field
              InputField(
                minLines: 1,
                maxLines: 1,
                textEditingController: _passwordController,
                hintText: '비밀번호',
                isPass: true,
              ),
              const SizedBox(
                height: 12,
              ),
              // login button
              BarButton(
                onPressed: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.blue,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
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
                      "Don't have an account?",
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Signup.',
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
    _emailController.dispose();
    _passwordController.dispose();
  }
}
