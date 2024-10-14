import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:taskflow_application/AttendanceModule/Utills/Global%20Class/GlobalAPI.dart';
//import 'package:taskflow_application/AttendanceModule/Utills/Global%20Functions/SnackBar.dart';
import 'package:http/http.dart' as http;
import '../../../../API/login_user_detail.dart';
//import '../../../API/login_user_detail.dart';

import '../../../Utills/Global Class/GlobalAPI.dart';
import '../../../Utills/Global Functions/SnackBar.dart';
//t '../../../Utills/Global Class/GlobalAPI.dart';

class CommentProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<dynamic> _comments = [];

  List<dynamic> get comments => _comments;

  // Method to set loading state
  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Method to add comment
  Future<void> addComment(BuildContext context, String comment) async {
    String url = "https://flow-backend-ic-production.up.railway.app/api/comment/create";
    final body = {
      "content": comment,
    };

    try {
      setIsLoading(true);
      final token = Provider.of<UserDetail>(context, listen: false).token;

      // HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        if (json.isNotEmpty) {
          showSuccessSnackbar("Comment Successfully", context);
          await fetchComments(context); // Fetch updated comments
        } else {
          showErrorSnackbar("Server is not responding", context);
        }
      } else {
        showErrorSnackbar("Error: Server is not responding", context);
      }
    } catch (e) {
      showErrorSnackbar("An error occurred", context);
    } finally {
      setIsLoading(false);
    }
  }

  // Method to fetch all comments
  Future<void> getMyComments(BuildContext context) async {
    String url = "https://flow-backend-ic-production.up.railway.app/api/comment/getMyComments";

    try {
      setIsLoading(true);
      final token = Provider.of<UserDetail>(context, listen: false).token;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).timeout(Duration(seconds: 15), onTimeout: () {
        return http.Response('', 408);
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;

        if (json['success'] == true) {
          if (json.containsKey('myComments')) {
            _comments = json['myComments'] as List<dynamic>;
            notifyListeners(); // Notify listeners to update UI
          } else {
            showErrorSnackbar("myComments field not found", context);
          }
        } else {
          showErrorSnackbar("API call failed: ${json['message']}", context);
        }
      } else if (response.statusCode == 408) {
        showErrorSnackbar('Internet error', context);
      } else {
        showErrorSnackbar("Failed to fetch comments", context);
      }
    } catch (e) {
      showErrorSnackbar("An error occurred while fetching comments", context);
    } finally {
      setIsLoading(false);
    }
  }

  // Method to update comment
  Future<void> updateComment(BuildContext context, String commentId, String updatedComment) async {
    String url = "https://flow-backend-ic-production.up.railway.app/api/comment/update/$commentId";

    //String url = "${ApiDetail.BaseAPI}/comment/update/$commentId";
    try {
      setIsLoading(true);
      final token = Provider.of<UserDetail>(context, listen: false).token;
      print('token ${token}');

      // Body to include updated comment content
      final body = {
        "content": updatedComment,
      };

      // HTTP PUT request
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body), // Include body with updated comment
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        if (json['success'] == true) {
          showSuccessSnackbar("Comment Updated Successfully", context);
          await fetchComments(context); // Fetch updated comments

          // Close the dialog only after successfully updating
          Navigator.of(context).pop();
        } else {
          showErrorSnackbar("Update failed: ${json['message']}", context);
        }
      } else {
        showErrorSnackbar("Failed to update comment", context);
      }
    } catch (e) {
      showErrorSnackbar("An error occurred while updating comment", context);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> deleteComment(BuildContext context, String commentId) async {
    String url = "https://flow-backend-ic-production.up.railway.app/api/comment/delete/$commentId";
    print(commentId);
    try {
      setIsLoading(true);
      final token = Provider.of<UserDetail>(context, listen: false).token;

      final response = await http.delete(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        showSuccessSnackbar("Comment Deleted Successfully", context);
        fetchComments(context); // Fetch updated comments
      } else {
        print("response delete ${response.body}");
        showErrorSnackbar("Failed to delete comment", context);
      }
    } catch (e) {
      showErrorSnackbar("An error occurred while deleting comment", context);
    } finally {
      setIsLoading(false);
    }
  }

  // Helper method to fetch updated comments
  Future<void> fetchComments(BuildContext context) async {
    await getMyComments(context); // Call the method to fetch comments again
  }
}




