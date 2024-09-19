import 'package:flutter/material.dart';
import 'package:news_app/constants/category_list.dart';
import 'package:news_app/providers/scroll_controller_provider.dart';
import 'package:news_app/providers/tab_index_provider.dart';
import 'package:provider/provider.dart';

class CustomTabBarPinned extends StatefulWidget {
  const CustomTabBarPinned({super.key});

  @override
  State<CustomTabBarPinned> createState() => _CustomTabBarPinnedState();
}

class _CustomTabBarPinnedState extends State<CustomTabBarPinned> {
  @override
  Widget build(BuildContext context) {

    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    final pageController = Provider.of<ScrollControllerProvider>(context);
    return Container(
      color:Colors.white,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
                tabIndexProvider.setCurrentIndex(index);
                pageController.controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: tabIndexProvider.currentIndex == index? Colors.purple:Colors.white,
                border: Border.all(color: Colors.purple)
              ),
              child: Center(child: Text(categories[index],style:TextStyle(color:tabIndexProvider.currentIndex == index? Colors.white:Colors.black))),
            ),
          );
        },
      ),
    );
  }
}
