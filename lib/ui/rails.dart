import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/collections.dart';

import 'common.dart';
import 'custom_colors.dart';
import 'loaders.dart';

class Rails {
  static Rails instance = Rails();

  Widget buildMyFavs(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: playlistsCollection.where("creatorID", isEqualTo: "BDnY9eVaqpQtJT0O2Mtx").orderBy("followersCount", descending: true).snapshots(),
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
                child: ListView.builder(
                    itemCount: dataList.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 230,
                        height: 300,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bodyText(text: dataList[index]["title"], fontSize: 14, fontColor: Colors.grey),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: dataList[index]["thumbnailLarge"],
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
                      );
                    }),
              )
            ],
          );
        });
  }

  Widget buildRecentRecordings(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: creatorsCollection.doc("BDnY9eVaqpQtJT0O2Mtx").collection("recordings").orderBy("recordedOn", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 150,
              child: Loaders.instance.customSquareListLoader(6),
            );
          }
          List<DocumentSnapshot> dataList = snapshot.data!.docs;
          if (snapshot.hasData && dataList.isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(text: "Recent  Recordings"),
                  buttonText(text: "See All", fontColor: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 14)
                ],
              ),
              Container(
                height: 205,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {},
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: dataList[index]["poster"],
                                placeholder: (context, s) => Image.asset("assets/placeholder3.jpg"),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: bodyText(text: dataList[index]["title"], fontSize: 14, fontColor: kWhiteColor),
                            ),
                            AutoSizeText(
                              dataList[index]["artists"].join(", "),
                              minFontSize: 7,
                              maxLines: 2,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey.shade300),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 10);
                  },
                ),
              ),
            ],
          );
        });
  }
  Widget buildTrending(BuildContext context, Size size) {
    return StreamBuilder<QuerySnapshot>(
        stream: musicsCollection.where("active", isEqualTo: true).where("browseBanner", isEqualTo: true).orderBy("browseOrder").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 313,
              child: Loaders.instance.customSquareListLoader(6),
            );
          }
          List<DocumentSnapshot> dataList = snapshot.data!.docs;
          if (snapshot.hasData && dataList.isEmpty) {
            return const SizedBox();
          }
          return SizedBox(
            height: 313,
            child: ListView.builder(
                itemCount: dataList.length,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: size.width - 50,
                    height: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: bodyText(text: dataList[index]["title"], fontSize: 25, fontWeight: FontWeight.normal),
                        ),
                        AutoSizeText(
                          dataList[index]["artists"].join(", "),
                          minFontSize: 15,
                          maxLines: 1,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: dataList[index]["banner"],
                                placeholder: (context, s) => Image.asset("assets/placeholder1.jpg"),
                                fit: BoxFit.cover,
                                height: 250,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Widget buildStatistics(BuildContext context, Size size) {
    return StreamBuilder<QuerySnapshot>(
        stream: statisticsCollection.where("active", isEqualTo: true).where("browseBanner", isEqualTo: true).orderBy("browseOrder").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 313,
              child: Loaders.instance.customSquareListLoader(6),
            );
          }
          List<DocumentSnapshot> dataList = snapshot.data!.docs;
          if (snapshot.hasData && dataList.isEmpty) {
            return const SizedBox();
          }
          return SizedBox(
            height: 313,
            child: ListView.builder(
                itemCount: dataList.length,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: size.width - 50,
                    height: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: bodyText(text: dataList[index]["title"], fontSize: 25, fontWeight: FontWeight.normal),
                        ),

                        const SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: dataList[index]["banner"],

                                fit: BoxFit.cover,
                                height: 250,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }

}


