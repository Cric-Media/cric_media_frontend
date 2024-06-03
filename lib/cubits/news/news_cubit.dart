import 'package:cricket_app/controllers/user/user_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/news.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_states.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);

  List<News> news = [];
  // Pagingation
  int newsPage = 1;

  void getNews({bool more = false}) async {
    if (more) {
      newsPage++;
      emit(NewsGetLoadingState());
    } else {
      emit(NewsGetMoreLoadingState());
    }

    var network = await Network.check();
    if (!network) {
      emit(NewsGetErrorState(error: "No Internet Connection"));
      return;
    }

    try {
      var res = await UserController().getNews(page: newsPage);
      if (more) {
        emit(NewsGetMoreSuccessState(response: res));
      } else {
        emit(NewsGetSuccessState(response: res));
      }
    } catch (e) {
      if (more) {
        newsPage--;
        if (e is! AppException) {
          emit(NewsGetErrorState(error: "Something went wrong"));
        } else {
          emit(NewsGetErrorState(error: e.message));
        }
      }
    }
  }
}