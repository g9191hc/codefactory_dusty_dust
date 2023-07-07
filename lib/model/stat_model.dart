import 'package:hive_flutter/hive_flutter.dart';

part 'stat_model.g.dart';

//정부 API로 부터 받아오는 통계정보를 매핑

@HiveType(typeId: 2)
enum ItemCode {
  //미세먼지
  @HiveField(0)
  PM10,
  //초미세먼지
  @HiveField(1)
  PM25,
  //이산화질소
  @HiveField(2)
  NO2,
  //오존
  @HiveField(3)
  O3,
  //일산화탄소
  @HiveField(4)
  CO,
  //아황산가스
  @HiveField(5)
  SO2,
}

@HiveType(typeId: 1)
class StatModel {
  @HiveField(0)
  final double daegu;
  @HiveField(1)
  final double chungnam;
  @HiveField(2)
  final double incheon;
  @HiveField(3)
  final double daejeon;
  @HiveField(4)
  final double gyeongbuk;
  @HiveField(5)
  final double sejong;
  @HiveField(6)
  final double gwangju;
  @HiveField(7)
  final double jeonbuk;
  @HiveField(8)
  final double gangwon;
  @HiveField(9)
  final double ulsan;
  @HiveField(10)
  final double jeonnam;
  @HiveField(11)
  final double seoul;
  @HiveField(12)
  final double busan;
  @HiveField(13)
  final double jeju;
  @HiveField(14)
  final double chungbuk;
  @HiveField(15)
  final double gyeongnam;
  @HiveField(16)
  final double gyeonggi;
  @HiveField(17)
  final DateTime dataTime;
  @HiveField(18)
  final ItemCode itemCode;

  StatModel(
      {required this.daegu, required this.chungnam, required this.incheon, required this.daejeon,
        required this.gyeongbuk, required this.sejong, required this.gwangju, required this.jeonbuk, required this.gangwon,
        required this.ulsan, required this.jeonnam, required this.seoul, required this.busan, required this.jeju,
        required this.chungbuk, required this.gyeongnam, required this.gyeonggi, required this.dataTime,
        required this.itemCode,});


  //.fromJson이 붙은 생성자. 입력받은 json 객체를 통해 모든 필드를 초기화 함
  StatModel.fromJson({required Map<String, dynamic> json})
      :
  //값이 null이 들어오면 0 할당
        daegu = double.parse(json['daegu'] ?? '0'),
        chungnam = double.parse(json['chungnam'] ?? '0'),
        incheon = double.parse(json['incheon'] ?? '0'),
        daejeon = double.parse(json['daejeon'] ?? '0'),
        gyeongbuk = double.parse(json['gyeongbuk'] ?? '0'),
        sejong = double.parse(json['sejong'] ?? '0'),
        gwangju = double.parse(json['gwangju'] ?? '0'),
        jeonbuk = double.parse(json['jeonbuk'] ?? '0'),
        gangwon = double.parse(json['gangwon'] ?? '0'),
        ulsan = double.parse(json['ulsan'] ?? '0'),
        jeonnam = double.parse(json['jeonnam'] ?? '0'),
        seoul = double.parse(json['seoul'] ?? '0'),
        busan = double.parse(json['busan'] ?? '0'),
        jeju = double.parse(json['jeju'] ?? '0'),
        chungbuk = double.parse(json['chungbuk'] ?? '0'),
        gyeongnam = double.parse(json['gyeongnam'] ?? '0'),
        gyeonggi = double.parse(json['gyeonggi'] ?? '0'),
        dataTime = DateTime.parse(json['dataTime']),
        itemCode = parseItemcode(json['itemCode']);


  static ItemCode parseItemcode(String raw) {
    //PM2.5만 변수값과 스트링이 다르므로, if문으로 직접 걸러냄
    //PM2.5(response) -> PM25
    if (raw == 'PM2.5') return ItemCode.PM25;

    //ItemCode 각 요소를 스트링으로 변환 한 것과 일치하는 것 중 처음 찾은 것(효율적)의 ItemCode를 반환
    return ItemCode.values.firstWhere((element) => element.name == raw);
  }

  double getValueFromRegion(String region) {
    switch (region) {
      case '서울':
        return seoul;
      case '경기':
        return gyeonggi;
      case '대구':
        return daegu;
      case '충남':
        return chungnam;
      case '인천':
        return incheon;
      case '대전':
        return daejeon;
      case '경북':
        return gyeongbuk;
      case '세종':
        return sejong;
      case '광주':
        return gwangju;
      case '전북':
        return jeonbuk;
      case '강원':
        return gangwon;
      case '울산':
        return ulsan;
      case '전남':
        return jeonnam;
      case '부산':
        return busan;
      case '제주':
        return jeju;
      case '충북':
        return chungbuk;
      case '경남':
        return gyeongnam;
      default:
        throw Exception('해당되는 지역 이름이 없습니다');
    }
  }

}


