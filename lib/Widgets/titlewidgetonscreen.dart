import 'dart:ui';

import 'package:flutter/material.dart';

class TitleScreenWidget extends StatelessWidget {
  const TitleScreenWidget({super.key, required this.title, required this.screenWidths, required this.screenheights});
  final Widget title;
  final double screenWidths;
  final double screenheights;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: screenheights,
                    width: screenWidths  , 
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3), 
                      borderRadius: BorderRadius.circular(25)
                    ),
                  child:  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 6),
                    child:  Center(child: title,)),
                  ),
                );
  }
}