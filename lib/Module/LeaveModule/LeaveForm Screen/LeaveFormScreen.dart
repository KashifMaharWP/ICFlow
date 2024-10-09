import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:taskflow_application/Widgets/rounded_button.dart';
import '../../Utills/Global Class/ColorHelper.dart';
import '../../Utills/Global Class/ScreenSize.dart';
import '../../Utills/Global Functions/SnackBar.dart';
import '../../Widgets/Global Widgets/customNoBoldText.dart';
import '../../Widgets/Global Widgets/customText.dart';
import 'Class/TeamLeads.dart';
import 'Function/confirmLeaveBox.dart';
import 'Provider/LeaveFormProvider.dart';

class LeaveFormScreen extends StatefulWidget {
  const LeaveFormScreen({super.key});

  @override
  State<LeaveFormScreen> createState() => _LeaveFormScreenState();
}
DateTime? initialDate;
DateTime? lastDate;

int countdays=0;
DateRangePickerController _dateRangePickerController = DateRangePickerController();
final Remark = TextEditingController();
final _LeaveformKey=GlobalKey<FormState>();
String _fileText = "";
String _fileName="Pick a File (.jpg .png)";
File? _file;
bool isClearShow=false;
String? leaveType ;
var leaveTypeItem = [
  'Sick',
  'Casual',
];

@override
class _LeaveFormScreenState extends State<LeaveFormScreen> {

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        initialDate = args.value.startDate;
        //Checking Last date is selected or not
        lastDate = args.value.endDate ?? initialDate;
        isClearShow=true;
      });
    }
  }

  int _calculateDaysBetween(DateTime? start, DateTime? end) {
    if (start == null || end == null) return 0;
    return end.difference(start).inDays + 1; // Add 1 to include the last day
  }

  void reset()  {
    _dateRangePickerController.selectedRange = null;
    setState(() {
      countdays=0;
      initialDate=null;
      lastDate=null;
    });
  }

  Future<void> ResetAll() async{
    reset();
    setState(() {
      Remark.clear();
      //selectedTeamLead=null;
      _file=null;
      _fileName="Pick a File (.jpg .png)";
      isClearShow=false;
      leaveType=null;

    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    ResetAll();
  }


  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null && result.files.single.path != null) {
      /// Load result and file details
      PlatformFile file = result.files.first;
      //_fileName=file.name;

      /// normal file
      _file = File(result.files.single.path!);
      setState(() {
        _fileText = _file!.path;
        _fileName=file.name;
        isClearShow=true;
      });
    } else {
      /// User canceled the picker
      _fileName="";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.redAccent.shade700,
          foregroundColor: Colors.white,
          centerTitle: true,
          shadowColor: Colors.black,
          title: const Text("Manage Leave"),
        ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                sfDatePicker(),
                formField()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget calendarContainer(){
    return Container(
      height: screenHeight/3,
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sfDatePicker()
        ],
      ),
    );
  }


  //Calender to Pick Date Range Widget
  Widget sfDatePicker(){
    return Container(
      height: screenHeight/2.6, // Adjust the height as needed
      width: screenWidth,
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(screenWidth/10),
          bottomRight: Radius.circular(screenWidth/10)
        ),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey4,
            offset: Offset(2, 2),
            blurRadius: 10
          )
        ]
      ),// Adjust the width as needed
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.zero,
            height:isClearShow==true?screenHeight/3:screenHeight/2.7 , // Adjust the height as needed
            width: screenWidth,
            child: SfDateRangePicker(
              backgroundColor: Colors.transparent,
              startRangeSelectionColor: Colors.redAccent.shade200,
              endRangeSelectionColor: Colors.redAccent.shade200,
              rangeSelectionColor: Colors.redAccent.shade100,
              todayHighlightColor: blackColor,
              selectionTextStyle: GoogleFonts.roboto(
                  fontSize: screenWidth/20,
                  color: whiteColor,
                  fontWeight: FontWeight.bold
              ),
              rangeTextStyle: GoogleFonts.roboto(
                  fontSize: screenWidth/24,
                  color: blackColor
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: GoogleFonts.roboto(
                  fontSize: screenWidth/22,
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
                todayTextStyle: GoogleFonts.roboto(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth/20

                ),
                weekendTextStyle: GoogleFonts.roboto(
                    color: Colors.amber,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth/24
                ),
                disabledDatesTextStyle: GoogleFonts.roboto(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth/24// Disabled dates text color
                ),

              ),
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: whiteColor,
                  textStyle: GoogleFonts.roboto(
                      fontSize: screenWidth/15,
                      color: blackColor
                  )
              ),


              monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: GoogleFonts.roboto(
                        fontSize: screenWidth/25,
                        color: blackColor,
                      )
                  )
              ),
              minDate: DateTime.now(),
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: _onSelectionChanged,
              controller: _dateRangePickerController,
            ),
          ),
        isClearShow==true?InkWell(
            onTap: (){
              ResetAll();
            },
            child: customNoBoldText(
            text: "Clear",
            fontSize: screenWidth/22,
            fontColor: blackColor
                    ),
          ):Container(
            height: 0,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
          )
        ],
      ),
    );
  }

  //Form Field Widget to apply for leave
  Widget formField(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _LeaveformKey,
        child: Column(
          children: [

            //DropDown Menu
            DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              value: leaveType,
              hint: Text(
                'Select Leave Type',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: screenWidth / 30,
                  ),
                ),
              ),

              onChanged: (String? newValue) {
                setState(() {
                  leaveType = newValue!;
                });
              },
              items: leaveTypeItem.map((String items) {
                return DropdownMenuItem<String>(
                    alignment: Alignment.centerLeft,
                    value: items,
                    child: Text(items.toString())
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return "Select Leave Type";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: screenWidth/20,
            ),


            TextFormField(
              controller: Remark,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                hintText: "Please Enter Remark",
                labelText: "*Remark",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty ){
                  return "Remark Field is Empty";
                }
                else{
                  return null;
                }
              },//Validator
            ),
            SizedBox(
              height: screenHeight/40,
            ),
            InkWell(
              onTap: _pickFile,
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.all(screenWidth/25),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: Colors.black54,width: 1,),
                  borderRadius: BorderRadius.circular(2)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: customText(
                            text: _fileName, fontSize: screenWidth/26, fontColor: lightBlackColor)
                    ),
                    const Icon(FontAwesomeIcons.arrowUpFromBracket)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight/40,
            ),
            RoundedButton(
                title: "Apply",
                loading: false,
                on_Tap: _applyLeave
            ),

          ],
        ),
      ),
    );
  }

//Leave Application method
  void _applyLeave() async{
    if(_LeaveformKey.currentState!.validate()){
      if(initialDate==null || lastDate==null){
        showErrorSnackbar("Please Select Leave Date", context);
      }
      else{
        countdays=_calculateDaysBetween(initialDate, lastDate).toInt();
        await confirmLeaveBox(
            _file,
            context,
            DateFormat("EEE dd MM yyyy").format(initialDate!).toString(),
            DateFormat("EEE dd MM yyyy").format(lastDate!).toString(),
            countdays.toString(),
            leaveType.toString(),
            Remark.text.toString()
        );

        await Provider.of<LeaveFormProvider>(context,listen: false).isSuccessful?ResetAll():null;

      }
    }
  }
}


