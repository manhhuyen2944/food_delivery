// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepository {
  final ApiClient apiClient;
  UserRepository({
    required this.apiClient,
  });
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.userInfoUri);
  }
}
