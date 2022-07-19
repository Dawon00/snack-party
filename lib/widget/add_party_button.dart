import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snackparty/screen/add_party_screen.dart';

class AddPartyButton extends StatefulWidget {
  const AddPartyButton({Key? key}) : super(key: key);

  @override
  State<AddPartyButton> createState() => _AddPartyButtonState();
}

class _AddPartyButtonState extends State<AddPartyButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(CupertinoIcons.add),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => AddPartyScreen()));
      },
    );
  }
}
