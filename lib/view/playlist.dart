import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

import '../ui/common.dart';
import '../ui/custom_colors.dart';
import '../utils/collections.dart';

class Playlist extends StatefulWidget {
  final String playlistID;
  const Playlist({Key? key, required this.playlistID}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final ScrollController scrollController = ScrollController();
  bool lastStatus = true;
  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return scrollController.hasClients && scrollController.offset > (300 - kToolbarHeight);
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<DocumentSnapshot>(
          stream: playlistsCollection.doc(widget.playlistID).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: customCircularProgress());
            DocumentSnapshot playlistData = snapshot.data!;

            return CustomScrollView(
              controller: scrollController,
              physics: const ScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 350,
                  pinned: true,
                  iconTheme: IconThemeData(color: isShrink ? Colors.black : Colors.white),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: playlistData["thumbnail"],
                          placeholder: (context, s) => Image.asset("assets/placeholder3.jpg"),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                        Container(
                            width: double.infinity,
                            height: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  playlistData["title"],
                                  maxLines: 2,
                                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                bodyText(text: "by ${playlistData["author"]}", fontSize: 12, fontColor: Colors.white),
                                const Divider(color: Colors.white54),
                                Row(
                                  children: [
                                    bodyText(
                                        text: "${playlistData["likesCount"]} Likes  •  ",
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        fontColor: Colors.white),
                                    bodyText(
                                        text: "${playlistData["followersCount"]} Followers",
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        fontColor: Colors.white),
                                  ],
                                ),
                                ButtonBar(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: Colors.white, width: 0.5), borderRadius: BorderRadius.circular(8)),
                                      ),
                                      label: buttonText(text: "Like", fontSize: 14),
                                      icon: const Icon(Remix.thumb_up_line, color: Colors.white, size: 16),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: Colors.white, width: 0.5), borderRadius: BorderRadius.circular(8)),
                                      ),
                                      label: buttonText(text: "Follow", fontSize: 14),
                                      icon: const Icon(Remix.add_circle_line, color: Colors.white, size: 16),
                                    ),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                    collapseMode: CollapseMode.parallax,
                    expandedTitleScale: 3,
                    centerTitle: true,
                    title: Text(
                      playlistData["title"],
                      maxLines: 2,
                      style: GoogleFonts.montserrat(color: isShrink ? Colors.black : Colors.transparent, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: playlistData["musics"].length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return StreamBuilder<DocumentSnapshot>(
                            stream: musicsCollection.doc(playlistData["musics"][index]).snapshots(),
                            builder: (context, msnapshot) {
                              if (!msnapshot.hasData) {
                                return Container();
                              }

                              DocumentSnapshot musicData = msnapshot.data!;
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: musicData['poster'],
                                  placeholder: (context, s) => Image.asset("assets/placeholder3.jpg"),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                                title: bodyText(text: musicData['title'], maxLines: 1),
                                subtitle: AutoSizeText(
                                  musicData["artists"].join(", "),
                                  minFontSize: 10,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.more_vert, color: kPrimaryTextColor),
                                  onPressed: () {},
                                ),
                              );
                            });
                      }),
                )
              ],
            );
          }),
    );
  }
}
