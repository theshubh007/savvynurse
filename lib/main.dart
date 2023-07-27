import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savvynurse/Homepage.dart';
import 'package:savvynurse/auth/login.dart';
import 'package:savvynurse/auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: routeslist,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}

List<GetPage<dynamic>> routeslist = [
  GetPage(
    page: () => const Homepage(),
    name: '/home',
  ),
  GetPage(name: "/login", page: () => const Loginscreen()),
  GetPage(name: "/signup", page: () => const Signuppage()),
];
