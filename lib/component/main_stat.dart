import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  //미세먼지, 초미세먼지 등
  final String category;

  //아이콘 경로
  final String imgPath;

  //오염정도
  final String label;

  //오염수치
  final String stat;

  //카드 너비
  final double width;

  const MainStat({
    super.key,
    required this.category,
    required this.imgPath,
    required this.label,
    required this.stat,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.black,
    );

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: ts,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Image.asset(
            imgPath,
            width: 50.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            label,
            style: ts,
          ),
          Text(
            stat,
            style: ts,
          )
        ],
      ),
    );
  }
}
