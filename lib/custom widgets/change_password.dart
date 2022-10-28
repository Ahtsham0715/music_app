import 'package:flutter/material.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';

Future changepassword(context) async {
  bool isworking = false;
  // _email.clear();
  // _oldpassword.clear();
  // _newpassword.clear();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _oldpassword = TextEditingController();
  TextEditingController _newpassword = TextEditingController();
  return showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) => StatefulBuilder(builder: (context, innerstate) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        backgroundColor: Colors.grey.shade200.withOpacity(1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: const Center(child: Text('Change Password')),
        content: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextField(
                "old Password",
                true,
                null,
                _oldpassword,
                (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                },
                (value) {
                  _oldpassword.text = value!;
                },
                responsiveHW(context, wd: 100),
                responsiveHW(context, ht: 100),
                InputBorder.none,
                pIcon: Icons.lock,
              ),
              customTextField(
                "New Password",
                true,
                null,
                _newpassword,
                (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                },
                (value) {
                  _newpassword.text = value!;
                },
                responsiveHW(context, wd: 100),
                responsiveHW(context, ht: 100),
                InputBorder.none,
                pIcon: Icons.lock,
              ),
              SizedBox(
                height: responsiveHW(context, ht: 3),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          isworking
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: CircularProgressIndicator(),
                )
              : MaterialButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      innerstate(() {
                        isworking = true;
                      });
                    }
                  },
                  child: const Text('Submit'),
                ),
        ],
      );
    }),
  );
}

// Future<String> changePhoneNumber(
//     {required context, required String prevPhone}) async {
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   final TextEditingController _phoneNumber =
//       TextEditingController(text: prevPhone);
//   showDialog(
//     context: context,
//     useSafeArea: true,
//     builder: (context) => StatefulBuilder(builder: (context, innerstate) {
//       return AlertDialog(
//         contentPadding: const EdgeInsets.all(10.0),
//         backgroundColor: Colors.grey.shade200.withOpacity(1.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         title: const Center(child: Text('Change Password')),
//         content: Form(
//           key: _formkey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               customTextField(
//                 "old Password",
//                 false,
//                 null,
//                 _phoneNumber,
//                 (value) {
//                   if (value!.isEmpty) {
//                     return "Required";
//                   }
//                 },
//                 (value) {
//                   _phoneNumber.text = value!;
//                 },
//                 responsiveHW(context, wd: 100),
//                 responsiveHW(context, ht: 100),
//                 InputBorder.none,
//                 pIcon: Icons.phone,
//               ),
//               SizedBox(
//                 height: responsiveHW(context, ht: 3),
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           MaterialButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           MaterialButton(
//             onPressed: () async {
//               if (_formkey.currentState!.validate()) {
//                 prevPhone = _phoneNumber.text.trim();
//               }
//             },
//             child: const Text('Submit'),
//           ),
//         ],
//       );
//     }),
//   );
//   return prevPhone;
// }
