import 'package:flutter/material.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool passwordVisible = true;
  // Visibility of password
  void _passwordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
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
                      'Login',
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
                    ButtonBar(
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
                              'Forgot password',
                              style: TextStyle(
                                color: Colors.black,
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
                    MaterialButton(
                      onPressed: () {
                        // Get.to(
                        //   () => const PasswordsPage(),
                        // );
                      },
                      color: Colors.amber.shade600,
                      elevation: 0.0,
                      shape: StadiumBorder(),
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: font_family),
                      ),
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
