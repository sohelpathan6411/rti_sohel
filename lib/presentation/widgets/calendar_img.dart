import 'package:flutter/material.dart';

class CalendarImg extends StatelessWidget {
  final double calendarSize;
  const CalendarImg({Key? key, required this.calendarSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/calendar.png",
        width: calendarSize,
        fit: BoxFit.contain,
      ),
    );
  }
}

class DeleteImg extends StatelessWidget {

  final double? iconSize;
  const DeleteImg({Key? key, required this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/delete.png",
      width: iconSize,
      fit: BoxFit.contain,
    );
  }
}
