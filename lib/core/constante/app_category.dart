import 'package:flutter/material.dart';

class AppCategory {
  String id;
  String name;
  String image;
  IconData iconData;

  AppCategory({required this.iconData , required this.id , required this.name , required this.image});



  static List<AppCategory> categories = [
    AppCategory(iconData: Icons.sports, id: "sport", name: "Sport", image: "assets/category/Sport.png"),
    AppCategory(iconData: Icons.baby_changing_station, id: "birthday", name: "Birthday", image: "assets/category/Birthday.png"),
    AppCategory(iconData: Icons.book, id: "book_club", name: "Book Club", image: "assets/category/Book Club.png"),
    AppCategory(iconData: Icons.meeting_room, id: "meeting", name: "Meeting", image: "assets/category/Meeting.png"),
    AppCategory(iconData: Icons.edit_outlined, id: "exhibition", name: "Exhibition", image: "assets/category/Exhibition.png"),
  ];
}