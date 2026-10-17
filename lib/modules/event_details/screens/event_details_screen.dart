import 'package:evently_c20_online/core/constante/app_category.dart';
import 'package:evently_c20_online/core/models/event_model.dart';
import 'package:evently_c20_online/core/services/db_service.dart';
import 'package:evently_c20_online/core/toast_service/toast.dart';
import 'package:evently_c20_online/modules/edit_event/screens/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:evently_c20_online/modules/layout/screens/layout_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = "EventDetailsScreen";
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;

    return StreamBuilder(
      stream: DbService.getEventStream(event.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(snapshot.error.toString())),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(appBar: AppBar(), body: SizedBox());
        }

        EventModel currentEvent = EventModel.fromJson(snapshot.data!.data()!);
        return buildScreen(context, currentEvent);
      },
    );
  }

  Widget buildScreen(BuildContext context, EventModel event) {
    var theme = Theme.of(context);
    AppCategory category = AppCategory.categories.firstWhere(
          (element) => element.id == event.categoryId,
      orElse: () => AppCategory.categories.first,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Event details",
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditEventScreen.routeName,
                arguments: event,
              );
            },
            icon: Icon(Icons.edit_outlined, color: theme.primaryColor),
          ),
          IconButton(
            onPressed: () {
              showDeleteDialog(context, event);
            },
            icon: Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImage(context, category),
              SizedBox(height: 16),
              Text(event.title, style: theme.textTheme.titleLarge),
              SizedBox(height: 16),
              buildDateTimeCard(context, event),
              SizedBox(height: 16),
              Text("Description", style: theme.textTheme.titleLarge),
              SizedBox(height: 8),
              buildDescriptionCard(context, event),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context, AppCategory category) {
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(category.image),
    );
  }

  Widget buildDateTimeCard(BuildContext context, EventModel event) {
    var theme = Theme.of(context);

    DateTime? date = DateTime.tryParse(event.date);
    String dateText = date == null
        ? event.date
        : DateFormat('d MMMM').format(date);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.date_range, color: theme.primaryColor),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dateText, style: theme.textTheme.titleMedium),
              SizedBox(height: 4),
              Text(event.time, style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionCard(BuildContext context, EventModel event) {
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        event.desc,
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: theme.textTheme.titleLarge!.color,
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, EventModel event) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text("Delete event"),
          content: Text("Are you sure you want to delete this event?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                deleteEvent(context, event);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteEvent(BuildContext context, EventModel event) async {
    try {
      await DbService.deleteEvent(event.id);
      if (!context.mounted) return;
      Toast.show(title: "Event deleted", context: context);
      Navigator.popUntil(context, ModalRoute.withName(LayoutScreen.routeName));
    } catch (e) {
      if (context.mounted) {
        Toast.show(title: e.toString(), context: context, type: ToastType.error);
      }
    }
  }
}