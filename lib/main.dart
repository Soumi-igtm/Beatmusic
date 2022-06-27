import 'package:beatmusic/ui/custom_colors.dart';
import 'package:beatmusic/view/login.dart';
import 'package:beatmusic/view/onboarding.dart';

import 'package:beatmusic/view/splashscreen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'provider_models/overlay_handler.dart';


import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Beatwind Artists",
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            iconTheme: const IconThemeData(color: kPrimaryColor),
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.grey.shade700),
            ),
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: kBackgroundColor,
              titleTextStyle: GoogleFonts.montserrat(fontSize: 30, color: kPrimaryTextColor, fontWeight: FontWeight.bold),
            )),
        themeMode: ThemeMode.dark,
        routes: {
          "/": (context) => const SplashScreen(),
          "/onboarding": (context) => const Onboarding(),
          "/login": (context) => const Login(),
        },
        initialRoute: "/",
      );

  }
}
