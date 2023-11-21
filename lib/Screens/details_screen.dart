import 'package:flutter/material.dart';
import 'package:news/Services/dateformate.dart';
import 'package:news/main.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, 
  required this.title, 
  required this.image, 
  required this.description, 
  required this.authorname, 
  required this.publishedby, 
  required this.publishedDate});

  final String title; 
  final String? image; 
  final String description; 
  final String? authorname; 
  final String publishedby;
  final DateTime publishedDate; 
  
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  
  @override
  Widget build(BuildContext context) {
    var diff = DateTime.now().difference(widget.publishedDate);
    String timeago =  formatDuration(diff);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHieght * 0.5 - 40, 
            width: screenWidth, 
           child: Stack(
            children: [
              
            Container(
               height: screenHieght * 0.5, 
            width: screenWidth,
            foregroundDecoration: const BoxDecoration(gradient: LinearGradient(
      colors: [
          Colors.black,
          Colors.transparent,
              ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0, 0.6],
    ),),
              child: Image.network(widget.image!, 
                       fit: BoxFit.cover,),
            ), 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 90),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: () => Navigator.pop(context), 
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.white,))),
            ),
         
           ]),
          ), 
          Transform.translate(
            offset: const Offset(0, -35),
            child: Container(
              height: screenHieght * 0.5 + 40, 
              width: screenWidth, 
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(fontSize: 20, 
                  fontWeight: FontWeight.bold),),
                   const SizedBox(
                    height: 5,
                  ),
                  Text('Published by: ${widget.authorname}', 
                  style: const TextStyle(fontSize: 13, 
                  fontWeight: FontWeight.w300),),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                                      mainAxisSize: MainAxisSize.max,
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
                                          timeago,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                       const Spacer(), 
                                        Container(
                                          height: 40, 
                                          width: 40, 
                                         decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade400), 
                                          borderRadius: BorderRadius.circular(7)
                                         ), 
                                         child: Icon(Icons.favorite_border ,color: Colors.grey.shade400,),
                                        )
                                      ],
                                    ),
                                     const SizedBox(
                    height: 10,
                  ), 
                  const Text('Description', 
                  style: TextStyle(fontSize: 20, 
                  fontWeight: FontWeight.bold),), 
                   const SizedBox(
                    height: 5,
                  ),
                   Container(
                    height: screenHieght * 0.3 - 40,
                    width: screenWidth, 
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: SizedBox(
                      // height: screenHieght ,
                    width: screenWidth, 
                      child: Text(widget.description , style: const TextStyle(fontSize: 17),))
                   )
                ],
              ),
            ),
          ), 
        ],
      ),
    );
  }
}