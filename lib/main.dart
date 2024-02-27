import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:foodappdemo/pages/bottomnav.dart';
import 'package:foodappdemo/pages/home.dart';
import 'package:foodappdemo/pages/login.dart';
import 'package:foodappdemo/pages/onboard.dart';
import 'package:foodappdemo/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:foodappdemo/widget/app_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=publishableKey;


  await Firebase.initializeApp( options: FirebaseOptions(
          apiKey: "AIzaSyCMyWm5lX4IpEZ2R-4x68q5BwhAfQA7aYY",
          projectId: "fooddeliveryapp-a4b69",
          messagingSenderId: "826260149990",
          appId: "1:826260149990:android:4c9285ca04d3c0fcef8d27"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Onboard(),
    );
  }
}

