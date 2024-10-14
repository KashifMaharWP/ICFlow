import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../API/login_user_detail.dart';
import '../../../Utills/Global Functions/SnackBar.dart';

class AdminProvider extends ChangeNotifier {
  List<dynamic> _comments = [];

  bool _isLoading = false;

  List<dynamic> get comments => _comments;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
// Method to get comments
  Future<void> getAllComments(BuildContext context) async {
    String url = "https://flow-backend-ic-production.up.railway.app/api/comment/getAllComments";

    try {
      setIsLoading(true);

      final token = Provider.of<UserDetail>(context, listen: false).token;
      print("Token: $token");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      ).timeout(Duration(seconds: 15), onTimeout: () {
        return http.Response('', 408); // Return timeout response
      });

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        print("Decoded JSON: $json");

        if (json['success'] == true) {
          if (json.containsKey('allComments')) {
            _comments = json['allComments'] as List<dynamic>;
            notifyListeners();  // Notify listeners to update UI
          } else {
            print("allComments field not found in response");
            showErrorSnackbar("allComments field not found in response", context);
          }
        } else {
          print("API call was not successful: ${json['message']}");
          showErrorSnackbar("API call was not successful: ${json['message']}", context);
        }
      } else if (response.statusCode == 408) {
        showErrorSnackbar('Internet error', context);
      } else {
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");
        showErrorSnackbar("Error: Failed to fetch comments", context);
      }
    } catch (e) {
      print("Exception: $e");
      showErrorSnackbar("An error occurred while fetching comments", context);
    } finally {
      setIsLoading(false);
    }
  }
  // Method to delete comment
  Future<void> deleteComment(BuildContext context, String commentId) async {
    String url = "https://flow-backend-ic-production.up.railway.app/api/comment/delete/$commentId";
    print("Deleting comment with ID: $commentId");
    try {
      setIsLoading(true);
      final token = Provider.of<UserDetail>(context, listen: false).token;

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token" // Add the Authorization header
        },
      );

      print("Delete response status: ${response.statusCode}");
      print("Delete response body: ${response.body}");

      if (response.statusCode == 200) {
        // Check if the response body contains the success message
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          showSuccessSnackbar("Comment Deleted Successfully", context);

          // Remove the deleted comment from the list of comments
          _comments.removeWhere((comment) => comment['id'] == commentId);
          notifyListeners();  // Update the UI
        } else {
          showErrorSnackbar("Failed to delete comment: ${jsonResponse['message']}", context);
        }
      } else {
        showErrorSnackbar("Failed to delete comment. Status Code: ${response.statusCode}", context);
      }
    } catch (e) {
      showErrorSnackbar("An error occurred while deleting the comment: $e", context);
    } finally {
      setIsLoading(false);
    }
  }

  void fetchComments(BuildContext context) {}



// You can add other necessary methods here
}

void showErrorSnackbar(String message, BuildContext context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
