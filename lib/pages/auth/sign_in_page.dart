//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:menus/pages/auth/sign_up_page.dart';
import 'package:menus/pages/home/main_food_page.dart';
import 'package:menus/routes/route_helper.dart';
import 'package:menus/utils/colors.dart';
import 'package:menus/widgets/app_text_field.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  //const SignInPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // var emailController = TextEditingController();
    // var passwordController = TextEditingController();
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController passwordController = new TextEditingController();

    String? errorMessage;

    //login function
  //   void signIn (String email, String password) async {
  //   if (_formKey.currentState!.validate()) {
  //     await _auth
  //       .signInWithEmailAndPassword(email: email, password: password)
  //       .then((uid) => {
  //         Fluttertoast.showToast(msg: "Login Successful"),
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (context) => MainFoodPage()))
  //       })
  //       .catchError((e) {
  //         Fluttertoast.showToast(msg: e!.message);
  //       });
  //   }
  // }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainFoodPage())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
    

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        //validate format
        // if (value!.isEmpty!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]").hasMatch(value)) {
        //   return ("Please enter a valid email");
        // }
        if (!(value!.isEmail)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        //icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;

      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if(!regex.hasMatch(value)) {
          return ("Password invalid (Min. 8 character)");
        }
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    );

    final loginButton = Material(
      color: AppColors.themeColor1,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
        ),
        
      ),
    );

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
                  backgroundColor: Colors.black,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/images/nus_logo.jpeg",
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        color: AppColors.themeColor2,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: Dimensions.height15,
            // ),
            // AppTextField(
            //   textController: emailController,
            //   hintText: "Email",
            //   icon: Icons.email,
          
            // ),

            
            // AppTextField(
            //   textController: passwordController,
            //   hintText: "Password",
            //   icon: Icons.password_sharp,
            // ),

            Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      emailField,

                      SizedBox(
                        height: Dimensions.height15,
                      ),

                      passwordField,

                      SizedBox(
                        height: Dimensions.height15,
                      ),

                      loginButton
                    ]
                  ),
                ),
              )
              
            ),

            

            SizedBox(
              height: Dimensions.height10,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                  text: TextSpan(
                    text: "Sign into your account",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
              ],
            ),
            SizedBox(
              height: Dimensions.screenHeight * 0.04,
            ),
            // Container(
            //   width: Dimensions.screenWidth / 2,
            //   height: Dimensions.screenHeight / 13,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(
            //         Dimensions.radius30,
            //       ),
            //       color: AppColors.themeColor1),
            //   child: Center(
            //     child: GestureDetector(
            //       onTap: () {
            //         Get.to(MainFoodPage());
            //       },
            //       child: BigText(
            //         text: "Sign In",
            //         size: Dimensions.font20 + Dimensions.font20 / 2,
            //         color: AppColors.themeColor2,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: Dimensions.screenHeight * 0.04,
            ),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.to(() => SignUpPage(),
                          transition: Transition.fade),
                      // ..onTap = () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => 
                      //                           SignUpPage())
                      //   );
                      // },
                    text: "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBlackColor,
                      fontSize: Dimensions.font20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
