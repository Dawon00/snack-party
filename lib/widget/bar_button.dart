import 'package:flutter/material.dart';

class BarButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  const BarButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  State<BarButton> createState() => _BarButtonState();
}

class _BarButtonState extends State<BarButton> {
  //final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: widget.child,
      onPressed: () {
        widget.onPressed;
      },
    );
  }
}
