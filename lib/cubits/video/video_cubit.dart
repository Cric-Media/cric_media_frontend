import 'package:cricket_app/controllers/user/user_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/video.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_states.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);

  List<Video> videos = [];
  int page = 1;
  int limit = 20;

  void getVideos({bool more = false}) async {
    if (more) {
      emit(VideosMoreLoading());
      page++;
    } else {
      page = 1;
      emit(VideosLoading());
    }
    try {
      var network = await Network.check();
      if (!network) {
        emit(VideosError('No internet connection'));
        return;
      }
      final res = await UserController().getVideos(page, limit);

      emit(VideosSuccess(res));
    } catch (e) {
      if (!more) {
        if (e is ApiResponse) {
          emit(VideosError(e.message));
        } else {
          emit(VideosError('An error occurred. Please try again later.'));
        }
      } else {
        page--;
      }
    }
  }

  void viewVideo(String videoId) async {
    emit(VideoViewLoading());

    var network = await Network.check();
    if (!network) {
      emit(VideoViewError("No Internet Connection"));
      return;
    }

    try {
      var res = await UserController().viewVideo(videoId);
      emit(VideoViewSuccess(res));
    } catch (e) {
      if (e is! AppException) {
        emit(VideoViewError("Something went wrong"));
      } else {
        emit(VideoViewError(e.message));
      }
    }
  }
}
