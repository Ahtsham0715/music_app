import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/auth/register_ui.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';
import 'package:music_app/music%20pages/main_widget.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  bool islogin = true;
  bool confirmPasswordVisible = true;
  bool passwordVisible = true;
  var args = Get.arguments;
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1487215078519-e21cc028cb29?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                    fit: BoxFit.fitHeight,
                  ),
                  Positioned(
                    top: 40.0,
                    left: 50.0,
                    child: Text(
                      islogin ? 'Login' : 'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: font_family,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  Positioned(
                    top: 70.0,
                    left: 50.0,
                    child: Text(
                      'Music for everyone',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: font_family,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              // color: Colors.blueGrey,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Form(
                key: _formkey,
                child: ListView(
                  padding: const EdgeInsets.all(30.0),
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 50.0),
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
                          return "Please Enter Your Username";
                        }
                        // if (!RegExp(
                        //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //     .hasMatch(value)) {
                        //   return "Please Enter Valid Email Address";
                        // }
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
                    !islogin
                        ? customTextField(
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
                          )
                        : const Center(),
                    islogin
                        ? SizedBox(
                            height: responsiveHW(context, ht: 2),
                          )
                        : SizedBox(
                            height: responsiveHW(context, ht: 4),
                          ),
                    !islogin
                        ? const Center()
                        : ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 15.0),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       // Get.to(
                              //       //   () => const RegisterPage(),
                              //       // );
                              //     },
                              //     child: const Text(
                              //       'Register',
                              //       style: TextStyle(
                              //         fontSize: 21.0,
                              //         fontWeight: FontWeight.w500,
                              //         fontFamily: 'majalla',
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: font_family,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: MaterialButton(
                        onPressed: islogin
                            ? () {
                                Get.to(
                                  () => const MainWidget(),
                                );
                              }
                            : () {},
                        color: Colors.amber.shade600,
                        elevation: 0.0,
                        shape: const StadiumBorder(),
                        minWidth: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Text(
                          islogin ? 'Login' : 'Register',
                          style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: font_family),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHW(context, ht: 4),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: islogin ? 'New Here? ' : 'Already a Member? ',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                              fontFamily: font_family,
                              fontWeight: FontWeight.w500,
                            )),
                        TextSpan(
                            text: islogin ? 'Create New Account' : 'Login',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                islogin = !islogin;
                                setState(() {});
                              },
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blue.shade700,
                              fontFamily: font_family,
                              fontWeight: FontWeight.w500,
                            )),
                      ]),
                    ),
                    SizedBox(
                      height: responsiveHW(context, ht: 8),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
