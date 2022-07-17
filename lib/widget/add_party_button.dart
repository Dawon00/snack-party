import 'package:flutter/material.dart';
import 'package:snack_party/screen/add_party_screen.dart';

class AddPartyButton extends StatefulWidget {
  const AddPartyButton({Key? key}) : super(key: key);

  @override
  State<AddPartyButton> createState() => _AddPartyButtonState();
}

class _AddPartyButtonState extends State<AddPartyButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Text('+'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => AddPartyScreen()));
      },
    );
  }
}
