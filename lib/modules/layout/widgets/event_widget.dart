import 'package:evently_c20_online/core/constante/app_category.dart';
import 'package:evently_c20_online/core/models/event_model.dart';
import 'package:evently_c20_online/modules/event_details/screens/event_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  EventModel event;
  Function onTapFav;
  Function? onReturn;
  EventWidget({
    super.key,
    required this.event,
    required this.onTapFav,
    this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var category = AppCategory.categories.firstWhere((element) {
      return element.id == event.categoryId;
    });
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          EventDetailsScreen.routeName,
          arguments: event,
        );
        onReturn?.call();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(category.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(event.time, style: theme.textTheme.titleMedium),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(event.title, style: theme.textTheme.titleLarge),
                  ),
                  InkWell(
                    onTap: () {
                      onTapFav();
                    },
                    child: Icon(
                      event.usersFav.contains(
                        FirebaseAuth.instance.currentUser!.uid,
                      )
                          ? Icons.favorite_rounded
                          : Icons.favorite_border,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}