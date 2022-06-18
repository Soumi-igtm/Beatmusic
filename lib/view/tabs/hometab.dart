import 'package:flutter/material.dart';

import '../../ui/common.dart';
import '../../ui/rails.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        Rails.instance.buildMyFavs(context),
        const SizedBox(height: 15),
        headingText(
          text: "This is where the musical journey starts",
          fontSize: 30,
          fontStyle: FontStyle.italic,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
        ),
        customDivider(),
        Rails.instance.buildRecentRecordings(context),
      ],
    );
  }
}
