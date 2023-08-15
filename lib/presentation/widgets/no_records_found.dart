import 'package:flutter/material.dart';

import '../../data/utils/size_config.dart';

class NoRecordsFound extends StatelessWidget {
  const NoRecordsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Image.asset(
          "assets/no_records.png",
          width: 260,
          height: 260,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
