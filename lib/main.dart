import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/controller/add_doner_controller.dart';
import 'package:responsive_web_app/controller/user_list_controller.dart';
import 'package:responsive_web_app/controller/home_controller.dart';
import 'package:responsive_web_app/responsive/responsive.dart';
import 'package:responsive_web_app/screens/add_doner/add_doner_screen.dart';
import 'package:responsive_web_app/screens/add_money/user_list_screen.dart';
import 'package:responsive_web_app/utils/app_constant.dart';

import 'controller/collect_money_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///for mobile app

  if(Platform.isAndroid){
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    } else {
      Firebase.app(); // Use the already initialized app
    }
  }else{

    ///for web only
    await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyBv2oGTOcc6H3ccv4JEyn3Q_YQtxW7Fg74",
      projectId: "personal-project-cd273",
      messagingSenderId: "775719963929",
      appId: "1:775719963929:web:745e8191199b45ae43c988",
    ));
  }



  runApp(MultiProvider(
    providers: [
      // Provider<Something>(create: (_) => Something()),
      ChangeNotifierProvider(create: (_) => HomeController()),
      ChangeNotifierProvider(create: (_) => AddDonerController()),
      ChangeNotifierProvider(create: (_) => UserListController()),
      ChangeNotifierProvider(create: (_) => CollectMoneyController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppConstants.initialRoute,
      routes: {
        AppConstants.initialRoute: (context) => ResponsiveLayout(),
        AppConstants.addUserScreenRoute: (context) => const AddDonerScreen(),
        AppConstants.addMoneyRoute: (context) => const UserListScreen(),
      },
      // home: ResponsiveLayout(),
    );
  }
}
