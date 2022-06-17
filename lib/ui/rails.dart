import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/collections.dart';


import 'common.dart';
import 'loaders.dart';

class Rails{
  static Rails instance = Rails();

  Widget buildTopPicks(BuildContext context, ){
    return StreamBuilder<QuerySnapshot>(
        stream: playlistsCollection
            .where("active", isEqualTo: true)
            .where("sort", arrayContains: "My favs")
            .orderBy("followersCount", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 300,
              width: 230,
              child: Loaders.instance.customSquareListLoader(6, height: 300, width: 230),
            );
          }
          List<DocumentSnapshot> dataList = snapshot.data!.docs;
          if (snapshot.hasData && dataList.isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              headingText(text: "My favs"),
              Container(
                height: 326,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListView(
                  shrinkWrap: true,
                    prototypeItem: SizedBox(
          width: 230,
          height: 300,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          bodyText(text: "title", fontSize: 14, fontColor: Colors.grey),
          ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
          CachedNetworkImage(
          imageUrl: "thumbnailLarge",
          width: 230,
          height: 300,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          ),
          ],
          ),
          ),
          ],
          ),

          )

                ),
              )
            ],
          );
        }

    );
  }
}