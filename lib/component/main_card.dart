import 'package:flutter/material.dart';

import '../const/color.dart';

class MainCard extends StatelessWidget {
  final Widget child;

  const MainCard({super.key, required this.child,});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        color: lightColor,
        child: child
    );
  }
}
