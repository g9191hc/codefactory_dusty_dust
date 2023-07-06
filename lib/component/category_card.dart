import 'package:dusty_dust/component/card_title.dart';
import 'package:flutter/material.dart';

import '../const/color.dart';
import '../model/stat_and_status_model.dart';
import '../utils/data_utils.dart';
import 'main_card.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  final List<StatAndStatusModel> models;

  const CategoryCard({
    super.key,
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: models
                      .map(
                        (model) => MainStat(
                          category: DataUtils.getHangulStringFromItemCode(
                            itemCode: model.itemCode,
                          ),
                          imgPath: model.status.imagePath,
                          label: model.status.label,
                          stat:
                              '${model.stat.getValueFromRegion(region)}${DataUtils.getUnitFromItemCode(
                            itemCode: model.itemCode,
                          )}',
                          width: constraint.maxWidth / 3,
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
