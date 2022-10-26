import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final icon;
  final ontap;
  final size;
  final hovercolor;
  const CustomIconButton(
      {super.key,
      required this.ontap,
      required this.icon,
      this.size = 22.0,
      this.hovercolor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: size,
        color: Colors.black,
      ),
      onPressed: ontap,
      hoverColor: hovercolor,
    );
  }
}
