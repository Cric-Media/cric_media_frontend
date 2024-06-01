import 'package:flutter/material.dart';

class SeriesShimmer extends StatelessWidget {
  const SeriesShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
          ),
          title: Container(
            height: 10,
            width: 100,
            color: Colors.grey[300],
          ),
          subtitle: Container(
            height: 10,
            width: 100,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
