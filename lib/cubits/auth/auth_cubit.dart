import 'package:cricket_app/controllers/auth/auth_controller.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final auth = AuthController();
  Admin? _admin;

  Admin? get admin => _admin;

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
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(AuthError('Something went wrong'));
      } else {
        emit(AuthError(err.toString()));
      }
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
      if (err is! AppException) {
        emit(AuthError('Something went wrong'));
      } else {
        emit(AuthError(err.toString()));
      }
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
      if (err is! AppException) {
        emit(AuthError('Something went wrong'));
      } else {
        emit(AuthError(err.toString()));
      }
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
      if (err is! AppException) {
        emit(AuthError('Something went wrong'));
      } else {
        emit(AuthError(err.toString()));
      }
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
      if (err is! AppException) {
        emit(AuthError('Something went wrong'));
      } else {
        emit(AuthError(err.toString()));
      }
    }
  }

  void changePassword(password) async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.changePassword(password);
        emit(AuthSuccess(response));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(AuthError('Something went wrong'));
      } else {
        emit(AuthError(err.toString()));
      }
    }
  }

  void getUser() async {
    emit(AuthLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await auth.getUser();
        _admin = response.data as Admin;
        emit(AuthGetUser(response.data));
      } else {
        emit(AuthError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(AuthError('Something went wrong'));
      } else {
        emit(AuthError(err.toString()));
      }
    }
  }
}
