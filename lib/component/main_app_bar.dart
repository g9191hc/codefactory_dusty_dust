import 'package:flutter/material.dart';

import '../const/color.dart';
import '../model/stat_model.dart';
import '../model/status_model.dart';
import '../utils/data_utils.dart';

class MainAppBar extends StatelessWidget {
  final String region;
  final StatModel stat;
  final StatusModel status;
  final bool isExpanded;

  MainAppBar({
    super.key,
    required this.stat,
    required this.status,
    required this.region,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      pinned: true,
      title: isExpanded
          ? null
          : Text(
              '$region ${DataUtils.getHangulFromDateTime(dateTime: stat.dataTime)}',
            ),
      expandedHeight: 500,
      centerTitle: true,
      backgroundColor: status.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  region,
                  style: ts,
                ),
                Text(
                  DataUtils.getHangulFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  status.comment,
                  style: ts.copyWith(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
