import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Routes/myroutes.dart';

// ignore: must_be_immutable
class MessageDialog extends StatefulWidget {
  MessageDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.btnType});

  String title;
  String description;
  int btnType = 1;

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
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
              widget.btnType == 2
                  ? Row(
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
                              if (widget.title == "Logout") {
                                _clearPrefences();
                                Navigator.pushNamed(
                                    context, AppRoutes.loginPage);
                              }
                            },
                            child: const Text("Yes")),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"))
            ],
          )
        ],
      ),
    );
  }

  Future<void> _clearPrefences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', '');
    await prefs.setString('fullName', '');
    await prefs.setString('email', '');
    await prefs.setString('userRole', '');
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
