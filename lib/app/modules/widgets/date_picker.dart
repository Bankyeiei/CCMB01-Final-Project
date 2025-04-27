import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class AppDatePicker extends StatelessWidget {
  final Rx<DateTime?> dateValue;
  final String label;
  final DateTime? startDate;
  final DateTime? lastDate;
  final String dateFormat;
  final RxString? errorText;
  const AppDatePicker({
    super.key,
    required this.dateValue,
    required this.label,
    this.startDate,
    this.lastDate,
    this.dateFormat = 'dd/MM/yyyy',
    this.errorText,
  });

  Future<void> _selectDate(BuildContext context) async {
    Get.focusScope!.unfocus();
    final results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        firstDate: startDate,
        lastDate: lastDate,
        dayTextStyle: Get.textTheme.bodyMedium,
        selectedDayTextStyle: Get.textTheme.bodyLarge!.copyWith(
          color: Get.theme.colorScheme.onPrimary,
        ),
        weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        controlsTextStyle: Get.textTheme.titleMedium,
        okButtonTextStyle: Get.textTheme.titleLarge!.copyWith(
          color: Get.theme.primaryColor,
        ),
        cancelButtonTextStyle: Get.textTheme.titleLarge!.copyWith(
          color: Get.theme.primaryColor,
        ),
      ),
      dialogSize: Size(0.9 * Get.size.width, 0.9 * Get.size.width),
      value: dateValue.value != null ? [dateValue.value!] : [],
    );
    if (results != null && results.isNotEmpty) {
      dateValue.value = results.first!;
    } else {
      if (errorText == null) {
        dateValue.value = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: Obx(
          () => SizedBox(
            height: errorText == null ? null : 88,
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
                isDense: true,
                errorText:
                    errorText == null || errorText!.isEmpty
                        ? null
                        : errorText!.value,
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
                  borderSide: const BorderSide(width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Get.theme.colorScheme.error,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
