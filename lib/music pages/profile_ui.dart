import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/change_password.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/custom%20widgets/custom_text.dart';
import 'package:music_app/custom%20widgets/utils.dart';
import 'package:music_app/models/user_data_model.dart';
import 'package:music_app/provider/auth_provider.dart';
import 'package:music_app/provider/profile_update_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileUi extends StatefulWidget {
  const ProfileUi({super.key});

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  TextEditingController _username = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _datepicker = TextEditingController(text: 'dd:mm:yyyy');
  String selectedCountry = '';
  // String? phonenumber;
  Map userDataMap = {};

  Future getUserData(userid) async {
    var headers = {'Accept': 'application/json'};

    var url = Uri.parse(
        'http://desktopapp.inshopmedia.com/api/show-user?user_id=$userid');

    final response = await http.get(url, headers: headers);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      userDataMap = data['data'];
      loginbox.write('userdata', data);
      return userDataMap;
    } else {
      // If that call was not successful, throw an error.
      print(response.reasonPhrase.toString());
      return userDataMap;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    return FutureBuilder(
        future: getUserData(loginbox.read('userdata')['data']['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.15,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballTrianglePathColoredFilled,
                  colors: [
                    Colors.teal.shade200,
                    Colors.amber.shade300,
                    Colors.red.shade300
                  ],
                  strokeWidth: 1,
                ),
              ),
            );
          } else {
            _username.text = userDataMap['username'];
            _name.text = userDataMap['name'];
            _email.text = userDataMap['email'];
            selectedCountry = userDataMap['country'];
            phonenumber.text = userDataMap['mobile'];
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      shape: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          strokeAlign: StrokeAlign.outside,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          color: Colors.black45,
                        ),
                      ),
                      title: Text(
                        phonenumber.text.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: font_family_bold,
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: MaterialButton(
                          onPressed: () {
                            authprovider.logout();
                          },
                          color: Colors.white,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              )),
                          minWidth: MediaQuery.of(context).size.width * 0.065,
                          // height: MediaQuery.of(context).size.height * 0.07,
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 12.0,
                                // fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: font_family),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: .05),
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () {
                        changepassword(context);
                      },
                      color: Colors.teal.shade200,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          )),
                      minWidth: MediaQuery.of(context).size.width * 0.02,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 12.0,
                            // fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: font_family),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: 2),
                  ),
                  CustomText(txt: 'Username'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: customTextField(
                      "Username",
                      false,
                      null,
                      _username,
                      (value) {},
                      (value) {
                        _username.text = value!;
                      },
                      responsiveHW(context, wd: 100),
                      responsiveHW(context, ht: 100),
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Colors.transparent,
                        ),
                      ),
                      pIcon: null,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: 2),
                  ),
                  CustomText(txt: 'Name'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: customTextField(
                      "Full Name",
                      false,
                      null,
                      _name,
                      (value) {},
                      (value) {
                        _name.text = value!;
                      },
                      responsiveHW(context, wd: 100),
                      responsiveHW(context, ht: 80),
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Colors.white,
                        ),
                      ),
                      pIcon: null,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: 2),
                  ),
                  CustomText(txt: 'Email Address'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: customTextField(
                      "Email Address",
                      false,
                      null,
                      _email,
                      (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Username";
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
                      responsiveHW(context, ht: 80),
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Colors.white,
                        ),
                      ),
                      pIcon: null,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: 2),
                  ),
                  CustomText(txt: 'Phone Number'),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: customTextField(
                          "Phone Number",
                          false,
                          null,
                          phonenumber,
                          (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Phone Number";
                            }
                            // if (!RegExp(
                            //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            //     .hasMatch(value)) {
                            //   return "Please Enter Valid Email Address";
                            // }
                          },
                          (value) {
                            phonenumber.text = value!;
                          },
                          responsiveHW(context, wd: 100),
                          responsiveHW(context, ht: 80),
                          OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          pIcon: null,
                          fillColor: Colors.teal.shade200,
                          filled: true,
                          keyboardtype: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: responsiveHW(context, ht: 2),
                  // ),
                  // CustomText(txt: 'Birthday'),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.055,
                  //   width: MediaQuery.of(context).size.width * 0.45,
                  //   child: customDatePickerField(
                  //     "Birthday",
                  //     _datepicker,
                  //     responsiveHW(context, wd: 100),
                  //     responsiveHW(context, ht: 50),
                  //     OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(50.0),
                  //       borderSide: const BorderSide(
                  //         style: BorderStyle.none,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     fillColor: Colors.white,
                  //     filled: true,
                  //     suffixWidget: InkWell(
                  //       onTap: () {
                  //         showDatePicker(
                  //                 context: context,
                  //                 initialDate: DateTime.now(),
                  //                 firstDate: DateTime(1920),
                  //                 lastDate: DateTime.now())
                  //             .then((pickedDate) {
                  //           if (pickedDate == null) {
                  //             return;
                  //           }
                  //           setState(() {
                  //             _datepicker.text =
                  //                 "${pickedDate.day.toString()}/${pickedDate.month.toString()}/${pickedDate.year.toString()}";
                  //           });
                  //         });
                  //       },
                  //       child: const Icon(
                  //         Icons.date_range,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: responsiveHW(context, ht: 2),
                  ),
                  CustomText(txt: 'Country'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: customDropDownFormField(
                        ctx: context,
                        dropDownValue: selectedCountry,
                        fieldTitle: 'Country',
                        listOfItems: countrieslist.values.toList(),
                        onChangedFunc: (val) {
                          selectedCountry = val.toString();
                          setState(() {});
                        }),
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: 2),
                  ),
                  Consumer<ProfileUpdateProivder>(
                      builder: (context, updateprovider, _) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: updateprovider.issaving
                          ? CircularProgressIndicator(
                              color: Colors.teal.shade300,
                            )
                          : MaterialButton(
                              onPressed: () {
                                updateprovider.updateUserData(
                                    id: userDataMap['id'],
                                    name: _name.text.trim(),
                                    username: _username.text.trim(),
                                    email: _email.text.trim(),
                                    mobile: phonenumber.text.trim(),
                                    country: selectedCountry.toString(),
                                    password: userDataMap['dpassword']);
                              },
                              color: Colors.teal.shade200,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  )),
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.08,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Text(
                                ' Save ',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    // fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontFamily: font_family),
                              ),
                            ),
                    );
                  }),
                ],
              ),
            );
          }
        });
  }
}
