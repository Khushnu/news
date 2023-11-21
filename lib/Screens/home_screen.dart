import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:news/Models/countrynewsmodel.dart';
import 'package:news/Models/newsmodel.dart';
import 'package:news/Screens/details_screen.dart';
import 'package:news/Screens/search_screen.dart';
import 'package:news/Services/getnews.dart';
import 'package:news/Widgets/titlewidgetonscreen.dart';
import 'package:news/main.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// enum Filters {bbcNews, aryNews, alJazeera, cnn, youtube, foxnews  }

class _HomeScreenState extends State<HomeScreen> {
  // final newsHeadlines = NewsViewModel();
  bool isLoaded = true;
  NewsClass? newsClass;
  CountryNewsModel? countryClass;
  final newsCategory = GetNewsModel();
  List<String> filter = [
    'Us',
    'Canada',
    'Arabs',
    'Germany',
    'France',
  ];
  List<String> sources = [
    'BBC News',
    'CNN',
    'Ary News',
    'Fox News',
    'Al Jazeera English',
    'Google News'
  ];
  String currentCountry = 'Us';
  String currentSources = 'bbc-news';
  getnewsData(String sources) async {
    newsClass = await newsCategory.getNews(sources);
    if (newsClass != null) {
      setState(() {
        isLoaded = false;
      });
    }
  }

  getNewsByCountry(String country) async {
    countryClass = await newsCategory.getNewsByCountry(country);
    if (newsClass != null) {
      setState(() {
        isLoaded = false;
      });
    }
  }

  // List<Article> newsList = [];
  // bool loadData = true;
  // NewsClass? data;
  // final controller = PageController();
  // getHeadLines() async {
  //   final dio = Dio();
  //   try {
  //     var response = await dio.get(HttpServices.url);
  //     if (response.statusCode == 200) {
  //       var d = response.data;
  //       data = NewsClass.fromJson(d);
  //       newsList =
  //           List<Article>.from(d["articles"].map((x) => Article.fromJson(x)));
  //      // print(d);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() {
  //     loadData = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    getnewsData(currentSources);
    getNewsByCountry(currentCountry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHieght * 0.4 + 40,
            width: screenWidth,
            child: isLoaded
                ? Center(
                    child: Lottie.asset('Images/load.json'),
                  )
                : CarouselSlider.builder(
                    options: CarouselOptions(
                        height: screenHieght * 0.5,
                        autoPlay: true,
                        viewportFraction: 10,
                        autoPlayInterval: const Duration(seconds: 10),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 400)),
                    itemCount: newsClass!.articles.length,
                    itemBuilder: (_, index, realindex) {
                      var e = newsClass!.articles[index];
                      return Container(
                        height: screenHieght * 0.5,
                        width: screenWidth,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35)),
                        ),
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: e.urlToImage == null
                                  ? Image.asset(
                                      'Images/no.png',
                                      fit: BoxFit.cover,
                                      height: screenHieght * 0.5,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: e.urlToImage!,
                                      placeholder: (context, url) =>
                                          Lottie.asset('Images/load.json'),
                                      height: screenHieght * 0.5,
                                      fit: BoxFit.cover,
                                    )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 45),
                            child: PopupMenuButton(
                                initialValue: currentCountry,
                                onSelected: (item) {
                                  String countryCode;
                                  switch (item) {
                                    case 'Us':
                                      countryCode = 'us';
                                      break;
                                    case 'Canada':
                                      countryCode = 'ca';
                                      break;
                                    case 'Arabs':
                                      countryCode = 'ae';
                                      break;
                                    case 'Germany':
                                      countryCode = 'de';
                                      break;
                                    case 'France':
                                      countryCode = 'fr';
                                      break;
                                    default:
                                      countryCode =
                                          'us'; // Set a default value if needed
                                  }

                                  setState(() {
                                    currentCountry = countryCode;
                                    getNewsByCountry(currentCountry);
                                  });
                                },
                                itemBuilder: (_) => filter
                                    .map((e) =>
                                        PopupMenuItem(value: e, child: Text(e)))
                                    .toList(),
                                icon: const Icon(
                                  Icons.menu,
                                  size: 40,
                                  color: Colors.white,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 45),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: PopupMenuButton(
                                  initialValue: currentSources,
                                  onSelected: (item) {
                                    String sources;
                                    switch (item) {
                                      case 'BBC News':
                                        sources = 'bbc-news';
                                        break;
                                      case 'CNN':
                                        sources = 'cnn';
                                        break;
                                      case 'Fox News':
                                        sources = 'fox-news';
                                        break;
                                      case 'Ary News':
                                        sources = 'ary-news';
                                        break;
                                      case 'Al Jazeera ':
                                        sources = 'al-jazeera-english';
                                      case 'Google News ':
                                        sources = 'google-news';
                                        break;
                                      default:
                                        sources =
                                            'usa-today'; // Set a default value if needed
                                    }

                                    setState(() {
                                      currentSources = sources;
                                      getnewsData(currentSources);
                                    });
                                  },
                                  itemBuilder: (_) => sources
                                      .map((e) => PopupMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  icon: const Icon(
                                    Icons.source,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 110),
                              child: TitleScreenWidget(
                                  screenheights: screenHieght * 0.1 - 60,
                                  screenWidths: screenWidth * 0.5,
                                  title: Text(
                                    e.source.name,
                                    style: const TextStyle(fontSize: 16),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 70, horizontal: 15),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: TitleScreenWidget(
                                  screenWidths: screenWidth,
                                  screenheights: screenHieght * 0.2 - 60,
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.title,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailsScreen(
                                                  image: e.urlToImage,
                                                  title: e.title,
                                                  authorname: e.author ??
                                                      'No Author found',
                                                  publishedDate: e.publishedAt,
                                                  description: e.description,
                                                  publishedby: e.source.name,
                                                )));
                                  },
                                  child: TitleScreenWidget(
                                    screenheights: screenHieght * 0.1 - 50,
                                    screenWidths: screenWidth * 0.3,
                                    title: Shimmer.fromColors(
                                      baseColor: Colors.black,
                                      highlightColor: Colors.grey,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Learn more',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_outlined,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          )
                        ]),
                      );
                    }),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Breaking News',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchScreen()));
                    },
                    child: const Text(
                      'More',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Expanded(
              child: isLoaded
                  ? Center(
                      child: Lottie.asset('Images/load.json'),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: countryClass!.articles.length,
                      itemBuilder: (_, index) {
                        var e = countryClass!.articles[index];
                        // var current = DateTime.now();

                        var diff = DateTime.parse(
                            newsClass!.articles[index].publishedAt.toString());
                        String formatTime =
                            DateFormat('MMMM dd yyyy').format(diff);

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 7),
                          child: Container(
                            height: screenHieght * 0.1 - 10,
                            width: screenWidth * 0.7,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(34),
                                    child: e.urlToImage == null
                                        ? Image.asset(
                                            'Images/no.png',
                                            fit: BoxFit.cover,
                                            height: screenHieght * 0.2 - 30,
                                            width: screenWidth,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: e.urlToImage!,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                    baseColor: Colors.red,
                                                    highlightColor:
                                                        Colors.yellow,
                                                    child: const SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                    )),
                                            height: screenHieght * 0.2 - 25,
                                            width: screenWidth,
                                            fit: BoxFit.cover,
                                          )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(e.title,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.timer,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        formatTime,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text('Published by - ${e.author}'),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
        ],
      ),
    );
  }
}
