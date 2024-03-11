import 'package:cricket_app/constent/global.dart';
import 'package:cricket_app/controllers/auth/auth_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/user.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final auth = AuthController();

  void signup(User user) async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        // set user info
        await Global().setAllUserInfo(
          "${user.name}",
          "${user.email}",
          "${user.phoneNumber}",
          "${user.password}",
        );

        // try signup
        var response = await auth.signup(user.email.toString());
        emit(AuthSignup(response));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  void verifyEmail(otp) async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.verifyEmail(otp);
        emit(AuthVerifyEmail(response));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  void signin(String email, String password) async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.signin(email, password);
        emit(AuthSignin(response));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }
}
