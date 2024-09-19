import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/utils/data_state.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {

  ApiService apiService;
  ArticleCubit({required this.apiService}) : super(ArticleInitial());

  void getArticles() async{
    emit(ArticleLoading());
    DataState dataState = await apiService.fetchData();
    if(!dataState.hasError){
      emit(ArticleLoaded(articles: dataState.data));
    }else{
      emit(ArticleFailed(errorMessage: dataState.errorMessage!));
    }
  }

}
