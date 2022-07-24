import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

class BarButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const BarButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
