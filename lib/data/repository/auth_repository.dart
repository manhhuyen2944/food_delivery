// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(
        AppConstants.registrationUrl, signUpModel.toJson());
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }
}
