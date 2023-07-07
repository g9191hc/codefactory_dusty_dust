import 'package:dusty_dust/component/category_card.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../component/hourly_card.dart';
import '../const/regions.dart';
import '../model/stat_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //초기값 서울 = regions[0]
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  dispose() {
    super.dispose();
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  //요청 함수는 async로 해야 함
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    //Future형 리스트 생성
    //List<Future>로 해도 되지만, Future<dynamic>으로 나오므로,
    //다른코드에서 타입추정을 쉽게 하기 위해 비동기함수가 반환하는 타입을 Future의 제네릭으로 추가함
    List<Future<List<StatModel>>> futures = [];

    //futures 리스트에 각 함수가 추가됨과 동시에 실행 됨 (각 함수들은 비동기로 실행되어야 하므로 await 붙이지 않음)
    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(
          itemCode: itemCode,
        ),
      );
    }

    //futures리스트에 추가된 각 함수들이 모두 실행되어 값을 return 할 때 까지 기다림
    //(모든 값이 돌아올 때 까지 기다려야 하므로(=동기 실행되어야 하므로 await 추가)
    //리스트에 들어간 순서대로 값이 반환되게 되므로, 순서대로 key와 value로 매핑함
    final results = await Future.wait(futures);

    for (int i = 0; i < results.length; i++) {
      // results의 순차입력값 ItemCode의 값들이므로, results에 저장된 값들도 ItemCode와 동일한 순서로 저장되어 있음
      final key = ItemCode.values[i];
      final value = results[i];

      final box = Hive.box<StatModel>(key.name);

      for (StatModel stat in value) {
        //StatModel의 필드 중 dataTime을 각 시간대로 받으므로 중복이 발생할 수 없으므로
        //이 프로젝트에서는 그걸이용해서 키로 사용
        box.put(stat.dataTime.toString(), stat);
      }
    }

    return ItemCode.values.fold<Map<ItemCode, List<StatModel>>>(
      //초기값(빈 Map)
      {},
          (previousMap, itemCode) {
        final box = Hive.box<StatModel>(itemCode.name);
        final returnValue = box.values.toList();

        previousMap.addAll({itemCode:returnValue});

        return previousMap;
      },
    );
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //에러시
          return Scaffold(
            body: Center(
              child: Text('에러가 있습니다'),
            ),
          );
        }
        if (!snapshot.hasData) {
          //정상실행 되었지만 아직 데이터가 없을시
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //데이터가 항상 있는상태
        Map<ItemCode, List<StatModel>> statsMap = snapshot.data!;
        StatModel pm10RecentStat = statsMap[ItemCode.PM10]![0];

        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: pm10RecentStat.seoul,
          itemCode: ItemCode.PM10,
        );

        final ssModel = statsMap.keys.map((key) {
          final value = statsMap[key]!;
          final stat = value[0];

          return StatAndStatusModel(
            itemCode: key,
            status: DataUtils.getStatusFromItemCodeAndValue(
              itemCode: key,
              value: stat.getValueFromRegion(region),
            ),
            stat: stat,
          );
        }).toList();

        return Scaffold(
          drawer: MainDrawer(
            onRegionTap: (String region) {
              setState(() {
                this.region = region;
              });
              Navigator.of(context).pop();
            },
            selectedRegion: region,
            darkColor: status.darkColor,
            lightColor: status.lightColor,
          ),
          body: Container(
            color: status.primaryColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainAppBar(
                  stat: pm10RecentStat,
                  status: status,
                  region: region,
                  isExpanded: isExpanded,
                ),
                //Sliver에서 일반위젯 사용가능하게 하는 위젯
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        region: region,
                        models: ssModel,
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ...statsMap.keys.map((itemCode) {
                        final stats = statsMap[itemCode]!;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: HourlyCard(
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                            category: DataUtils.getHangulStringFromItemCode(
                              itemCode: itemCode,
                            ),
                            stats: stats,
                            region: region,
                          ),
                        );
                      }).toList(),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
