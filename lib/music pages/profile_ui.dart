import 'package:flutter/material.dart';
import 'package:music_app/constants.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({super.key});

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
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
              contentPadding: const EdgeInsets.all(15.0),
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
                  minWidth: MediaQuery.of(context).size.width * 0.01,
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
        ],
      ),
    );
  }
}
