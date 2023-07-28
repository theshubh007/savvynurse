import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:savvynurse/utils/color_constant.dart';
import 'package:savvynurse/widget/progress_dialog.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
///////////////////////////////////////
  bool isLoading = false;
  bool signtype = true;
  final _formKey = GlobalKey<FormState>();
  bool _visiblePassword = false;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      backgroundColor: ColorConstant.whiteA700,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 15),
                          child: Text(
                              "Welcome to Savvy Nurse \nLogin as a Patient",
                              style: TextStyle(
                                  color: ColorConstant.black900,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 5,
                            top: 20,
                          ),
                          child: TextFormField(
                            controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: ColorConstant.lightgreytext,
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              fillColor: ColorConstant.lightgrey,
                              filled: true,
                              hintText: "Enter Email Address",
                              // labelText: "Enter Email Address",
                              labelStyle: TextStyle(
                                  color: ColorConstant.lightgreytext,
                                  fontSize: 16.0),
                              /*enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),*/
                            ),
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email Address';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email address!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 25,
                            top: 10,
                          ),
                          child: TextFormField(
                            obscureText: !_visiblePassword,
                            controller: passcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.key,
                                color: ColorConstant.lightgreytext,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _visiblePassword = !_visiblePassword;
                                  });
                                },
                                child: Icon(
                                  _visiblePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              fillColor: ColorConstant.lightgrey,
                              filled: true,
                              hintText: "Enter password",
                              // labelText: "Enter Password",
                              labelStyle: TextStyle(
                                  color: ColorConstant.lightgreytext,
                                  fontSize: 16.0),
                              /* enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),*/
                            ),
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (value.length < 6) {
                                return 'Password must be atleast 6 characters!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 16, right: 16),
                            // child: Obx(() => connectionstatus.value == false
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await loginwithemailpass(
                                      password:
                                          passcontroller.text.trim().toString(),
                                      email: emailcontroller.text
                                          .trim()
                                          .toString());
                                }
                              },
                              child: Container(
                                width: 330,
                                height: 56,
                                decoration: BoxDecoration(
                                    color: ColorConstant.buttonblue,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Center(
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 16, right: 16),
                          child: InkWell(
                            onTap: () async {
                              Get.toNamed("/signup");
                            },
                            child: Container(
                              width: 330,
                              height: 56,
                              decoration: BoxDecoration(
                                  color: ColorConstant.buttonblue,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                child: Text("Signup",
                                    style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 16, right: 16),
                          child: InkWell(
                            onTap: () async {
                              if (emailcontroller.text
                                  .trim()
                                  .toString()
                                  .isNotEmpty) {
                                resetpassword(
                                    emailcontroller.text.trim().toString());
                              } else {
                                Get.snackbar(
                                  "Allert", // title
                                  "Please enter email address", // message
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  icon: const Icon(Icons.error),
                                  duration: const Duration(seconds: 3),
                                  isDismissible: true,
                                  forwardAnimationCurve:
                                      Curves.fastLinearToSlowEaseIn,
                                );
                              }
                            },
                            child: Container(
                              width: 330,
                              height: 56,
                              decoration: BoxDecoration(
                                color: ColorConstant.buttonblue,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text("Forgot Password",
                                    style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginwithemailpass({
    required String email,
    required String password,
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      //final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        await Amplify.Auth.signup(
        email: email,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes : { "email": email},
        )
      );
      User? user = credential.user;
      await FirebaseFirestore.instance
          .collection('Patient')
          .doc(user!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          ProgressDialogUtils.hideProgressDialog();
          Get.toNamed("/home");
        } else {
          ProgressDialogUtils.hideProgressDialog();
          Get.offAllNamed("/login");
          Get.snackbar(
            "Error",
            "Please Signup as patient First",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            borderColor: Colors.red,
            borderWidth: 2,
          );
        }
      });
    } "on FirebaseAuthException catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      if (e.code == 'user-not-found') {
        Get.snackbar("allert", "user not found",
            backgroundColor: Colors.lightBlueAccent, colorText: Colors.black);
      } else if (e.code == 'wrong-password') {
        Get.snackbar("allert", "wrong password",
            backgroundColor: Colors.lightBlueAccent, colorText: Colors.black);
      } else if (e.code == "invalid-email") {
        Get.snackbar("allert", "invalid email",
            backgroundColor: Colors.lightBlueAccent, colorText: Colors.black);
      }
    }
  }
"
  Future<void> resetpassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
    print(email);
    Get.snackbar("allert", "password reset link sent to your email",
        backgroundColor: Colors.lightBlueAccent, colorText: Colors.black);
  }
}
