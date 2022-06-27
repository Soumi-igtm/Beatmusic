import 'package:flutter/material.dart';
import '../../ui/common.dart';
import '../../ui/custom_colors.dart';
import '../../ui/rails.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          Rails.instance.buildMyFavs(context),
          headingText(
            text: "This is where the musical journey starts",
            fontSize: 25,
            fontStyle: FontStyle.italic,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
          customDivider(),
          Rails.instance.buildRecentRecordings(context),
          customDivider(),
          Rails.instance.buildMyHits(context),
        ],
      ),
      // floatingActionButton:  SpeedDial(
      //   animatedIcon: AnimatedIcons.list_view,
      //   backgroundColor: Colors.white,
      //   children: [
      //     SpeedDialChild(
      //       child: Icon(Remix.upload_fill),
      //       label: 'Upload',
      //       backgroundColor: Colors.white,
      //     ),
      //     SpeedDialChild(
      //         child: Icon(Remix.upload_fill),
      //         label: 'Add artist',
      //       backgroundColor: Colors.white,
      //     ),
      //     SpeedDialChild(
      //         child: Icon(Remix.upload_fill),
      //         label: 'Withdraw',
      //       backgroundColor: Colors.white,
      //     ),
      //     SpeedDialChild(
      //         child: Icon(Remix.upload_fill),
      //         label: 'New release',
      //         backgroundColor: Colors.white,
      //     ),
      //   ],
      // ),
    );
  }
}
