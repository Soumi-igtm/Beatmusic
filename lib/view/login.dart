
import 'package:beatmusic/ui/common.dart';
import 'package:beatmusic/view/root.dart';
import 'package:flutter/material.dart';

import '../ui/remixicon.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Size size;
  
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              image: AssetImage("assets/music_bg1.jpg"),
          ),
        ),
        child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
              child: Column(
                children: [
                  Image.asset("assets/logo2.png", width: size.width/1.5,),
                  bodyText(text: "Welcome!", fontSize: 25),
                  SizedBox(height: 15,),
                  signInButton(icon: Icons.mail, title: "Sign in with Email", callback: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Root()), (route) => false)),
                  SizedBox(height: 15),
                  signInButton(icon: Remix.google_fill, title: "Sign in With Google", callback: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Root()), (route) => false))
                ],
              )
          ),
        ),
      ),
    );
  }
}
