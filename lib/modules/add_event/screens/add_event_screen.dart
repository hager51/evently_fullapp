import 'package:evently_c20_online/core/services/db_service.dart';
import 'package:evently_c20_online/modules/add_event/manager/event_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constante/app_category.dart';
import '../../layout/widgets/tab_widget.dart';

class AddEventScreen extends StatelessWidget {
  static const String routeName = "AddEventScreen";
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text("Add Event")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<EventProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(provider.selectedCategory.image),
                          ),
                          DefaultTabController(
                            length: AppCategory.categories.length,
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              isScrollable: true,
                              onTap: (value) {
                                provider.changeIndex(value);
                              },
                              tabAlignment: TabAlignment.start,
                              padding: EdgeInsets.all(0),
                              labelPadding: EdgeInsets.all(8),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                ...AppCategory.categories.map((e) {
                                  int categoryIndex = AppCategory.categories
                                      .indexOf(e);
                                  return TabWidget(
                                    category: e,
                                    isSelected: provider.index == categoryIndex,
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
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
                          Text("Desc", style: theme.textTheme.titleLarge),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 140,
                            child: TextFormField(
                              controller: provider.descController,
                              expands: true,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                hintText: "Event Desc",
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.date_range, color: theme.primaryColor),
                              SizedBox(width: 8),
                              Text(
                                "Event Date",
                                style: theme.textTheme.titleLarge,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: provider.selectedDateTime,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      Duration(days: 365),
                                    ),
                                  ).then((value) {
                                    if (value != null) {
                                      provider.changeDate(value);
                                    }
                                  });
                                },
                                child: Text(
                                  provider.selectedDateTime == null
                                      ? "Choose Date"
                                      : DateFormat.yMd().format(
                                    provider.selectedDateTime!,
                                  ),
                                  style: theme.textTheme.titleMedium!.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.timelapse_outlined,
                                color: theme.primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Event Time",
                                style: theme.textTheme.titleLarge,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      provider.changeTime(value);
                                    }
                                  });
                                },
                                child: Text(
                                  provider.selectedTime == null
                                      ? "Choose Time"
                                      : provider.selectedTime!.format(context),
                                  style: theme.textTheme.titleMedium!.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        provider.addEvent(context);
                      },
                      child: Center(
                        child: provider.isLoading
                            ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        )
                            : Text("Add Event"),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}