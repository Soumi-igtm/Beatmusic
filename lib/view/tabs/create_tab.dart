import 'package:beatmusic/ui/common.dart';
import 'package:beatmusic/ui/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class CreateTab extends StatefulWidget {
  final String uid;
  const CreateTab({Key? key, required this.uid}) : super(key: key);

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {
  final record = Record();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bodyText(text: "00:00:00", fontSize: 50)
            ],
          )),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(10),
                decoration: const ShapeDecoration(
                  shape: CircleBorder(side: BorderSide(color: kWhiteColor)),
                  color: kBackgroundColor,
                ),
                child: const Icon(Icons.upload),
              ),
              GestureDetector(
                onTap: () async {
                  if (await record.hasPermission()) {
                    // Start recording
                    // await record.start(
                    //   path: 'aFullPath/myFile.m4a',
                    //   encoder: AudioEncoder.aacLc, // by default
                    //   bitRate: 128000, // by default
                    //   samplingRate: 44100, // by default
                    // );
                  }
                },
                child: Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: kWhiteColor,
                  ),
                  child: const Icon(Icons.mic, size: 40),
                ),
              ),
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(10),
                decoration: const ShapeDecoration(
                  shape: CircleBorder(side: BorderSide(color: kWhiteColor)),
                  color: kBackgroundColor,
                ),
                child: const Icon(Icons.list_alt),
              ),
            ],
          )
        ],
      ),
    );
  }
}
