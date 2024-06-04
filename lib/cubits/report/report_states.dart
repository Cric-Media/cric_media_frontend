part of 'report_cubit.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

// Loading

class ReportLoading extends ReportState {}
// * Success

class ReportSuccess extends ReportState {
  final ApiResponse res;
  ReportSuccess(this.res);
}
// ! Error

class ReportError extends ReportState {
  final String error;
  ReportError(this.error);
}
