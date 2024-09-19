import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/articles%20bloc/cubit/article_cubit.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
    context.read<ArticleCubit>().getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        if(state is ArticleLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(state is ArticleFailed){
          return Center(
            child:Text(state.errorMessage)
          );
        }else if(state is ArticleLoaded){
            return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: state.articles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final currentArticle = state.articles[index];
                    return NewsCard(
                      title: currentArticle.title,
                      image: currentArticle.urlToImage,
                      description: currentArticle.description,
                    );
                  },
                ),
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
                      color: Colors.black),
                ),
              ),
            ),
            SliverGrid(
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
          ],
        );
        }else{
          return Center(
            child: Text("unkown error happened"),
          );
        }
        
      },
    );
  }
}
