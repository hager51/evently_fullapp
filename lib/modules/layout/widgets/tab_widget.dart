import 'package:evently_c20_online/core/constante/app_category.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  bool isSelected;
  AppCategory category;
   TabWidget({super.key,required this.category , required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Tab(
      child: Container(

        padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12
        ),
        decoration: BoxDecoration(
            color: isSelected?  theme.primaryColor : theme.primaryColorDark,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(category.iconData,color:!isSelected? theme.primaryColor : null,),
            SizedBox(width: 8,),
            Text(category.name,style: TextStyle(
              color: isSelected? Colors.white : theme.textTheme.titleLarge!.color
            ),),
          ],
        ),
      ),
    );
  }
}
