import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//import '../../../AttendanceModule/Utills/Global Class/ColorHelper.dart';
import '../Provider/AdminProvider.dart';
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}
class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch comments when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false)
          .getAllComments(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);
    final comments = adminProvider.comments;
    final isLoading = adminProvider.isLoading;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.redAccent.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Comments",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 15,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: comments.isEmpty
            ? const Center(child: Text("No comments available"))
            : ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            final content = comment['content'] ?? 'No content';
            final createdAt = comment['createdAt'] ?? 'No date';
            final commentBy = comment['commentBy'] ?? 'No Name';
            final id = comment['_id'] ?? 'No id';
            final profile = comment['profile'] ?? '';

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: profile.isNotEmpty
                      ? NetworkImage(profile)
                      : const AssetImage('assets/default_avatar.png')
                  as ImageProvider,
                ),
                title: Text(
                  commentBy,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        _showContentDialog(
                            context, content ?? "No content available");
                      },
                      child: Text(
                        "Date: $createdAt",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    final provider = Provider.of<AdminProvider>(
                        context,
                        listen: false);
                    final commentId = id;

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Comment'),
                          content: const Text(
                              'Are you sure you want to delete this comment?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () async {
                                // Call the delete method from provider
                                await provider.deleteComment(
                                    context, commentId);
                                Navigator.of(context).pop(); // Close the dialog

                                // Fetch updated comments after deletion
                                provider.getAllComments(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showContentDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comment Content'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
