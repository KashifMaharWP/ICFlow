import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Screens/Login%20screens/login_page.dart';

// ignore: must_be_immutable
class ConfirmationDialog extends StatefulWidget {
  ConfirmationDialog(
      {super.key, required this.title, required this.description});

  String title;
  String description;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: AlertDialog(
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: DeviceInfo.fontSize + 2, color: Colors.blue),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(widget.description),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No")),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //if the pressed button it logout then
                        if (widget.title == "Logout") {
                          //clearing the preferences
                          Provider.of<UserDetail>(context, listen: false)
                              .clearUserPreferences();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()));
                        }
                      },
                      child: const Text("Yes")),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


// Widget confirmationDialog(BuildContext context, ) {
//   return SizedBox(
//     width: 200,
//     height: 200,
//     child: AlertDialog(
//       actions: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                   fontSize: DeviceScreen.fontSize + 2, color: Colors.blue),
//             ),
//             const SizedBox(
//               height: 7,
//             ),
//             Text(description),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text("No")),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       //Here we are clearing the user data from the preferences then
//                       // moving the user to the sign In page
//                       yesBtnTap;
//                       // _clearPrefences();
//                       // N
//                     },
//                     child: const Text("Yes")),
//               ],
//             )
//           ],
//         )
//       ],
//     ),
//   );
// }
