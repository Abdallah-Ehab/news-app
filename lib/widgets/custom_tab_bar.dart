import 'package:flutter/material.dart';
import 'package:news_app/providers/scroll_controller_provider.dart';
import 'package:news_app/providers/tab_index_provider.dart';
import 'package:provider/provider.dart';

// Assuming categories is a list of strings
final List<String> categories = ['Category 1', 'Category 2', 'Category 3', 'Category 4', 'Category 5'];

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final List<GlobalKey> _tabKeys = [];
  final ScrollController _scrollController = ScrollController();
  double _indicatorLeft = 0.0;
  double _indicatorWidth = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize the list of GlobalKeys
    for (int i = 0; i < categories.length; i++) {
      _tabKeys.add(GlobalKey());
    }

    _scrollController.addListener(_updateIndicator);
  }

  void _updateIndicator() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final currentIndex = Provider.of<TabIndexProvider>(context, listen: false).currentIndex;
      final key = _tabKeys[currentIndex];
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        setState(() {
          _indicatorLeft = position.dx;
          _indicatorWidth = renderBox.size.width-50;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateIndicator);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    final pageControllerProvider = Provider.of<ScrollControllerProvider>(context);

    // Call _updateIndicator initially
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());

    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  tabIndexProvider.setCurrentIndex(index);
                  pageControllerProvider.controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInCubic,
                  );
                  _updateIndicator();
                },
                child: Container(
                  key: _tabKeys[index],
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: index == tabIndexProvider.currentIndex ? 20 : 14,
                      fontWeight: index == tabIndexProvider.currentIndex
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: index == tabIndexProvider.currentIndex
                          ? Colors.purple
                          : Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(categories[index]),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: _indicatorLeft,
            child: Container(
              width: _indicatorWidth,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(150)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
