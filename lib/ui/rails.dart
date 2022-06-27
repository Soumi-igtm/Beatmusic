import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/collections.dart';

import '../view/playlist.dart';
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
  Widget buildEditorPicks(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: playlistsCollection
            .where("active", isEqualTo: true)
            .where("sort", arrayContains: "Editor's Picks")
            .orderBy("followersCount", descending: true)
            .snapshots(),
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
                  headingText(text: "Our Editor's Picks"),
                  buttonText(text: "See All", fontColor: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 14)
                ],
              ),
              Container(
                height: 192,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return OpenContainer(
                        openColor: Colors.white,
                        closedColor: Colors.transparent,
                        openElevation: 0,
                        closedElevation: 0,
                        transitionType: ContainerTransitionType.fade,
                        openBuilder: (BuildContext context, void Function({Object? returnValue}) action) => Playlist(playlistID: dataList[index].id),
                        closedBuilder: (BuildContext context, void Function() action) {
                          return SizedBox(
                            width: 150,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: dataList[index]["thumbnail"],
                                    placeholder: (context, s) => Image.asset("assets/placeholder3.jpg"),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: bodyText(
                                      text: dataList[index]["title"],
                                      maxLines: 2,
                                      fontSize: 14,
                                      fontColor: Colors.grey.shade300,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        });
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

  Widget buildTrending(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: musicsCollection.where("active", isEqualTo: true).orderBy("trending").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loaders.instance.customListTileLoader(6);
          }
          List<DocumentSnapshot> dataList = snapshot.data!.docs;
          if (snapshot.hasData && dataList.isEmpty) {
            return const SizedBox();
          }
          List<Widget> trendingList = [];
          for (var data in dataList) {
            trendingList.add(Stack(
              children: [
                Text(
                  "${data['trending']}",
                  style: GoogleFonts.bangers(color: kWhiteColor, fontSize: 80),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 20),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: data['poster'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: bodyText(text: data['title'], maxLines: 1),
                    subtitle: AutoSizeText(
                      data["artists"].join(", "),
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert, color: kPrimaryTextColor),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(text: "Trending"),
                  buttonText(text: "See All", fontColor: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 14)
                ],
              ),
              ...trendingList,
            ],
          );
        });
  }

  Widget buildPopularArtists(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: artistsCollection.where("active", isEqualTo: true).orderBy("followersCount", descending: true).snapshots(),
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
                  headingText(text: "Popular Artists"),
                  buttonText(text: "See All", fontColor: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 14)
                ],
              ),
              Container(
                height: 175,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: dataList[index]["image"],
                                placeholder: (context, s) => Image.asset("assets/placeholder3.jpg"),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: bodyText(text: dataList[index]["name"], fontSize: 14, fontColor: Colors.grey.shade300),
                            ),
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

  Widget buildMyHits(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: musicsCollection.where("active", isEqualTo: true).orderBy("topHits").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loaders.instance.customListTileLoader(6);
          }
          List<DocumentSnapshot> dataList = snapshot.data!.docs;
          if (snapshot.hasData && dataList.isEmpty) {
            return const SizedBox();
          }
          List<Widget> trendingList = [];
          for (var data in dataList) {
            trendingList.add(Stack(
              children: [
                Text(
                  "${data['trending']}",
                  style: GoogleFonts.bangers(color: kWhiteColor, fontSize: 80),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 20),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: data['poster'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: bodyText(text: data['title'], maxLines: 1),
                    subtitle: AutoSizeText(
                      data["artists"].join(", "),
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert, color: kPrimaryTextColor),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(text: "Your top hits"),
                  buttonText(text: "See All", fontColor: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 14)
                ],
              ),
              ...trendingList,
            ],
          );
        });
  }

}


