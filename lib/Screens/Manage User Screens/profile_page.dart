import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/designation_model.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Classes/manageUser_class.dart';
import 'package:taskflow_application/Widgets/textfield.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key, this.users, this.isCurrentUserProfile});
  late ManageUser? users;
  bool? isCurrentUserProfile;

  @override
  State<UserProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfilePage> {
  late UserDetail currentUser;
  bool isCurrentUser = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.users == null) {
      currentUser = Provider.of<UserDetail>(context, listen: false);
      isCurrentUser = true;
      print("UserName: ${currentUser.fullname}");
    }
  }

  Future<void> _showImageSourceSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(CupertinoIcons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
        // Upload the image after picking it
        await _uploadProfileImage(File(image.path));
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _uploadProfileImage(File imageFile) async {
    try {
      const String url = "https://flow-backend-ic-production-932b.up.railway.app/api/user/updatePicture";
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      // Attach the file to the request
      request.files.add(await http.MultipartFile.fromPath('profileImage', imageFile.path));

      // Add headers (ensure the token is correctly set)
      request.headers.addAll({
          "Content-Type": "application/json",
          "Authorization":
          "Bearer ${Provider
              .of<UserDetail>(context, listen: false)
              .token} "

        //'Authorization': 'Bearer authToken', // Replace with a valid token
      });

      // Send the request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
        print("Response: $responseData");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to upload image. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload image. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          pageHeaderContainer(),
          const SizedBox(height: 15),
          ProfileFieldWidget(
            "Email",
            isCurrentUser ? currentUser.email.toString() : widget.users!.email.toString(),
            CupertinoIcons.envelope,
          ),
          const SizedBox(height: 10),
          ProfileFieldWidget(
            "Contact",
            isCurrentUser ? currentUser.contact.toString() : widget.users!.contact.toString(),
            CupertinoIcons.phone,
          ),
          const SizedBox(height: 10),
          ProfileFieldWidget(
            "Address",
            isCurrentUser ? currentUser.address.toString() : widget.users!.address.toString(),
            CupertinoIcons.text_badge_star,
          ),
          const SizedBox(height: 10),
          ProfileFieldWidget(
            "Designation",
            Provider.of<Designation>(context, listen: false).getDesignationName(
                isCurrentUser ? currentUser.designationId.toString() : widget.users!.designationId.toString()),
            CupertinoIcons.rocket,
          ),
        ],
      ),
    );
  }

  Widget pageHeaderContainer() {
    return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          gradient: RadialGradient(colors: [
            Colors.redAccent,
            Colors.red.shade900,
            const Color.fromARGB(255, 114, 9, 1)
          ]),
        ),
        child: Column(
          children: [
            SizedBox(height: DeviceInfo.height * 0.04),
            customNavigationBar(),
            SizedBox(height: DeviceInfo.height * 0.04),
            Center(
              child: Stack(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: DeviceInfo.width * 0.35,
                      height: DeviceInfo.width * 0.35,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: _selectedImage == null
                          ? Image.asset(
                        "assets/images/usericon.png",
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        CupertinoIcons.pencil,
                        color: Colors.black,
                        size: 28,
                      ),
                      onPressed: _showImageSourceSheet,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              isCurrentUser ? currentUser.fullname.toString() : widget.users!.fullname.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            Text(
              isCurrentUser
                  ? Provider.of<Designation>(context, listen: false)
                  .getDesignationName(currentUser.designationId.toString())
                  : Provider.of<Designation>(context, listen: false)
                  .getDesignationName(widget.users!.designationId.toString()),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              isCurrentUser
                  ? currentUser.roleId == "1"
                  ? "Admin"
                  : currentUser.roleId == "2"
                  ? "Team Lead"
                  : "Team Member"
                  : widget.users!.roleId == "1"
                  ? "Admin"
                  : widget.users!.roleId == "2"
                  ? "Team Lead"
                  : "Team Member",
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget customNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isCurrentUserProfile!
              ? const Text("         ")
              : IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back),
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          PopupMenuButton(
              initialValue: 1,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(onTap: () {}, value: 1, child: const Text("Edit")),
                  PopupMenuItem(onTap: () {}, value: 2, child: const Text("Delete Account"))
                ];
              },
              icon: const Icon(
                CupertinoIcons.settings,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget ProfileFieldWidget(String title, String displayData, IconData fieldIcon) {
    return Container(
      height: DeviceInfo.width * 0.13,
      width: DeviceInfo.width - 30,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(fieldIcon, color: Colors.red.shade800),
              const SizedBox(width: 5),
              Text(title, style: TextStyle(color: Colors.black.withOpacity(0.7))),
            ],
          ),
          const Spacer(),
          Text(displayData, style: TextStyle(color: Colors.black.withOpacity(0.7))),
        ],
      ),
    );
  }
}
