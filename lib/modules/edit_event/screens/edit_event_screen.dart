import 'package:evently_c20_online/core/constante/app_category.dart';
import 'package:evently_c20_online/core/models/event_model.dart';
import 'package:evently_c20_online/modules/edit_event/manager/edit_event_manager.dart';
import 'package:evently_c20_online/modules/layout/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatelessWidget {
  static const String routeName = "EditEventScreen";
  const EditEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;

    return ChangeNotifierProvider(
      create: (context) => EditEventProvider(event),
      child: Consumer<EditEventProvider>(
        builder: (context, provider, child) {
          var theme = Theme.of(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Edit event",
                style: theme.textTheme.titleLarge!.copyWith(fontSize: 18),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildImage(provider),
                            buildCategoryTabs(provider),
                            SizedBox(height: 16),
                            Text("Title", style: theme.textTheme.titleLarge),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: provider.titleController,
                              decoration: InputDecoration(
                                hintText: "Event Title",
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Description",
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              height: 140,
                              child: TextFormField(
                                controller: provider.descController,
                                expands: true,
                                maxLines: null,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                  hintText: "Event Description",
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            buildDateRow(context, provider),
                            SizedBox(height: 16),
                            buildTimeRow(context, provider),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    buildUpdateButton(context, provider),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget buildImage(EditEventProvider provider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(provider.selectedCategory.image),
    );
  }

  Widget buildCategoryTabs(EditEventProvider provider) {
    return DefaultTabController(
      length: AppCategory.categories.length,
      initialIndex: provider.index,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(color: Colors.transparent),
        isScrollable: true,
        onTap: (value) {
          provider.changeIndex(value);
        },
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.all(0),
        labelPadding: EdgeInsets.all(8),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: AppCategory.categories.map((category) {
          int categoryIndex = AppCategory.categories.indexOf(category);
          return TabWidget(
            category: category,
            isSelected: provider.index == categoryIndex,
          );
        }).toList(),
      ),
    );
  }

  Widget buildDateRow(BuildContext context, EditEventProvider provider) {
    var theme = Theme.of(context);

    return Row(
      children: [
        Icon(Icons.date_range, color: theme.primaryColor),
        SizedBox(width: 8),
        Text("Event Date", style: theme.textTheme.titleLarge),
        Spacer(),
        GestureDetector(
          onTap: () {
            DateTime now = DateTime.now();
            DateTime firstDate = provider.selectedDate.isBefore(now)
                ? provider.selectedDate
                : now;

            showDatePicker(
              context: context,
              initialDate: provider.selectedDate,
              firstDate: firstDate,
              lastDate: now.add(Duration(days: 365 * 2)),
            ).then((value) {
              if (value != null) {
                provider.changeDate(value);
              }
            });
          },
          child: Text(
            DateFormat.yMMMd().format(provider.selectedDate),
            style: theme.textTheme.titleMedium!.copyWith(
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTimeRow(BuildContext context, EditEventProvider provider) {
    var theme = Theme.of(context);

    return Row(
      children: [
        Icon(Icons.timelapse_outlined, color: theme.primaryColor),
        SizedBox(width: 8),
        Text("Event Time", style: theme.textTheme.titleLarge),
        Spacer(),
        GestureDetector(
          onTap: () {
            showTimePicker(
              context: context,
              initialTime: provider.getInitialTime(),
            ).then((value) {
              if (value != null && context.mounted) {
                provider.changeTime(value.format(context));
              }
            });
          },
          child: Text(
            provider.selectedTime,
            style: theme.textTheme.titleMedium!.copyWith(
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUpdateButton(BuildContext context, EditEventProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: provider.isLoading
            ? null
            : () {
          provider.updateEvent(context);
        },
        child: Center(
          child: provider.isLoading
              ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(color: Colors.white),
          )
              : Text("Update event"),
        ),
      ),
    );
  }
}