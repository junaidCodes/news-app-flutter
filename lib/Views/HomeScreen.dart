import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Models/bbc_healines_model.dart';
import 'package:news_app/view_models/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

enum newsList { bbcNews, aryNews, CNN, independent }

class _homeScreenState extends State<homeScreen> {
  NewsViewModel news_viewModel = NewsViewModel();

  newsList? selectedMenu;

  final format = DateFormat('MMM ddd,yyy');

  String name = 'ars-technica';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<newsList>(
            onSelected: (newsList item) {
              if (newsList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (newsList.aryNews.name == item.name) {
                name = 'ary-news';
              }
              if (newsList.CNN.name == item.name) {
                name = 'cnn';
              }
              setState(() {
                selectedMenu = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<newsList>>[
              PopupMenuItem(value: newsList.bbcNews, child: Text("BBC News")),
              PopupMenuItem(value: newsList.aryNews, child: Text("ARY News")),
              PopupMenuItem(value: newsList.CNN, child: Text("CNN"))
            ],
          ),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/category_icon.png',
              width: 30,
              height: 30,
            )),
        title: Center(
          child: Text(
            "News",
            style: GoogleFonts.aDLaMDisplay(letterSpacing: 4, fontSize: 28),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: height * 0.55,
            child: FutureBuilder<bbcHeadLinesModel>(
              future: news_viewModel.fetchBbcNewsHeadlinesApi(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (BuildContext context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .04, vertical: height * .02),
                          child: SizedBox(
                            child: Stack(
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 33),
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        //   alignment: Alignment.bottomCenter,

                                        height: height * 0.22,

                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * 0.8,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                style: GoogleFonts.aBeeZee(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                maxLines: 2,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: width * 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!
                                                        .articles![index].author
                                                        .toString(),
                                                    maxLines: 2,
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
