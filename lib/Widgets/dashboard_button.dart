import 'package:flutter/material.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';

class CustomDashboardButton extends StatefulWidget {
  final colors;
  final btnName;
  final VoidCallback ontap;
  const CustomDashboardButton(
      {super.key,
      required this.colors,
      required this.btnName,
      required this.ontap});

  @override
  State<CustomDashboardButton> createState() => _CustomDashboardButtonState();
}

class _CustomDashboardButtonState extends State<CustomDashboardButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: widget.colors == Colors.red
                    ? [Colors.red, Colors.redAccent]
                    : widget.colors == Colors.green
                        ? [
                            Colors.green,
                            const Color.fromARGB(255, 50, 255, 156)
                          ]
                        : widget.colors == Colors.yellow
                            ? [
                                const Color.fromARGB(255, 164, 2, 7),
                                const Color.fromARGB(255, 228, 4, 4)
                              ]
                            : widget.colors == Colors.blue
                                ? [
                                    const Color.fromARGB(255, 8, 125, 221),
                                    const Color.fromARGB(255, 102, 155, 247)
                                  ]
                                : []),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3, 3),
                  color: Colors.grey.shade500.withOpacity(0.7),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: Padding(
          padding: EdgeInsets.only(top: DeviceInfo.width * 0.04, left: 20),
          child: Text(
            widget.btnName,
            style: TextStyle(
                color: Colors.white,
                fontSize: DeviceInfo.fontSize + 2,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
