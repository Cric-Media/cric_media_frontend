import 'package:cricket_app/controllers/user/user_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'report_states.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  static ReportCubit get(context) => BlocProvider.of<ReportCubit>(context);

  String? name;
  String? contactNumber;
  String? report;

  void postReport() async {
    emit(ReportLoading());
    try {
      final res =
          await UserController().postReport(name, contactNumber, report);
      emit(ReportSuccess(res));
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }
}
