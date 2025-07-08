import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data,{Map<String, String>? headers}) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.loginApiEndPoint,
        data,
        headers: headers
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data,{Map<String, String>? headers}) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.registerApiEndPoint,
        data,
        headers: headers
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
