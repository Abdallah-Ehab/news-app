import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Screens/screen2.dart';
import 'package:news_app/bloc/articles%20bloc/cubit/article_cubit.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/providers/scroll_controller_provider.dart';
import 'package:news_app/providers/tab_index_provider.dart';
import 'package:news_app/services/api_service.dart';
import 'package:provider/provider.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageControllerProvider =
        Provider.of<ScrollControllerProvider>(context);
    final currentIndexProvider = Provider.of<TabIndexProvider>(context);
    return PageView(
        controller: pageControllerProvider.controller,
        onPageChanged: (index) {
          currentIndexProvider.setCurrentIndex(index);
        },
        children: [
        BlocProvider(
          create: (context) => ArticleCubit(apiService: ApiService(url: "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=04935395636c48409cd27df0544b8b48")),
          child: const HomePage(), // First page
        ),
        BlocProvider(
          create: (context) => ArticleCubit(apiService: ApiService(url:"https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=04935395636c48409cd27df0544b8b48")),
          child: const Screen2(), // Second page
        ),
      ],);
  }
}
