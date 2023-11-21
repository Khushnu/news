import 'package:flutter/material.dart';
import 'package:news/Screens/home_screen.dart';
import 'package:news/Screens/profile_screen.dart';
import 'package:news/Screens/search_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

double screenHieght =0; 
double screenWidth =0; 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, 
    
      theme: ThemeData(
        useMaterial3: true
      ),
      home: const BottomNav(),
    );
  }
}


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index =0; 
   List<Widget> listofWidgets = [
   const HomeScreen(), 
   const SearchScreen(), 
   const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    screenHieght =MediaQuery.sizeOf(context).height; 
    screenWidth =MediaQuery.sizeOf(context).width; 
    return Scaffold(
      body: listofWidgets.elementAt(index),
      bottomNavigationBar: Container(
        height: screenHieght * 0.1 + 10 , 
        width:  screenWidth,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300))
        ),
        child: BottomNavigationBar(
          //backgroundColor: Colors.black12,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade400,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home , size: 30,), label: ''), 
             BottomNavigationBarItem(icon: Icon(Icons.search,size: 30), label: ''), 
              BottomNavigationBarItem(icon: Icon(Icons.person,size: 30), label: '')
          ]),
      ),
    );
  }
}