import 'package:dusty_dust/const/color.dart';
import 'package:flutter/material.dart';

const regions = [
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '세종',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '부산',
  '제주',
  '충북',
  '경남',
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

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
                  onTap: () {},
                  title: Text(
                    e,
                  ),
                  //타일 기본 배경색
                  tileColor: Colors.white,
                  //선택된 상태인지 여부
                  selected: e == '서울',
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
