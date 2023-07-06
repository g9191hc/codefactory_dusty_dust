import 'package:flutter/material.dart';

import '../const/regions.dart';
import '../screen/home_screen.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final OnRegionTap onRegionTap;
  final String selectedRegion;

  const MainDrawer({
    super.key,
    required this.onRegionTap,
    required this.selectedRegion,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          //Drawer의 헤더
          DrawerHeader(
            child: Text(
              '지역 선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          //리스트의 요소로 풀어주기 위해 ... 사용
          ...regions
              .map(
                (e) => ListTile(
                  onTap: () {
                    onRegionTap(e);
                  },
                  title: Text(
                    e,
                  ),
                  //타일 기본 배경색
                  tileColor: Colors.white,
                  //선택된 상태인지 여부
                  selected: e == selectedRegion,
                  //선택된 상태일 때의 글자색
                  selectedColor: Colors.black,
                  //선택된 상태일 때의 배경색
                  selectedTileColor: lightColor,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
