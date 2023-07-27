import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:get/get.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savvynurse/utils/color_constant.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool signtype = true;

  CollectionReference patients =
      FirebaseFirestore.instance.collection('Patient');
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
    phonecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final paddingwidth = width * 6;
    return Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 1),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1, right: 34),
                        child: Text("Hurry! \nSign up here",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.black900)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      bottom: 8,
                      top: 10,
                    ),
                    child: TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: ColorConstant.black900,
                        ),
                        fillColor: ColorConstant.lightgrey,
                        filled: true,
                        hintText: "Enter User Name",
                        // labelText: "Enter User Name",
                        labelStyle: TextStyle(
                            color: ColorConstant.lightgreytext, fontSize: 16.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter User Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  /////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      bottom: 8,
                      top: 10,
                    ),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: Icon(
                          Icons.email,
                          color: ColorConstant.black900,
                        ),
                        fillColor: ColorConstant.lightgrey,
                        filled: true,
                        hintText: "Enter Email",
                        // labelText: "Enter Email",
                        labelStyle: TextStyle(
                            color: ColorConstant.lightgreytext, fontSize: 16.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter an Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  ////////////////////////////

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      bottom: 8,
                      top: 10,
                    ),
                    child: TextFormField(
                      controller: phonecontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: ColorConstant.black900,
                        ),
                        fillColor: ColorConstant.lightgrey,
                        filled: true,
                        hintText: "Enter phone",
                        // labelText: "Enter phone",
                        labelStyle: TextStyle(
                            color: ColorConstant.lightgreytext, fontSize: 16.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter phone';
                        } else if (value.length < 9) {
                          return 'Enter valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  ///////////////////////

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      bottom: 8,
                      top: 10,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: passcontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: Icon(
                          Icons.key,
                          color: ColorConstant.black900,
                        ),
                        fillColor: ColorConstant.lightgrey,
                        filled: true,
                        hintText: "Enter Password",
                        // labelText: "Enter Password",
                        labelStyle: TextStyle(
                            color: ColorConstant.lightgreytext, fontSize: 16.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.black),
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
                  ////////////////////////////

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          registerNewUser();
                        }
                      },
                      child: Container(
                        width: 330,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: ColorConstant.buttonblue,
                        ),
                        child: const Center(
                          child: Text("Sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerNewUser() async {
    try {
      final credential = await auth
          .createUserWithEmailAndPassword(
              email: emailcontroller.text, password: passcontroller.text)
          .then((result) {
        patients.doc(result.user!.uid).set({
          "doctorname": namecontroller.text,
          "email": emailcontroller.text,
          "password": passcontroller.text,
          "phone": phonecontroller.text,
        });
        Get.toNamed("/login");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Get.snackbar("allert", 'The account already exists for that email.');
      } else if (e.code == "invalid-email") {
        Get.snackbar("allert", 'The email address is badly formatted.');
      } else {
        Get.snackbar("allert", e.message.toString());
      }
    } catch (e) {
      Get.snackbar("allert", "e");
    }
  }
}
