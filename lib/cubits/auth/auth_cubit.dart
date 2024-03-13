import 'package:cricket_app/controllers/auth/auth_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/user.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final auth = AuthController();
  final User _user = User();

  User get user => _user;

  void signup() async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.signup();
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

  void getUser() async {
    emit(AuthLoading());
    try {
      var response = await auth.getUser();
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  // Reset password
}
