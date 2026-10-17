import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SelectedWidget extends StatelessWidget {
  final bool isSelected;
   String? title;
   String? icon;
  void Function()? onTap;


  SelectedWidget({super.key, this.isSelected = true, required this.title,required this.onTap});
  SelectedWidget.icon({super.key, this.isSelected = true, required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.dividerColor
          ),
          color: isSelected ? theme.primaryColor : theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: icon != null
            ? ImageIcon(
                AssetImage(icon!),
                size: 24,
                color: isSelected ? Colors.white : theme.primaryColorLight,
              )
            : Text(
                title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : theme.primaryColorLight,
                ),
              ),
      ),
    );
  }
}
