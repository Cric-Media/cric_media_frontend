import 'package:cricket_app/controllers/auth/auth_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/user.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final auth = AuthController();
  User _user = User();

  User get user => _user;

  void sendOtpForSignup() async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.sendOtpForSignup();
        emit(AuthSuccess(response));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  void verifyEmailAndSignup(otp) async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.verifyEmailAndSignup(otp);
        emit(AuthSuccess(response));
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

  void sendOtpForPasswordChange() async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.sendOtpForPasswordChange();
        emit(AuthSuccess(response));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  void verifyEmailForPassword(otp) async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.verifyEmailForPassword(otp);
        emit(AuthSuccess(response));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  void changePassword() async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        // var response = await auth.verifyEmailForPassword(otp);
        // emit(AuthVerifyOtpForPassword(response));
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
      var network = await Network.check();
      if (network) {
        var response = await auth.getUser();
        _user = response.data as User;
        emit(AuthGetUser(response.data));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }
}
