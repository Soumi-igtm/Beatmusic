import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/custom_colors.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: kBackgroundColor,
        actions: [
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath
          ),
        ],
      ),
    );
  }
}
