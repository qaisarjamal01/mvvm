import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  // Default headers you want to always send (e.g., Content-Type)
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data, {Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final mergedHeaders = _mergeHeaders(headers);
      final response = await http
          .post(Uri.parse(url), headers: mergedHeaders, body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      case 404:
        throw FetchDataException(
            'Error Occurred while communicating with server: Status code ${response.statusCode}');
      default:
        throw FetchDataException(
            'Unexpected error with status code ${response.statusCode}');
    }
  }

  Map<String, String> _mergeHeaders(Map<String, String>? customHeaders) {
    // Combine default headers with custom headers (custom overrides default)
    return {..._defaultHeaders, if (customHeaders != null) ...customHeaders};
  }
}