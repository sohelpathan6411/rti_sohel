import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/utils/date_utils.dart';
import '../theme/app_colors.dart';
import 'calendar_img.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final bool isEndDate;
  final void Function(DateTime? selectedDate) onDateSelected;

  const CustomDatePicker(
      {this.initialDate,
      required this.onDateSelected,
      required this.isEndDate});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _selectDate(DateTime? date, int buttonIndex) {
    setState(() {
      _selectedDate = date;
      _selectedIndex = buttonIndex;
    });
  }

  void _onCancelPressed() {
    Navigator.of(context).pop();
  }

  void _onSavePressed() {
    widget.onDateSelected(_selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.isEndDate ? _endDateOptions() : _startDateOptions(),
            _carousel(),
            const SizedBox(height: 30.0),
            Divider(color: AppColors.primary.withOpacity(0.5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CalendarImg(
                      calendarSize: 18,
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      _selectedDate == null
                          ? "No Date"
                          : DateUtilsFormat.formatShortDate(
                              _selectedDate!.toLocal()),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: _selectedDate == null
                              ? Colors.grey.shade700
                              : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  ),
                  onPressed: _onCancelPressed,
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.roboto(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  ),
                  onPressed: _onSavePressed,
                  child: Text(
                    'Save',
                    style: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _carousel() {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: CalendarCarousel(
        onDayPressed: (DateTime date, List<dynamic> events) {
          setState(() {
            _selectedDate = date;
          });
        },
        dayPadding: 4,
        minSelectedDate: _selectedDate,
        selectedDateTime: _selectedDate,
        headerMargin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        showOnlyCurrentMonthDate: true,
        headerTextStyle: GoogleFonts.roboto(
            color: AppColors.calendarDatesColor,
            fontSize: 19.0,
            fontWeight: FontWeight.w500),
        weekdayTextStyle: GoogleFonts.roboto(
            color: AppColors.calendarDatesColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500),
        weekendTextStyle: GoogleFonts.roboto(
            color: AppColors.calendarDatesColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w400),
        daysTextStyle: GoogleFonts.roboto(
            color: AppColors.calendarDatesColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w400),
        selectedDayButtonColor: AppColors.primary,
        selectedDayBorderColor: AppColors.primary,
        todayBorderColor: AppColors.primary,
        todayButtonColor: Colors.white,
        daysHaveCircularBorder: true,
        todayTextStyle: GoogleFonts.roboto(
          color: AppColors.primary,
          fontSize: 14.0,
        ),
        selectedDayTextStyle: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 14.0,
        ),
        leftButtonIcon: const Icon(
          Icons.arrow_left_rounded,
          size: 45,
          color: AppColors.subtitleColor,
        ),
        rightButtonIcon: const Icon(
          Icons.arrow_right_rounded,
          size: 45,
          color: AppColors.subtitleColor,
        ),
      ),
    );
  }

  Widget _endDateOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildDateButton('No Date', null, 0),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: _buildDateButton('Today', DateTime.now(), 1),
        ),
      ],
    );
  }

  Widget _startDateOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildDateButton(
                'Today',
                DateTime.now(),
                0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildDateButton(
                  'Next ${(DateUtilsFormat.formatShortDay(DateTime.now().add(Duration(days: 1)).toLocal())).split(",").first}',
                  DateTime.now().add(Duration(days: 1)),
                  1),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildDateButton(
                  'Next ${(DateUtilsFormat.formatShortDay(DateTime.now().add(Duration(days: 2)).toLocal())).split(",").first}',
                  DateTime.now().add(Duration(days: 2)),
                  2),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildDateButton(
                  'After 1 Week', DateTime.now().add(Duration(days: 7)), 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateButton(String label, DateTime? date, int buttonIndex) {
    return ElevatedButton(
      style: _selectedIndex == buttonIndex
          ? ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            ),
      onPressed: () => _selectDate(date, buttonIndex),
      child: Text(label,
          style: _selectedIndex == buttonIndex
              ? GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400)
              : GoogleFonts.roboto(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
    );
  }
}
