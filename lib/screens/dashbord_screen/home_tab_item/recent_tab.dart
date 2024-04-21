import 'package:cricket_app/screens/dashbord_screen/home_tab_item/matchesDetails.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/resent_details/resent_details.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/custom_resent_widget.dart';

class RecentTab extends StatelessWidget {
  const RecentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => recentDetails()));
                      },
                      child: CustomResentWidget()),
                );
              }),
        ),
        SizedBox(
          height: 70,
        ),
      ],
    );
  }
}
