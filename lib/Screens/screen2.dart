import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:news_app/bloc/articles%20bloc/cubit/article_cubit.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ArticleCubit>().getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        if (state is ArticleLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ArticleFailed) {
          return Center(child: Text(state.errorMessage));
        } else if (state is ArticleLoaded) {
          return CustomScrollView(
            slivers: [
              // Carousel Slider
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CarouselSlider.builder(
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          final currentArticle = state.articles[index];
                          return NewsCard(
                            title: currentArticle.title,
                            image: currentArticle.urlToImage,
                            description: currentArticle.description,
                          );
                        },
                        options: CarouselOptions(
                          height: 300,
                          initialPage: 0,
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                      ),
                    ),
                    // Smooth Page Indicator
                    Padding(
                      padding: EdgeInsets.only(top:10),
                      child: SmoothPageIndicator(
                        controller: PageController(initialPage:_currentIndex,viewportFraction: 0.8),
                        count: 5,
                        effect: WormEffect(
                          activeDotColor: Colors.blue,
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Recent News",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 100),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final currentArticle = state.articles[index];
                      return NewsCard(
                        title: currentArticle.title,
                        image: currentArticle.urlToImage,
                        description: currentArticle.description,
                      );
                    },
                    childCount: state.articles.length,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text("Unknown error happened"),
          );
        }
      },
    );
  }
}