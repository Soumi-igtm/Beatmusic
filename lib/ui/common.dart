import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_colors.dart';

Widget buttonText(
    {required String text,
      double fontSize = 18,
      FontWeight fontWeight = FontWeight.bold,
      TextAlign textAlign = TextAlign.start,
      Color fontColor = Colors.white}) =>
    Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.chivo(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
    );

Widget bodyText(
    {required String text,
      int maxLines = 1,
      double fontSize = 16,
      FontWeight fontWeight = FontWeight.bold,
      TextAlign textAlign = TextAlign.start,
      Color fontColor = Colors.white}) =>
    Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.montserrat(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
    );

Widget headingText(
    {required String text,
      Color fontColor = Colors.white,
      double fontSize = 20,
      FontWeight fontWeight = FontWeight.bold,
      FontStyle fontStyle = FontStyle.normal,
      TextAlign textAlign = TextAlign.start}) =>
    Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.montserrat(fontSize: fontSize, letterSpacing: 01, fontWeight: fontWeight, color: fontColor, fontStyle: fontStyle),
    );

Widget customDivider() => const Divider(color: kWhiteColor, thickness: 0.2, height: 30);

class Constants {
  static const double BOTTOM_PADDING_PIP = kBottomNavigationBarHeight;
  static const double VIDEO_HEIGHT_PIP = 200;
  static const double VIDEO_TITLE_HEIGHT_PIP = 50;
}

Widget libraryButton(Size size, {required IconData icon, required String title, required String subtitle, var callback}) => Container(
  width: size.width / 2 - 25,
  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  height: 100,
  decoration: BoxDecoration(color: Colors.grey.shade900.withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Icon(icon, color: kPrimaryTextColor),
      headingText(text: title, fontSize: 15),
      bodyText(text: subtitle, fontSize: 10, fontWeight: FontWeight.w400),
    ],
  ),
);

Widget signInButton({required IconData icon, required String title, var callback}) => GestureDetector(
  onTap: callback,
  child:   Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 10,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
            gradient: LinearGradient(
              colors: [Color(0xff5e99ed), Color(0xff8872ef)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: Icon(icon, color: Colors.white),
      ),
      Container(
        height: 36,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
            gradient: LinearGradient(
              colors: [Color(0xffb8bde2), Color(0xff1840b0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: bodyText(text: title, textAlign: TextAlign.center, fontColor: Colors.black, fontWeight: FontWeight.w500),
      )
    ],
  ),
);

customToast(String msg, BuildContext context) => showToast(
  msg,
  context: context,
  animation: StyledToastAnimation.slideToTopFade,
  reverseAnimation: StyledToastAnimation.fade,
  position: StyledToastPosition.bottom,
  animDuration: const Duration(seconds: 1),
  duration: const Duration(seconds: 3),
  curve: Curves.elasticOut,
  reverseCurve: Curves.linear,
);

Widget customCircularProgress({Color color = kPrimaryColor}) => CircularProgressIndicator.adaptive(
  strokeWidth: 2,
  valueColor: AlwaysStoppedAnimation(color),
);

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
