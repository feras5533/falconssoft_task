import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../widgets/custom_snack_bar.dart';

class QuantityApi {
  static Future<List<Map<String, dynamic>>> fetchQuantities() async {
    try {
      final response = await http
          .get(Uri.parse(quantityApiUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> &&
            data['SalesMan_Items_Balance'] != null) {
          return List<Map<String, dynamic>>.from(
              data['SalesMan_Items_Balance']);
        } else {
          showCustomSnackBar(
            title: "Error",
            message: "Invalid response format from the server.",
            isError: true,
          );
          return [];
        }
      } else {
        showCustomSnackBar(
          title: "Error",
          message:
              'Failed to fetch quantities: ${response.statusCode} ${response.reasonPhrase}',
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
    } on FormatException {
      showCustomSnackBar(
        title: "Invalid Data",
        message: "Received invalid data from the server.",
        isError: true,
      );
      return [];
    } on TimeoutException catch (_) {
      showCustomSnackBar(
        title: "Timeout",
        message: "The request timed out. Please try again later.",
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
