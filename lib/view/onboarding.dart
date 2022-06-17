
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../ui/common.dart';
import '../ui/custom_colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late Size size;
  final box = GetStorage();
  final PageController pageController = PageController();

  redirectLogin() {
    box.write("onboarded", true);
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            controller: pageController,
            children: [
              Image.asset("assets/onboarding1.jpg", height: size.height, width: size.width, fit: BoxFit.fill),
              Image.asset("assets/onboarding2.jpg", height: size.height, width: size.width, fit: BoxFit.fill),
              Image.asset("assets/onboarding3.jpg", height: size.height, width: size.width, fit: BoxFit.fill),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                axisDirection: Axis.horizontal,
                effect: SwapEffect(
                  spacing: 8.0,
                  radius: 20.0,
                  dotWidth: 20.0,
                  dotHeight: 20.0,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1.5,
                  dotColor: Colors.white,
                  activeDotColor: kPrimaryColor,
                ),
              ),
              TextButton(
                onPressed: () => redirectLogin(),
                style: TextButton.styleFrom(
                    backgroundColor: kButtonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), primary: kWhiteColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: buttonText(text: "Login"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
