import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menus/base/show_custom_snackbar.dart';
import 'package:menus/controllers/auth_controller.dart';
import 'package:menus/pages/auth/sign_in_page.dart';
import 'package:menus/utils/colors.dart';
import 'package:menus/widgets/app_text_field.dart';
import '../../models/signup_body_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _resgistration() {
      var authoController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "password");
      } else if (password.length < 8) {
        showCustomSnackBar("Password cannot be less than eight characters",
            title: "Password");
      } else {
        showCustomSnackBar("All wen well", title: "Perfect!");
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authoController.registration(signUpBody).then((status) {
          if (status.ifSuccess) {
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            Container(
              height: Dimensions.screenHeight * 0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/images/nus_logo.jpeg",
                  ),
                ),
              ),
            ),
            AppTextField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            AppTextField(
              textController: passwordController,
              hintText: "Password",
              icon: Icons.password_sharp,
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            AppTextField(
              textController: nameController,
              hintText: "Name",
              icon: Icons.person,
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            AppTextField(
              textController: phoneController,
              hintText: "Phone",
              icon: Icons.phone,
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            GestureDetector(
              onTap: () {
                _resgistration();
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius30,
                    ),
                    color: AppColors.themeColor1),
                child: Center(
                  child: BigText(
                    text: "Sign Up",
                    size: Dimensions.font20 + Dimensions.font20 / 2,
                    color: AppColors.themeColor2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      Get.to(() => SignInPage(), transition: Transition.fade),
                text: "Have an account already?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.screenHeight * 0.04,
            ),
            RichText(
              text: TextSpan(
                text: "Sign up using one of the following methods.",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
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
                    backgroundImage:
                        AssetImage("assets/images/" + signUpImages[index]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
