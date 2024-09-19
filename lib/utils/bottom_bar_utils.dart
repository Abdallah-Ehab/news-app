import 'package:flutter/material.dart';
import 'package:news_app/providers/bottom_bar_index_provider.dart';
import 'package:provider/provider.dart';

class BottomBarUtils extends StatelessWidget {
  final int index;
  final IconData icon;
  final String title;

  const BottomBarUtils({
    super.key,
    required this.index,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bottomBarIndexProvider = Provider.of<BottomBarIndexProvider>(context);

    return GestureDetector(
      onTap: () {
        bottomBarIndexProvider.setCurrentIndex(index);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: index == bottomBarIndexProvider.currentIndex
                  ? Colors.purple
                  : Colors.grey.withOpacity(0.5),
                  size: 20,
            ),
            Text(
              title,
              style: TextStyle(
                color: bottomBarIndexProvider.currentIndex == index
                    ? Colors.purple
                    : Colors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
