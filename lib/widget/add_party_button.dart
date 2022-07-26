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
      backgroundColor: Colors.white,
      foregroundColor: Colors.blueAccent[700],
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AddPartyScreen()));
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ]),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
