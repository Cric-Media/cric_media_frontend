import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/notifier.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_states.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of<AdminCubit>(context);

  var adminController = AdminController();

  // Variables
  List<Notifier> notifiers = [];

  Future<void> getInitialOtherAdmins({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    emit(AdminLoading());
    try {
      final response = await adminController.getOtherAdmins(
        page: page,
        limit: limit,
        search: search,
      );
      emit(AdminGetOtherAdminsSuccess(response));
    } catch (e) {
      emit(AdminGetOtherAdminsError(e.toString()));
    }
  }

  getMoreOtherAdmins(
      {required int page, required int limit, String? search}) async {
    try {
      final response = await adminController.getOtherAdmins(
        page: page,
        limit: limit,
        search: search,
      );
      emit(AdminGetOtherAdminsSuccess(response));
    } catch (e) {}
  }

  Future<void> sharePlayer({
    required String playerId,
    required String adminId,
  }) async {
    emit(AdminSharePlayerLoading());
    try {
      final response = await adminController.sharePlayer(playerId, adminId);
      emit(AdminSharePlayerSuccess(response));
    } catch (e) {
      emit(AdminSharePlayerError(e.toString()));
    }
  }

  Future<void> shareTeam(String teamId, String newAdminId) async {
    emit(AdminShareTeamLoading());
    try {
      final response = await adminController.shareTeam(teamId, newAdminId);
      emit(AdminShareTeamSuccess(response));
    } catch (e) {
      emit(AdminShareTeamError(e.toString()));
    }
  }

  adminInvitations() async {
    notifiers = [];
    emit(AdminInvitationsLoading());
    try {
      bool network = await Network.check();
      if (!network) {
        emit(AdminInvitationsError("No network available"));
        return;
      }
      final response = await adminController.getAdminInvitations();
      emit(AdminInvitationsSuccess(response));
    } catch (e) {
      if (e is AppException) {
        emit(AdminInvitationsError(e.message));
      } else {
        emit(AdminInvitationsError("Something went wrong!"));
      }
    }
  }

  invitationResponse({
    required String id,
    required String type,
    required bool accept,
  }) async {
    emit(AdminInvitationResponseLoading());
    try {
      bool network = await Network.check();
      if (!network) {
        emit(AdminInvitationResponseError("No network available"));
        return;
      }
      final response = await adminController.invitationResponse(
        id: id,
        type: type,
        accept: accept,
      );
      emit(AdminInvitationResponseSuccess(response));
    } catch (e) {
      if (e is AppException) {
        emit(AdminInvitationResponseError(e.message));
      } else {
        emit(AdminInvitationResponseError("Something went wrong"));
      }
    }
  }

  void shareAccess({
    required String id,
    required String adminId,
    required String type,
  }) async {
    emit(AdminShareLoading());
    try {
      final response = await adminController.shareTournament(
        id: id,
        adminId: adminId,
        type: type,
      );
      emit(AdminShareSuccess(response));
    } catch (e) {
      if (e is AppException) {
        emit(AdminShareError(e.message));
      } else {
        emit(AdminShareError("Something went wrong"));
      }
    }
  }
}
