import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_pilot/presentation/provider/auth_controller.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      headers ??= {"Content-Type": "application/json"};

      final token = AuthController.accessToken;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
      }

      _logRequest(url);
      Response response = await get(uri, headers: headers);
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
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      headers ??= {"Content-Type": "application/json"};

      final token = AuthController.accessToken;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
      }

      _logRequest(url, body: body);

      Response response = await post(
        uri,
        headers: headers,
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
        final decodedBody = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: null,
          errorMessage: decodedBody['message'] ?? "Something went wrong",
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
