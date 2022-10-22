import 'package:flutter/material.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({super.key});

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _datepicker = TextEditingController(text: 'dd:mm:yyyy');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                // backgroundImage: NetworkImage(
                //   'https://w7.pngwing.com/pngs/831/88/png-transparent-user-profile-computer-icons-user-interface-mystique-miscellaneous-user-interface-design-smile.png',
                // ),
              ),
              title: Text(
                "+911234567891",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: font_family_bold,
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: MaterialButton(
                  onPressed: () {},
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
            height: responsiveHW(context, ht: .15),
          ),
          Center(
            child: MaterialButton(
              onPressed: () {},
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
            height: responsiveHW(context, ht: 3),
          ),
          Center(
            child: SizedBox(
              // height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.5,
              child: customTextField(
                "First Name",
                false,
                null,
                _firstname,
                (value) {},
                (value) {
                  _firstname.text = value!;
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
          ),
          SizedBox(
            height: responsiveHW(context, ht: 3),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: customTextField(
                "Last Name",
                false,
                null,
                _lastname,
                (value) {},
                (value) {
                  _lastname.text = value!;
                },
                responsiveHW(context, wd: 100),
                responsiveHW(context, ht: 100),
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
          ),
          SizedBox(
            height: responsiveHW(context, ht: 3),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
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
                responsiveHW(context, ht: 100),
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
          ),
          SizedBox(
            height: responsiveHW(context, ht: 3),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: customDatePickerField(
                "Birthday",
                _datepicker,
                responsiveHW(context, wd: 100),
                responsiveHW(context, ht: 50),
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    color: Colors.white,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixWidget: InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now())
                        .then((pickedDate) {
                      if (pickedDate == null) {
                        return;
                      }
                      setState(() {
                        _datepicker.text =
                            "${pickedDate.day.toString()}/${pickedDate.month.toString()}/${pickedDate.year.toString()}";
                      });
                    });
                  },
                  child: const Icon(
                    Icons.date_range,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
