import 'package:beatmusic/view/root.dart';
import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:remixicon/remixicon.dart';
import '../ui/common.dart';
import '../ui/custom_colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Size size;
  final SiriWaveController siriWaveController = SiriWaveController();

  @override
  void initState() {
    siriWaveController.setColor(kPrimaryColor);
    super.initState();
  }

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
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SafeArea(
            child: Column(
              children: [
                Image.asset("assets/logo2.png", width: size.width / 1.5),
                bodyText(text: "Welcome!", fontSize: 25),
                Expanded(
                  child: SiriWave(
                    controller: siriWaveController,
                    options: const SiriWaveOptions(backgroundColor: Colors.transparent),
                  ),
                ),
                signInButton(icon: Icons.mail, title: "Sign in with Email", callback: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Root()), (route) => false)),
                SizedBox(height: 15),
                signInButton(icon: Remix.google_fill, title: "Sign in with Google", callback: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Root()), (route) => false)),
                SizedBox(height: 15),
                signInButton(icon: Remix.apple_fill, title: "Sign in with Apple", callback: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Root()), (route) => false)),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
