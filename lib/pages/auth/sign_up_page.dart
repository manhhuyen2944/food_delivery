import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Nhập email của bạn", title: "email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Nhập email không hợp lệ",
            title: "email không hợp lệ");
      } else if (password.isEmpty) {
        showCustomSnackBar("Nhập mật khẩu của bạn", title: "mật khẩu");
      } else if (password.length < 6) {
        showCustomSnackBar("Nhập mật khẩu không hợp lệ",
            title: "mật khẩu không hợp lệ");
      } else if (name.isEmpty) {
        showCustomSnackBar("Nhập họ tên của bạn", title: "Họ tên");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Nhập số điện thoại của bạn",
            title: "số điện thoại");
      } else {
        SignUpModel signUpModel = SignUpModel(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpModel).then((status) {
          if (status.issucces) {
            Get.offNamed(RouteHelper.homepage);
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return GetBuilder<AuthController>(
      builder: (authController) {
        return !authController.isLoading
            ? Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.25,
                        child: const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/image/logo part 1.png"),
                          ),
                        ),
                      ),
                      AppTextField(
                        textCotroller: emailController,
                        hintText: "Email",
                        icon: Icons.email,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textCotroller: passwordController,
                        hintText: "Mật khẩu",
                        icon: Icons.password_sharp,
                        isObscure: true,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textCotroller: nameController,
                        hintText: "Họ tên",
                        icon: Icons.person,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textCotroller: phoneController,
                        hintText: "Số điện thoại",
                        icon: Icons.phone,
                      ),
                      SizedBox(height: Dimensions.height20 * 2),
                      GestureDetector(
                        onTap: () {
                          _registration(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 1.25,
                          height: Dimensions.screenHeight / 14,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                          ),
                          child: Center(
                            child: BigText(
                              text: "Đăng ký".toUpperCase(),
                              size: Dimensions.font20 + Dimensions.font20 / 5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height15),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account already?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20 / 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          text: "Sign up using on of the following methods",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20 / 1.5,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage: AssetImage(
                                  "assets/image/${signUpImage[index]}"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const CustomLoader();
      },
    );
  }
}
