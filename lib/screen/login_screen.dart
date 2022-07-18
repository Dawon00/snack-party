import 'package:flutter/material.dart';
import 'package:snack_party/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              // email input field
              TextField(
                decoration: const InputDecoration(
                  hintText: '메일주소',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              // password input field
              TextField(
                decoration: const InputDecoration(
                  hintText: '비밀번호',
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              // login button
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  overlayColor: MaterialStateProperty.all(
                    Colors.white.withOpacity(0.1),
                  ),
                ),
                child: const Text(
                  '이어하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              // signup button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text(
                  '가입하기',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
