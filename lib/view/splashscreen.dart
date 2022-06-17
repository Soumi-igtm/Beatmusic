
import 'package:beatmusic/view/root.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../services/user_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  final box = GetStorage();
  late String _uid = "";
  String get uid => _uid;
  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  checkAuth(){
    _uid = UserService.instance.authenticate();
    bool onboarded = box.read("onboarded") ?? false;
    Future.delayed(const Duration(seconds: 2), () {
      if (_uid.isNotEmpty) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Root()), (route) => false);
      } else {
        if (!onboarded) {
          Navigator.pushNamedAndRemoveUntil(context, "/onboarding", (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/splash.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
