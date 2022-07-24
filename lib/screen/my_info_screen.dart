import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/widget/input_field.dart';

class MyInfoScreen extends StatefulWidget {
  final String uid;
  const MyInfoScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController admissionYearController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  bool isLoading = false;

  void setData() async {
    setState(() {
      isLoading = true;
    });

    try {
      String username = usernameController.text;
      int admissionYear = int.parse(admissionYearController.text);
      String major = majorController.text;

      if (username.isNotEmpty &&
          major.isNotEmpty &&
          admissionYearController.text.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .update({
          "username": username,
          "admissionYear": admissionYear,
          "major": major,
        });

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Success"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter all the fields"),
          ),
        );
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      usernameController.text = userSnap.data()!['username'];
      admissionYearController.text =
          userSnap.data()!['admissionYear'].toString();
      majorController.text = userSnap.data()!['major'];
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보'),
        actions: [
          // 저장 버튼
          TextButton(
            onPressed: setData,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.white.withOpacity(0.1),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text(
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
              InputField(
                minLines: 1,
                maxLines: 1,
                hintText: 'username',
                textInputType: TextInputType.emailAddress,
                textEditingController: usernameController,
              ),
              // admission year
              InputField(
                minLines: 1,
                maxLines: 1,
                hintText: 'Enter your year of admisison',
                textEditingController: admissionYearController,
                textInputType: TextInputType.number,
              ),
              // major
              InputField(
                minLines: 1,
                maxLines: 1,
                hintText: 'Enter your major',
                textEditingController: majorController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
