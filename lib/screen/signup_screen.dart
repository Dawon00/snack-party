import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _admissionYearController =
      TextEditingController();

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
              // username
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                ),
                controller: _usernameController,
              ),
              // email
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              // password
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              // confirm password
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your password again',
                ),
                controller: _confirmPasswordController,
                obscureText: true,
              ),
              // major and admission year
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your year of admisison',
                ),
                controller: _admissionYearController,
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String?>(
                decoration: InputDecoration(),
                onChanged: (String? newValue) {
                  print(newValue);
                },
                items: [
                  null,
                  '컴퓨터전자시스템공학부',
                  '컴퓨터공학과',
                ].map<DropdownMenuItem<String?>>((String? i) {
                  return DropdownMenuItem<String?>(
                    value: i,
                    child: Text({
                          '컴퓨터전자시스템공학부': '컴퓨터전자시스템공학부',
                          '컴퓨터공학과': '컴퓨터공학과'
                        }[i] ??
                        '비공개'),
                  );
                }).toList(),
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
