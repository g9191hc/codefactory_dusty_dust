import 'package:dusty_dust/const/status_level.dart';

import '../model/stat_model.dart';
import '../model/status_model.dart';

class DataUtils {
  static String getHangulFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일 ${getTimeFormat(number: dateTime.hour)} 기준';
  }

  static String getTimeFormat({required int number}) {
    return hourToHangulAMPM(number: number).padLeft(2, '0');
  }

  static String hourToHangulAMPM({required int number}) {
    return number == 0 || number == 24
        ? '자정'
        : number == 12
            ? '정오'
            : number > 12
                ? '오후 ${number - 12}시'
                : '오전 $number시';
  }

  static String getUnitFromItemCode({
    required ItemCode itemCode,
  }) {
    switch (itemCode) {
      case ItemCode.PM10 || ItemCode.PM25:
        return '㎍/㎥';
      default:
        return 'ppm';
    }
  }

  static String getHangulStringFromItemCode({
    required ItemCode itemCode,
  }) {
    switch (itemCode) {
      case ItemCode.PM10:
        return '미세먼지';
      case ItemCode.PM25:
        return '초미세먼지';
      case ItemCode.CO:
        return '일산화탄소';
      case ItemCode.NO2:
        return '이산화질소';
      case ItemCode.O3:
        return '오존';
      case ItemCode.SO2:
        return '아황산가스';
    }
  }

  //입력받은 stat의 itemCode와 value에 해당하는 status를 반환함
  static StatusModel getStatusFromItemCodeAndValue({
    required ItemCode itemCode,
    required double value,
  }) {
    //현재 보다 적은 최소치를 갖는 모든 상태 중 가장 높은 상태를 선택
    switch (itemCode) {
      case ItemCode.PM10:
        return statusLevel.where((status) => status.minFineDust < value).last;
      case ItemCode.PM25:
        return statusLevel
            .where((status) => status.minUltraFineDust < value)
            .last;
      case ItemCode.CO:
        return statusLevel.where((status) => status.minCO < value).last;
      case ItemCode.NO2:
        return statusLevel.where((status) => status.minNO2 < value).last;
      case ItemCode.O3:
        return statusLevel.where((status) => status.minO3 < value).last;
      case ItemCode.SO2:
        return statusLevel.where((status) => status.minSO2 < value).last;
      default:
        throw '알 수 없는 ItemCode입니다';
    }
  }
}
