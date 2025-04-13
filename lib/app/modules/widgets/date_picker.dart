import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class AppDatePicker extends StatelessWidget {
  final Rx<DateTime?> dateValue;
  final String label;
  final DateTime? lastDate;
  final String dateFormat;
  const AppDatePicker({
    super.key,
    required this.dateValue,
    required this.label,
    this.lastDate,
    this.dateFormat = 'dd/MM/yyyy',
  });

  Future<void> _selectDate(BuildContext context) async {
    Get.focusScope!.unfocus();
    final results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        lastDate: lastDate ?? DateTime.now(),
        dayTextStyle: Get.textTheme.bodyMedium,
        selectedDayTextStyle: Get.textTheme.bodyLarge!.copyWith(
          color: Get.theme.colorScheme.onPrimary,
        ),
        weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        controlsTextStyle: Get.textTheme.titleMedium,
      ),
      dialogSize: Size(
        0.9 * Get.mediaQuery.size.width,
        0.9 * Get.mediaQuery.size.width,
      ),
      value: dateValue.value != null ? [dateValue.value!] : [],
    );
    if (results != null && results.isNotEmpty) {
      dateValue.value = results.first!;
    } else {
      dateValue.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextField(
            canRequestFocus: false,
            readOnly: true,
            controller: TextEditingController(
              text:
                  dateValue.value != null
                      ? DateFormat(dateFormat).format(dateValue.value!)
                      : '',
            ),
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.calendar_today,
                  size: 24,
                  color: Colors.black54,
                ),
              ),
              labelText: label,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
