import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  // Visibility of password
  void _passwordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _confirmPasswordVisibility() {
    setState(() {
      confirmPasswordVisible = !confirmPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.network(
                'https://blog.placeit.net/wp-content/uploads/2020/07/youtube-music-logo.png',
                fit: BoxFit.contain,
              ),
            ),
            customTextField(
              "Username",
              false,
              null,
              _email,
              (value) {
                if (value!.isEmpty) {
                  return "Please Enter Your Email";
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return "Please Enter Valid Email Address";
                }
              },
              (value) {
                _email.text = value!;
              },
              responsiveHW(context, wd: 100),
              responsiveHW(context, ht: 100),
              const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              pIcon: Icons.person,
            ),
            SizedBox(
              height: responsiveHW(context, ht: 3),
            ),
            customTextField(
              "Password",
              passwordVisible,
              IconButton(
                // splashColor: Colors.transparent,
                icon: Icon(
                  //choose the icon on based of passwordVisibility
                  passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
                onPressed: _passwordVisibility,
              ),
              _password,
              (value) {
                if (value!.isEmpty) {
                  return "Please Enter Your Password";
                }
              },
              (value) {
                _password.text = value!;
              },
              responsiveHW(context, wd: 100),
              responsiveHW(context, ht: 100),
              const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              pIcon: Icons.key,
            ),
            SizedBox(
              height: responsiveHW(context, ht: 3),
            ),
            customTextField(
              "Confirm Password",
              confirmPasswordVisible,
              IconButton(
                icon: Icon(
                  //choose the icon on based of passwordVisibility
                  confirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
                onPressed: _confirmPasswordVisibility,
              ),
              _confirmpassword,
              (value) {
                if (value!.isEmpty) {
                  return "Please Re-Enter Your Password";
                }
                if (value != _password.text) {
                  return "Both Password Should Be Matched";
                }
              },
              (value) {
                _confirmpassword.text = value!;
              },
              responsiveHW(context, wd: 100),
              responsiveHW(context, ht: 100),
              const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              pIcon: Icons.key,
            ),
            SizedBox(
              height: responsiveHW(context, ht: 3),
            ),
            // MaterialButton(
            //   onPressed: () {
            //     // Get.to(
            //     //   () => const PasswordsPage(),
            //     // );
            //   },
            //   color: Colors.amber.shade600,
            //   elevation: 0.0,
            //   shape: const StadiumBorder(),
            //   minWidth: MediaQuery.of(context).size.width * 0.4,
            //   height: MediaQuery.of(context).size.height * 0.07,
            //   child: Text(
            //     'Register',
            //     style: TextStyle(
            //         fontSize: 19.0,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.black,
            //         fontFamily: font_family),
            //   ),
            // ),
            // SizedBox(
            //   height: responsiveHW(context, ht: 2),
            // ),
            // RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(children: [
            //     TextSpan(
            //         text: 'Already a Member? ',
            //         style: TextStyle(
            //           fontSize: 17.0,
            //           color: Colors.black,
            //           fontFamily: font_family,
            //           fontWeight: FontWeight.w500,
            //         )),
            //     TextSpan(
            //         text: 'Login',
            //         recognizer: TapGestureRecognizer()
            //           ..onTap = () {
            //             print('object');
            //           },
            //         style: TextStyle(
            //           fontSize: 17.0,
            //           color: Colors.black,
            //           fontFamily: font_family,
            //           fontWeight: FontWeight.w500,
            //         )),
            //   ]),
            // ),
          ],
        ),
      ),
    );
  }
}
