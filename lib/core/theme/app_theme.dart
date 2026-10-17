import 'package:evently_c20_online/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      selectedItemColor: AppColors.lightPrimaryColor,
    ),
    scaffoldBackgroundColor: AppColors.lightBgColor,
    primaryColor: AppColors.lightPrimaryColor,
    dividerColor: AppColors.lightDividerColor,
    primaryColorLight: AppColors.lightPrimaryColor,
    primaryColorDark: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        foregroundColor: Colors.white,
          padding: EdgeInsets.all(16),
          backgroundColor: AppColors.lightPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          )
      )
    ),
    inputDecorationTheme: InputDecorationThemeData(
      prefixIconColor: Color(0xff686868),
        hintStyle:TextStyle(
            color: Color(0xff686868)
        ) ,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xffF0F0F0),
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xffF0F0F0),
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xffF0F0F0),
            )
        )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.lightPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.lightGrayColor,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBgColor,
      elevation: 0,
      selectedItemColor: AppColors.darkPrimaryColor,
      unselectedItemColor: Color(0xffB9B9B9)
    ),
    scaffoldBackgroundColor: AppColors.darkBgColor,
    primaryColor: AppColors.darkPrimaryColor,
    dividerColor: AppColors.darkDividerColor,
    primaryColorLight: Colors.white,
    primaryColorDark: Color(0xff001440),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(16),
            backgroundColor: AppColors.darkPrimaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            )
        )
    ),

    inputDecorationTheme: InputDecorationThemeData(
      prefixIconColor: Color(0xffD6D6D6),
        hintStyle:TextStyle(
            color: Color(0xffD6D6D6)
        ) ,
        fillColor:Color(0xff001440),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff002D8F),
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff002D8F),
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff002D8F),
            )
        )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.darkPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrayColor,
      ),
    ),
  );
}
