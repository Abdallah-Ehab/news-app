import 'package:flutter/material.dart';
import 'package:news_app/constants/category_list.dart';
import 'package:news_app/utils/bottom_bar_utils.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 80,
        
        child: SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: icons.length,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: BottomBarUtils(
                      index: index, icon: icons[index], title: titles[index]),
                );
              }),
        ));
  }
}
