import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDateRangePicker extends StatelessWidget {
  final RxList<DateTime?> dateValue;
  final DateTime? startDate;
  final DateTime? lastDate;
  const AppDateRangePicker({
    super.key,
    required this.dateValue,
    this.startDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      canRequestFocus: false,
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.range,
          firstDate: startDate,
          lastDate: lastDate,
          dayTextStyle: Get.textTheme.bodyMedium,
          selectedDayTextStyle: Get.textTheme.bodyLarge!.copyWith(
            color: Get.theme.colorScheme.onPrimary,
          ),
          weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
          controlsTextStyle: Get.textTheme.titleMedium,
          disableModePicker: true,
        ),
        value: dateValue,
        onValueChanged: (value) => dateValue.value = value,
      ),
    );
  }
}
