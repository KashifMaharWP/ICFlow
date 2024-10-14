//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/Widgets/rounded_button.dart';
//import '../../../AttendanceModule/Utills/Global Class/ColorHelper.dart';
//import '../../../AttendanceModule/Utills/Global Class/ScreenSize.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../Provider/commentProvider.dart';

class CommentUserScreen extends StatefulWidget {
  const CommentUserScreen({super.key});

  @override
  State<CommentUserScreen> createState() => _CommentUserScreenState();
}

class _CommentUserScreenState extends State<CommentUserScreen> {
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch the user's comments when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommentProvider>(context, listen: false).getMyComments(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.redAccent.shade700,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Complains",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: screenWidth / 15,
                fontWeight:FontWeight.w300,
                color: whiteColor,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              inputCommentSection(),
              const SizedBox(height: 20),
              Expanded(child: commentHistorySection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputCommentSection() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Write your complain:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: commentController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter your complain here',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            maxLines: 4,
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a complain';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Consumer<CommentProvider>(
              builder: (context, commentProvider, child) {
                return RoundedButton(
                  title: 'Send Now',
                  loading: commentProvider.isLoading,
                  on_Tap: () {
                    if (_formKey.currentState!.validate()) {
                      commentProvider.addComment(context, commentController.text.trim());
                      commentController.clear(); // Clear the input after submission
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget commentHistorySection() {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        if (commentProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (commentProvider.comments.isEmpty) {
          return const Center(
            child: Text('No comments found', style: TextStyle(color: Colors.grey)),
          );
        }
        var commentData = commentProvider.comments.reversed.toList();
        return ListView.builder(
          itemCount: commentData.length,
          itemBuilder: (context, index) {
            final comment = commentData[index];
            final content = comment['content'] ?? 'No content';
            final createdAt = comment['createdAt'] ?? 'No date';
            final commentId = comment['_id'] ?? '';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.comment, color: Colors.redAccent, size: 30),
                  title: InkWell(
                    onTap: () {
                      _showContentDialog(context, content);
                    },
                    child: Text(
                      createdAt,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showEditDeleteOptions(context, comment, commentId),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showContentDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Content'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDeleteOptions(BuildContext context, dynamic comment, String commentID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose an Option',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.blue),
                  title: const Text('Modify', style: TextStyle(fontWeight: FontWeight.w600)),
                  tileColor: Colors.blue.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onTap: () {
                    Navigator.pop(context);
                    _editComment(comment, commentID);
                  },
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Withdraw', style: TextStyle(fontWeight: FontWeight.w600)),
                  tileColor: Colors.red.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onTap: () {
                    Navigator.pop(context);
                    _deleteComment(commentID);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editComment(dynamic comment, String commentID) {
    commentController.text = comment['content'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modify Complain'),
          content: TextFormField(
            controller: commentController,
            decoration: const InputDecoration(hintText: 'Enter your updated complain'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                String updatedComment = commentController.text.trim();
                if (updatedComment.isNotEmpty) {
                  Provider.of<CommentProvider>(context, listen: false)
                      .updateComment(context, commentID, updatedComment)
                      .then((_) {
                    // Close the dialog after the update
                    Navigator.of(context).pop();
                  });
                  commentController.clear(); // Clear the controller after the update
                } else {
                  print("Complain cannot be empty");
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteComment(String id) {
    Provider.of<CommentProvider>(context, listen: false).deleteComment(context, id);
  }
}
