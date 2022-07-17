import 'package:flutter/material.dart';

class AddPartyScreen extends StatefulWidget {
  const AddPartyScreen({Key? key}) : super(key: key);

  @override
  State<AddPartyScreen> createState() => _AddPartyScreenState();
}

class _AddPartyScreenState extends State<AddPartyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('파티 추가 화면'),
    );
  }
}
