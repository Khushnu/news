import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:news/Models/categoriesmodel.dart';
import 'package:news/Services/getnews.dart';
import 'package:news/main.dart';
import 'package:shimmer/shimmer.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _scrollController = ScrollController();
  final searchText = TextEditingController();
  final newsCategory = GetNewsModel();
  bool isLoaded = true;
  bool isEndOfList = true;
  bool isStartofList = false;

  // String defaultText = 'bitcoin';
  CategoriesClass? categoriesClass;
  List<String> categories = [
    'All',
    'General',
    'Sports',
    'Bussines',
    'Technology',
    'Health',
    'Entertainment'
  ];
  String currentSelected = 'All';

  getSearchNews(String c,) async {
    if (!isLoaded) {
      setState(() {
        isLoaded = true;
      });
    }
    if (c.isEmpty) {
      c = 'all';
    }
    categoriesClass = await newsCategory.getCatergories(c);
    if (categoriesClass != null) {
      setState(() {
        isLoaded = false;
        
      });
// isLoaded = false;
    }
  }


  goToEndAndTopOfList(){
    if(_scrollController.hasClients){
      final position = _scrollController.position.maxScrollExtent; 
      _scrollController.animateTo(position,
       duration: const Duration(seconds: 1), 
       curve: Curves.bounceIn); 
       setState(() {
       isEndOfList = false;
       isStartofList = true;
       });
    }
  }
  goToStartofList(){
    if(_scrollController.hasClients){
      final position = _scrollController.position.minScrollExtent; 
      _scrollController.animateTo(position,
       duration: const Duration(seconds: 1), 
       curve: Curves.bounceIn); 
       setState(() {
        isStartofList = false;
        isEndOfList = true;
       });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // searchText.text = 'bitcoin';
    getSearchNews('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 40,
            )),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discover',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'News all over the world',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),

                // if(searchText.text.isEmpty)
                Container(
                    height: screenHieght * 0.1 - 25,
                    width: screenWidth,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: TextFormField(
                        controller: searchText,
                        onFieldSubmitted: (v) {
                          getSearchNews(v);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Icon(Icons.filter_list),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    
                    SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Row(
                      children: categories.map((e) {
                        bool isSelected = currentSelected == e;
                        return InkWell(
                          onTap: () {
                            getSearchNews(e);
                            setState(() {
                              currentSelected = e;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  border: isSelected
                                      ? Border(
                                          bottom: BorderSide(
                                              color: isSelected
                                                  ? Colors.orange
                                                  : Colors.grey,
                                              width: 4))
                                      : null),
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if(isEndOfList)
                  Transform.translate(
                    offset: const Offset(0, -15),
                    child: Align( 
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          goToEndAndTopOfList();
                        },
                        child: Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: Colors.black, 
                          highlightColor: Colors.white, 
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_forward_ios_sharp, size: 15,),
                                Icon(Icons.arrow_forward_ios_sharp, size: 18,),
                                Icon(Icons.arrow_forward_ios_sharp, size: 22,),
                              ],)), 
                      ),
                    ),
                  ), 
                  if(isStartofList)
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: Align( 
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: (){
                          goToStartofList();
                        },
                        child: Shimmer.fromColors(
                          direction: ShimmerDirection.rtl,
                          baseColor: Colors.black, 
                          highlightColor: Colors.white, 
                        child: const Row(
                              children: [
                                Icon(Icons.arrow_back_ios_sharp, size: 22,),
                                Icon(Icons.arrow_back_ios_sharp, size: 18,),
                                Icon(Icons.arrow_back_ios_sharp, size: 14,),
                              ],)), 
                       
                        ),
                      ),
                  ),
                  ]
                  )
                  ]
                ),
              
            
          ),
          Expanded(
            child: isLoaded
                ? Lottie.asset('Images/load.json')
                : ListView.builder(
                    itemCount: categoriesClass!.articles.length,
                    itemBuilder: (_, index) {
                      var e = categoriesClass!.articles[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: screenHieght * 0.1 + 50,
                            width: screenWidth,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5, 
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade300),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 5),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: e.urlToImage == null
                                                ? Image.asset(
                                                    'Images/no.png',
                                                    fit: BoxFit.cover,
                                                    height:
                                                        screenHieght * 0.1 + 40,
                                                    width: screenWidth * 0.1,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl: e.urlToImage!,
                                                    placeholder: (context,
                                                            url) => Lottie.asset('Images/load.json')
                                                        ,
                                                    height:
                                                        screenHieght * 0.1 + 40,
                                                    width: screenWidth * 0.3,
                                                    fit: BoxFit.cover,
                                                  )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox( 
                                            // height: screenHieght * 0.1, 
                                            width: screenWidth * 0.7 - 40,
                                            child: Text(
                                              e.title,  
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                          ), 
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                            text: 'Published by : ',
                                            style: const TextStyle(color: Colors.black54),
                                            children: [
                                              TextSpan(
                                                text: e.author, 
                                                style: const TextStyle(color: Colors.black)
                                              ) , 
                                              
                                          ])), 
                                         const SizedBox(
                                            height: 2,
                                          ),
                                           RichText(
                                            text: TextSpan(
                                            text: 'Published At : ',
                                            style: const TextStyle(color: Colors.black54),
                                            children: [
                                              TextSpan(
                                                text: DateFormat('dd-MMM-yyyy').format(e.publishedAt), 
                                                style: const TextStyle(color: Colors.black)
                                              ) , 
                                              
                                          ])), 
                                           const SizedBox(
                                            height: 2,
                                          ),
                                           RichText(
                                            text: TextSpan(
                                            text: 'Source : ',
                                            style: const TextStyle(color: Colors.black54),
                                            children: [
                                              TextSpan(
                                                text: '${e.source.id}', 
                                                style: const TextStyle(color: Colors.black)
                                              ) , 
                                              
                                          ])),
                                         
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
