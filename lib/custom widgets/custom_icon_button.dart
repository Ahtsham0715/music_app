import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final icon;
  final ontap;
  const CustomIconButton({super.key, required this.ontap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 22.0,
        color: Colors.black,
      ),
      onPressed: ontap,
    );
  }
}
