import 'package:evently_c20_online/core/constante/app_category.dart';
import 'package:evently_c20_online/core/models/event_model.dart';
import 'package:evently_c20_online/core/services/db_service.dart';
import 'package:evently_c20_online/core/toast_service/toast.dart';
import 'package:flutter/material.dart';

class EditEventProvider extends ChangeNotifier {
  EventModel event;

  late int index;
  late AppCategory selectedCategory;
  late DateTime selectedDate;
  late String selectedTime;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool isLoading = false;

  EditEventProvider(this.event) {
    index = AppCategory.categories.indexWhere((e) => e.id == event.categoryId);
    if (index == -1) index = 0;
    selectedCategory = AppCategory.categories[index];

    titleController.text = event.title;
    descController.text = event.desc;
    selectedTime = event.time;
    selectedDate = DateTime.tryParse(event.date) ?? DateTime.now();
  }

  void changeIndex(int value) {
    index = value;
    selectedCategory = AppCategory.categories[index];
    notifyListeners();
  }

  void changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void changeTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  TimeOfDay getInitialTime() {
    var match = RegExp(
      r'(\d{1,2}):(\d{2})\s*([AaPp][Mm])?',
    ).firstMatch(selectedTime);
    if (match == null) return TimeOfDay.now();

    int hour = int.parse(match.group(1)!);
    int minute = int.parse(match.group(2)!);
    String? period = match.group(3)?.toLowerCase();

    if (period == 'pm' && hour < 12) hour += 12;
    if (period == 'am' && hour == 12) hour = 0;

    return TimeOfDay(hour: hour % 24, minute: minute % 60);
  }

  Future<void> updateEvent(BuildContext context) async {
    if (titleController.text.trim().isEmpty) {
      Toast.show(
        title: "Please enter the event title",
        context: context,
        type: ToastType.error,
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      event.title = titleController.text.trim();
      event.desc = descController.text.trim();
      event.categoryId = selectedCategory.id;
      event.date = selectedDate.toString();
      event.time = selectedTime;

      await DbService.updateEvent(event);

      isLoading = false;
      notifyListeners();

      if (!context.mounted) return;
      Toast.show(title: "Event updated", context: context);
      Navigator.pop(context);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      if (context.mounted) {
        Toast.show(title: e.toString(), context: context, type: ToastType.error);
      }
    }
  }
}