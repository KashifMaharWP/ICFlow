import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Widgets/textfield3.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  //defining the controllers for the text fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: DeviceInfo.height * 0.05,
            ),
            customNavigationBar(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFieldWidget3(
                      title: "Title", controller: _titleController, maxLine: 1),
                  SizedBox(
                    height: DeviceInfo.height * 0.04,
                  ),
                  dateFieldWidget()
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //const Spacer(),
            pageHeaderContainer()
          ],
        ),
      ),
    );
  }

  Widget pageHeaderContainer() {
    return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.1,
        // height: MediaQuery.of(context).size.height.,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 228, 24, 24),
              Colors.red.shade900,
              const Color.fromARGB(255, 114, 9, 1)
            ])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: DeviceInfo.height * 0.04,
              ),
              TextFieldWidget3(
                  title: "Description",
                  controller: _descriptionController,
                  maxLine: 2)

              // Text field to write the project name and the description of the project
            ],
          ),
        ),
      ),
    );
  }

//custom widget for the date field
  Widget dateFieldWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: DeviceInfo.width / 1.5,
          child: TextField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Start Date',
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
            ),
            readOnly: true,
          ),
        ),
        IconButton(
          onPressed: () => _selectDate(context),
          icon: const Icon(CupertinoIcons.calendar),
        )
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(2000),
    //   lastDate: DateTime(2101),
    // );
    debugPrint("selected Date: $picked");
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
        //_dateController.text = "${picked.}";
      });
    }
  }

//Widget for the custom navigation bar
  Widget customNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //back button
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.back,
                ),
              ),
              SizedBox(
                height: DeviceInfo.height * 0.035,
              ),
              // Displaying Text
              Text(
                "Create New Project",
                style: TextStyle(
                    fontSize: DeviceInfo.width * 0.08,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600),
              ),

              //Settings button to edit or Delete the user
            ],
          ),
        ],
      ),
    );
  }
}
