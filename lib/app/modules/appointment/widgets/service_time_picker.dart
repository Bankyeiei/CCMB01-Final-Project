import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceTimePicker extends StatelessWidget {
  final Rx<Time?> timeValue;
  final String label;
  final RxString errorText;
  const ServiceTimePicker({
    super.key,
    required this.timeValue,
    required this.label,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            showPicker(
              context: context,
              is24HrFormat: true,
              maxMinute: 45,
              value: timeValue.value ?? Time(hour: 12, minute: 0),
              onChange: (time) => timeValue.value = time,
              showCancelButton: false,
              minuteInterval: TimePickerInterval.FIFTEEN,
              accentColor: Get.theme.primaryColor,
              unselectedColor: Get.theme.colorScheme.secondary,
              okText: 'OK',
              okStyle: Get.textTheme.titleLarge!.copyWith(
                color: Get.theme.primaryColor,
              ),
            ),
          ),
      child: AbsorbPointer(
        child: Obx(
          () => SizedBox(
            height: 88,
            child: TextField(
              canRequestFocus: false,
              readOnly: true,
              controller: TextEditingController(
                text:
                    timeValue.value != null
                        ? timeValue.value!.format(context)
                        : '',
              ),
              decoration: InputDecoration(
                isDense: true,
                errorText: errorText.isEmpty ? null : errorText.value,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.schedule, size: 24, color: Colors.black54),
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
