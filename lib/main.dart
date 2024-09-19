import 'package:flutter/material.dart';
import 'package:news_app/pages/Explore.dart';
import 'package:news_app/providers/bottom_bar_index_provider.dart';
import 'package:news_app/providers/scroll_controller_provider.dart';
import 'package:news_app/providers/tab_index_provider.dart';


import 'package:news_app/Screens/screen1.dart';
import 'package:news_app/widgets/custom_bottom_bar.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>TabIndexProvider()),
        ChangeNotifierProvider(create: (context)=>ScrollControllerProvider()),
        ChangeNotifierProvider(create: (context)=>BottomBarIndexProvider())
      ],
      child: const MainScreen(),
    ));
}

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomBarIndexProvider = Provider.of<BottomBarIndexProvider>(context);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: IndexedStack(
          index: bottomBarIndexProvider.currentIndex,
          children: const [
             Screen1(),
             CircularCarousel()
          ],
        )),
        bottomSheet: const CustomBottomBar(),
      ),
    );
  }

}


