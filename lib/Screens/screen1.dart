import 'package:flutter/material.dart';
import 'package:news_app/widgets/custom_app_bar.dart';
import 'package:news_app/widgets/custom_bottom_bar.dart';
import 'package:news_app/widgets/custom_tab_bar.dart';
import 'package:news_app/widgets/custom_tab_bar_pinned.dart';
import 'package:news_app/widgets/custom_tab_bar_view.dart';


// ignore: must_be_immutable
class Screen1 extends StatelessWidget {

  

  const Screen1({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScolled){
            return [
              const SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 120,
                expandedHeight: 120,
                flexibleSpace: CustomAppBar(),
                
              ),
              SliverPersistentHeader(
                delegate: CustomTabBarDelegate() ,
                floating: false,
                pinned: true,
              ),
            ];
          },
          body: const CustomTabBarView()
        ),
      ),
    );
  }
}


class CustomTabBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 50;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent = shrinkOffset / expandedHeight;

    // Use Positioned to control where the tab bars are rendered
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 1 - percent,
            child: Visibility(
              visible: percent < 1.0,
              child: const CustomTabBar(),
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: percent,
            child: Visibility(
              visible: percent > 0.0,
              child: const CustomTabBarPinned(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
