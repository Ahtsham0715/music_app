import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:music_app/constants.dart';

class CustomText extends StatelessWidget {
  String? txt;
  CustomText({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, bottom: 5.0),
      child: Text(
        "$txt",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: font_family_bold,
        ),
      ),
    );
  }
}
