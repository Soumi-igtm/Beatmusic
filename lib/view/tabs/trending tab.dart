
import 'package:flutter/material.dart';

import '../../ui/common.dart';
import '../../ui/rails.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}


class _TrendingState extends State<Trending> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Rails.instance.buildEditorPicks(context),
        customDivider(),
        Rails.instance.buildTrending(context),
        customDivider(),
        Rails.instance.buildPopularArtists(context),
      ],
    );
  }
}