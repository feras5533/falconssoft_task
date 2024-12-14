import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../widgets/custom_snack_bar.dart';

class ItemsApi {
  static Future<List<Map<String, dynamic>>> fetchItems() async {
    try {
      final response = await http
          .get(
            Uri.parse(itemsApiUrl),
          )
          .timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data['Items_Master'] != null) {
          return List<Map<String, dynamic>>.from(data['Items_Master']);
        } else {
          showCustomSnackBar(
            title: "Invalid Data",
            message: "The server returned unexpected data. Please try again.",
            isError: true,
          );
          return [];
        }
      } else {
        showCustomSnackBar(
          title: "Error",
          message:
              'Failed to fetch items: ${response.statusCode} ${response.reasonPhrase}',
          isError: true,
        );
        return [];
      }
    } on SocketException catch (_) {
      showCustomSnackBar(
        title: "Network Error",
        message: "Please check your internet connection and try again.",
        isError: true,
      );
      return [];
    } on http.ClientException catch (_) {
      showCustomSnackBar(
        title: "Client Error",
        message: "A client-side error occurred. Please try again later.",
        isError: true,
      );
      return [];
    } on FormatException catch (_) {
      showCustomSnackBar(
        title: "Invalid Data",
        message:
            "Received invalid data from the server. Please try again later.",
        isError: true,
      );
      return [];
    } on TimeoutException catch (_) {
      showCustomSnackBar(
        title: "Request Timeout",
        message: "The request to the server timed out. Please try again.",
        isError: true,
      );
      return [];
    } catch (e) {
      showCustomSnackBar(
        title: "Error",
        message: "An unexpected error occurred. Please try again later.",
        isError: true,
      );
      return [];
    }
  }
}
