import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

import '../../ui/common.dart';
import '../../ui/custom_colors.dart';
import '../../ui/loaders.dart';
import '../../utils/collections.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: context.width,
            height: 60,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                        colors: [Colors.red, Colors.blue],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.5, 0.0),
                        stops: [0.6, 1],
                        tileMode: TileMode.clamp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7.0),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        fillColor: kBackgroundColor,
                        filled: true,
                        prefixIcon: const Icon(Remix.search_2_fill),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                        hintText: "Songs, Artists, Albums and more"),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          bodyText(text: "Browse Categories", fontWeight: FontWeight.bold, fontColor: Colors.grey.shade300),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: categoriesCollection.where("active", isEqualTo: true).orderBy("order").snapshots(),
                builder: (context, cSnapshot) {
                  if (!cSnapshot.hasData) {
                    return Loaders.instance.customGridLoader(200);
                  }

                  List<DocumentSnapshot> categoryList = cSnapshot.data!.docs;
                  return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: categoryList.length,
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, mainAxisSpacing: 10, crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade300,
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: categoryList[index]["thumbnail"],
                                  placeholder: (c, s) => Image.asset("assets/placeholder3.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  categoryList[index]["name"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 5.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
