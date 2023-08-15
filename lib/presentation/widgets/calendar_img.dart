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
        fit: BoxFit.fill,
      ),
    );
  }
}

class DeleteImg extends StatelessWidget {
  const DeleteImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/delete.png",
      width: 18,
      fit: BoxFit.fill,
    );
  }
}
