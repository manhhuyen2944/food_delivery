// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:get/get.dart';

import 'package:food_delivery/data/repository/auth_repository.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true;
    Response response = await authRepository.registration(signUpModel);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepository.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }
}
