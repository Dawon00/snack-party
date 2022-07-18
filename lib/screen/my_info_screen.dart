import 'package:flutter/material.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _admissionYearController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보'),
        actions: [
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.white.withOpacity(0.1),
              ),
            ),
            child: const Text(
              "저장",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              // username
              TextField(
                decoration: const InputDecoration(
                  hintText: 'username',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _usernameController,
              ),
              // admission year and major
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your year of admisison',
                ),
                controller: _admissionYearController,
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String?>(
                onChanged: (String? newValue) {},
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
            ],
          ),
        ),
      ),
    );
  }
}
