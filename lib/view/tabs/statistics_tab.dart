import 'package:flutter/cupertino.dart';

import '../../ui/common.dart';
import '../../ui/rails.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Rails.instance.buildTrending(context, size),
        customDivider(),
        headingText(text: "No data found",
            fontWeight: FontWeight.bold,
            fontSize: 30
        ),
      ],
    );
  }
}
