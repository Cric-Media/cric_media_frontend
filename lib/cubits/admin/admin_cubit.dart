import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_states.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  var adminController = AdminController();

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
}
