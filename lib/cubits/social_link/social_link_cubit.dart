import 'package:cricket_app/controllers/user/user_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/social_link.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'social_link_states.dart';

class SocialLinkCubit extends Cubit<SocialLinkState> {
  SocialLinkCubit() : super(SocialLinkInitial());

  static SocialLinkCubit get(context) =>
      BlocProvider.of<SocialLinkCubit>(context);

  List<SocialLink> sl = [];

  void getSocialLink() async {
    emit(SocialLinkGetLoading());
    try {
      bool network = await Network.check();
      if (!network) {
        emit(SocialLinkGetError('No internet connection'));
        return;
      }
      final res = await UserController().getSocialLinks();
      emit(SocialLinkGetSuccess(res));
    } catch (err) {
      if (err is AppException) {
        emit(SocialLinkGetError(err.message));
      } else {
        emit(SocialLinkGetError('Something went wrong'));
      }
    }
  }
}
