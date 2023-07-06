//정부 API로 부터 받아오는 통계정보를 매핑

enum ItemCode {
  //미세먼지
  PM10,
  //초미세먼지
  PM25,
  //이산화질소
  NO2,
  //오존
  O3,
  //일산화탄소
  CO,
  //아황산가스
  SO2,
}

class StatModel {
  final double daegu;
  final double chungnam;
  final double incheon;
  final double daejeon;
  final double gyeongbuk;
  final double sejong;
  final double gwangju;
  final double jeonbuk;
  final double gangwon;
  final double ulsan;
  final double jeonnam;
  final double seoul;
  final double busan;
  final double jeju;
  final double chungbuk;
  final double gyeongnam;
  final double gyeonggi;
  final DateTime dataTime;
  final ItemCode itemCode;


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


