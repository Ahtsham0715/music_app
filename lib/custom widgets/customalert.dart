import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customAlert extends StatelessWidget {
  const customAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.32,
        // vertical: MediaQuery.of(context).size.width * 0.3,
      ),
      actionsPadding: const EdgeInsets.only(bottom: 10.0),
      title: Icon(
        CupertinoIcons.exclamationmark_circle_fill,
        color: Colors.red[400],
        size: 70.0,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: const Text(
          'No internet available! Please\nReconnect and try again',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              // color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0),
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () async {
              Get.back();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.25,
                  MediaQuery.of(context).size.height * 0.06),
              maximumSize: Size(MediaQuery.of(context).size.width * 0.3,
                  MediaQuery.of(context).size.height * 0.06),
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey[350],
              elevation: 2.0,
              textStyle: const TextStyle(
                  fontSize: 20, fontFamily: "Viga", color: Colors.black),
            ),
            child: const Text('ok'),
          ),
        ),
      ],
    );
  }
}
