// statModel(매핑한 정부API 정보)를 앱에 맞게 가공
// 일반적으로 백엔드-프론트엔드의 합의를 통해 주고받는 데이터를 정해놓으면 이렇게 할 필요가 없지만
// 이 프로젝트는 일방적으로 정부에서 보내주는 데이터를 이용하는 경우이므로, 이와같이 앱에 맞도록 별도로 model을 하나 더 생성해야함

import 'dart:ui';

class StatusModel {
  //단계
  final int level;

  //단계 이름(좋음, 보통 등)
  final String label;

  //주색상
  final Color primaryColor;

  //어두운색상
  final Color darkColor;

  //밝은 색상
  final Color lightColor;

  //폰트 색상
  final Color detailFontColor;

  //이모티콘 이미지
  final String imagePath;

  //코멘트(나쁘지 않네요 등)
  final String comment;

  //미세먼지 최소치(최소치를 기준으로 단계를 정함)
  final double minFineDust;

  //초미세먼지 최소치
  final double minUltraFineDust;

  //오존 최소치
  final double minO3;

  //이산화질소 최소치
  final double minNO2;

  //일산화탄소 최소치
  final double minCO;

  //아황산가스 최소치
  final double minSO2;

  StatusModel({
    required this.level,
    required this.label,
    required this.primaryColor,
    required this.darkColor,
    required this.lightColor,
    required this.detailFontColor,
    required this.imagePath,
    required this.comment,
    required this.minFineDust,
    required this.minUltraFineDust,
    required this.minO3,
    required this.minNO2,
    required this.minCO,
    required this.minSO2,
  });
}
