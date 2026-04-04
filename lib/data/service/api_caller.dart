import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_manager_apps/presentation/provider/auth_controller.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      print("TOKEN => ${AuthController.accessToken}");

      _logRequest(url);
      Response response = await get(
        uri,
        headers: {'token': AuthController.accessToken ?? ''},
      );
      _logResponse(url, response);

      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        // SUCCESS
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else if (statusCode == 401) {
        // await _moveToLogin();
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          errorMessage: 'Un-authorize',
          responseData: null,
        );
      } else {
        // FAILED
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMessage: decodedData['data'],
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ApiResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);

      Response response = await post(
        uri,
        headers: {
          'content-type': "application/json",
          'token': AuthController.accessToken ?? '',
        },
        body: jsonEncode(body),
      );

      _logResponse(url, response);

      final int statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: jsonDecode(response.body),
          errorMessage: null,
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: null,
          errorMessage: 'Request failed with status code $statusCode',
        );
      }
    } on Exception catch (e) {
      _logger.e('Error occurred while making POST request to $url: $e');
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL => $url\n'
      'Request Body: $body',
    );
  }

  static void _logResponse(String url, Response response) {
    _logger.i(
      'URL => $url\n'
      'Status Code: ${response.statusCode}\n'
      'Body: ${response.body}',
    );
  }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage,
  });
}
