import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../../Widgets/Global Widgets/customText.dart';

class customFiltersWidget extends StatefulWidget {
  const customFiltersWidget({super.key});

  @override
  State<customFiltersWidget> createState() => _customFiltersWidgetState();
}

class _customFiltersWidgetState extends State<customFiltersWidget> {
  String selectedFilter = "All";
  String selectedDate=DateFormat("dd MMMM yyyy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: [
          customFilter(
            "All",
            whiteColor,
            blackColor,
            primary,
            selectedFilter == "All",
          ),
          SizedBox(width: 4),
          customFilter(
            "Casual",
            whiteColor,
            blackColor,
            Colors.amber,
            selectedFilter == "Casual",
          ),
          SizedBox(width: 4),
          customFilter(
            "Sick",
            whiteColor,
            blackColor,
            Colors.green,
            selectedFilter == "Sick",
          ),
        ],
      );
    }

  // customFilter
  Widget customFilter(String text, Color backgroundColor, Color selectColor, Color iconColor,bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text; // Update the selected filter when tapped
        });
      },
      child: Container(
        width: screenWidth / 4,
        height: screenHeight / 22,
        decoration: BoxDecoration(
          color: isSelected ? CupertinoColors.systemGrey5: backgroundColor, // Change background if selected
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Only show the icon if the filter is not selected
              if (!isSelected) Icon(Icons.circle, size: screenWidth / 24, color: iconColor),
              SizedBox(width: screenWidth / 60),
              customText(
                text: text,
                fontSize: screenWidth / 24,
                fontColor: isSelected ? blackColor : selectColor, // Change text color if selected
              ),
            ],
          ),
        ),
      ),
    );
  }
}
