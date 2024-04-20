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
        AppConstants.registrationUri, signUpModel.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.token) ?? "None";
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(AppConstants.loginUri, {
      "phone": phone,
      "password": password,
    });
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.phone, number);
      await sharedPreferences.setString(AppConstants.password, password);
    } catch (e) {
      throw e.toString();
    }
  }
  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.phone);
    sharedPreferences.remove(AppConstants.password);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
