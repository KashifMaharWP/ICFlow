import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../Utills/Global Class/ColorHelper.dart';
import '../../Utills/Global Class/ScreenSize.dart';
import '../../Utills/Global Functions/SnackBar.dart';
import 'Class/TeamLeads.dart';
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
TeamLeads? selectedTeamLead;
List<TeamLeads> teamLeads = [];


@override
class _LeaveFormScreenState extends State<LeaveFormScreen> {

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        initialDate = args.value.startDate;
        lastDate = args.value.endDate;
      });
    }
  }

  int _calculateDaysBetween(DateTime? start, DateTime? end) {
    if (start == null || end == null) return 0;
    return end.difference(start).inDays + 1; // Add 1 to include the last day
  }

  void reset() {
    _dateRangePickerController.selectedRange = null;
    setState(() {
      countdays==null;
      initialDate=null;
      lastDate=null;
    });
  }

  void ResetAll(){
    reset();
    setState(() {
      Remark.clear();
      selectedTeamLead=null;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTeamLeadNames();
  }

  Future<void> _loadTeamLeadNames()async{
    List<TeamLeads> leads=await TeamLeadListProvider().GetTeamLeadLsit(context);
    setState(() {
      teamLeads=leads;
    });
  }


  @override
  Widget build(BuildContext context) {
    int countdays=_calculateDaysBetween(initialDate,lastDate);
   //print("${teamLeads[0].fullName}");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          iconTheme: IconThemeData(color: whiteColor),
        ),
      body: Material(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                calendarContainer(),
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
      height: screenHeight/2.3,
      decoration: BoxDecoration(
        color: primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dateSelectionBar(),

          SizedBox(
            width: 5,
          ),

          sfDatePicker()
        ],
      ),
    );
  }

  //Date Selection Side Bar Widget
  Widget dateSelectionBar(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            reset();
          },
          child: Container(
            margin: EdgeInsets.only(top: screenHeight/30),
            child: Text(initialDate==null?"":'Clear',style: GoogleFonts.roboto(
                color: Colors.white,
                textStyle: TextStyle(
                  fontSize: screenWidth/20,
                  fontWeight: FontWeight.w400,

                )
            ),),
          ),
        ),
        SizedBox(
          height: screenHeight/40,
        ),
        initialDate!=null?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: screenWidth/15,
              backgroundColor: Colors.white,
              child: Center(
                child: Text(initialDate!=null ? DateFormat("dd").format(initialDate!):"",style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: screenWidth/15,
                        color: primary,
                        fontWeight: FontWeight.bold

                    )
                ),),
              ),
            ),
            SizedBox(
              height: screenHeight/60,
            ),
            Center(
              child: Icon(
                FontAwesomeIcons.arrowDownLong,
                color: Colors.white,
                size: screenHeight/25,
              ),
            ),

            SizedBox(
              height: screenHeight/60,
            ),
            lastDate!=null?CircleAvatar(
              radius: screenWidth/15,
              backgroundColor: Colors.white,
              child: Center(
                child: Text("${DateFormat("dd").format(lastDate!)}",style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: screenWidth/15,
                        color: primary,
                        fontWeight: FontWeight.bold

                    )
                ),),
              ),
            ):Container(),

            SizedBox(
              height: screenHeight/50,
            ),

            Text("${countdays} Days",style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth/20,
                    fontWeight: FontWeight.bold
                )
            ),)
          ],
        ):Container(),
      ],
    );
  }

  //Calender to Pick Date Range Widget
  Widget sfDatePicker(){
    return SizedBox(
      height: screenHeight/2.5, // Adjust the height as needed
      width: screenWidth*0.75, // Adjust the width as needed
      child: SfDateRangePicker(
        backgroundColor: primary,
        startRangeSelectionColor: Colors.white,
        endRangeSelectionColor: Colors.white,
        rangeSelectionColor: Colors.black26,
        todayHighlightColor: Colors.white,
        selectionTextStyle: GoogleFonts.roboto(
            fontSize: screenWidth/20,
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
        rangeTextStyle: GoogleFonts.roboto(
            fontSize: screenWidth/24,
            color: Colors.white
        ),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: GoogleFonts.roboto(
            fontSize: screenWidth/22,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          todayTextStyle: GoogleFonts.roboto(
              color: Colors.white,
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
            backgroundColor: primary,
            textStyle: GoogleFonts.roboto(
                fontSize: screenWidth/15,
                color: Colors.white
            )
        ),


        monthViewSettings: DateRangePickerMonthViewSettings(
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: GoogleFonts.roboto(
                  fontSize: screenWidth/25,
                  color: Colors.white,
                )
            )
        ),
        minDate: DateTime.now(),
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.range,
        onSelectionChanged: _onSelectionChanged,
        controller: _dateRangePickerController,
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
            DropdownButtonFormField<TeamLeads>(
              value: selectedTeamLead,
              hint: Text(
                'Select Team Lead',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: screenWidth / 30,
                  ),
                ),
              ),

              onChanged: (TeamLeads? newValue) {
                setState(() {
                  selectedTeamLead = newValue;
                });
              },
              items: teamLeads.map((teamLead) {
                return DropdownMenuItem<TeamLeads>(
                    alignment: Alignment.centerLeft,
                    value: teamLead,
                    child: Container(
                      child: Text(teamLead.fullName),
                    )
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return "Select Your Team Lead";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(),
              ),
            ),


            SizedBox(
              height: screenHeight/50,
            ),

            TextFormField(
              controller: Remark,
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                hintText: "Please Enter Remark",
                labelText: "Remark",
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

            ElevatedButton(
                onPressed: (){
                  if(_LeaveformKey.currentState!.validate()){
                    if(initialDate==null || lastDate==null){
                      showErrorSnackbar("Please Select Leave Date", context);
                    }
                    else{
                      showSuccessSnackbar("You Successfully Applied for Leave", context);
                      ResetAll();
                    }
                  }

                },style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth/4, vertical: screenHeight/60),
            ),
                child: Text("Apply for Leave",style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: screenWidth/20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )
                ),)
            )
          ],
        ),
      ),
    );
  }

}



