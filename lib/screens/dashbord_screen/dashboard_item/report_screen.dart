import 'package:cricket_app/cubits/report/report_cubit.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                ReportCubit.get(context).name = value;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                ReportCubit.get(context).contactNumber = value;
              },
              decoration: const InputDecoration(
                labelText: 'Contact Number',
                hintText: 'Enter your contact number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                ReportCubit.get(context).report = value;
              },
              decoration: const InputDecoration(
                labelText: 'Report',
                hintText: 'Write your report here',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 8.0),
            BlocConsumer<ReportCubit, ReportState>(
              listener: (context, state) {
                if (state is ReportSuccess) {
                  showSnack(context, message: state.res.message);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is ReportLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    ReportCubit.get(context).postReport();
                  },
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
