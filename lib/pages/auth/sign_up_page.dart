import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:menus/base/show_custom_snackbar.dart';
import 'package:menus/controllers/auth_controller.dart';
import 'package:menus/models/user_model.dart';
import 'package:menus/pages/auth/sign_in_page.dart';
import 'package:menus/pages/home/main_food_page.dart';
import 'package:menus/utils/colors.dart';
import 'package:menus/widgets/app_text_field.dart';
import '../../models/signup_body_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

//Todo: add go back button

class SignUpPage extends StatelessWidget {
  //SignUpPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {

    postDetailsToFirestore() async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;

      UserModel userModel = UserModel();

      //assigning the values to user
      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.name = nameController.text;
      userModel.phone = phoneController.text;

      await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Account created successfully");

      Navigator.pushAndRemoveUntil(
        (context), 
        MaterialPageRoute(builder: (context) => MainFoodPage()), 
        (route) => false);

    }

    //Registration function
    void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
          case "email-already-in-use":
            errorMessage = "This email is already used by another account";
            break;
          // case "user-disabled":
          //   errorMessage = "User with this email has been disabled.";
          //   break;
          // case "too-many-requests":
          //   errorMessage = "Too many requests";
          //   break;
          // case "operation-not-allowed":
          //   errorMessage = "Signing in with Email and Password is not enabled.";
          //   break;
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
      validator: (value) {
          RegExp regex = new RegExp(r'^.{8,}$');
          if (value!.isEmpty) {
            return ("Password cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
      onSaved: (value) {
        emailController.text = value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        //icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordController.text != passwordController.text) {
            return "Password doesn't match";
          }
      },
      onSaved: (value) {
        emailController.text = value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password_sharp),
        //icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    );

    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      onSaved: (value) {
        emailController.text = value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        //icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    );

    final phoneField = TextFormField(
      autofocus: false,
      controller: phoneController,
      onSaved: (value) {
        emailController.text = value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
        //icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Contact Number",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    );

    final signUpButton = Material(
      color: AppColors.themeColor1,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {signUp(emailController.text, passwordController.text);},
        child: Text(
          "Sign Up", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
        ),
        
      ),
    );
    
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
      String confirmPassword = confirmPasswordController.text.trim();

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
      // } else if (password != confirmPassword) {
      //   showCustomSnackBar("Password does not match", title: "password");
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

                      confirmPasswordField,

                      SizedBox(
                        height: Dimensions.height15,
                      ),

                      nameField,

                      SizedBox(
                        height: Dimensions.height15,
                      ),

                      phoneField,

                      SizedBox(
                        height: Dimensions.height15,
                      ),

                      signUpButton
                    ]
                  ),
                ),
              )
              
            ),

            // AppTextField(
            //   textController: emailController,
            //   hintText: "Email",
            //   icon: Icons.email,
              
            // ),
            // SizedBox(
            //   height: Dimensions.height15,
            // ),
            // AppTextField(
            //   textController: passwordController,
            //   hintText: "Password",
            //   icon: Icons.password_sharp,
            // ),
            // SizedBox(
            //   height: Dimensions.height15,
            // ),
            // AppTextField(
            //   textController: nameController,
            //   hintText: "Name",
            //   icon: Icons.person,
            // ),
            // SizedBox(
            //   height: Dimensions.height15,
            // ),
            // AppTextField(
            //   textController: phoneController,
            //   hintText: "Phone",
            //   icon: Icons.phone,
            // ),
            // SizedBox(
            //   height: Dimensions.height15,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     _resgistration();
            //   },
            //   child: Container(
            //     width: Dimensions.screenWidth / 2,
            //     height: Dimensions.screenHeight / 13,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(
            //           Dimensions.radius30,
            //         ),
            //         color: AppColors.themeColor1),
            //     child: Center(
            //       child: BigText(
            //         text: "Sign Up",
            //         size: Dimensions.font20 + Dimensions.font20 / 2,
            //         color: AppColors.themeColor2,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: Dimensions.height10,
            // ),
            // RichText(
            //   text: TextSpan(
            //     recognizer: TapGestureRecognizer()
            //       ..onTap = () =>
            //           Get.to(() => SignInPage(), transition: Transition.fade),
            //     text: "Have an account already?",
            //     style: TextStyle(
            //       color: Colors.grey[500],
            //       fontSize: Dimensions.font20,
            //     ),
            //   ),
            // ),

            // SizedBox(
            //   height: Dimensions.screenHeight * 0.02,
            // ),
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
