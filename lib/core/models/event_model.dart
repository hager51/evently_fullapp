import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String id;
   String? userId;
  String categoryId;
  String title;
  String desc;
  String time;
  String date;

  List<String> usersFav;

  EventModel({
    required this.id,
    required this.categoryId,
    required this.date,
    required this.desc,
    required this.time,
    required this.title,
    this.userId,
    this.usersFav = const []

  });

  Map<String, dynamic> toJson() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return {
      "id": id,
      "categoryId": categoryId,
      "date": date,
      "time": time,
      "desc": desc,
      "title": title,
      "userId":userId,
      "usersFav":usersFav
    };
  }

  factory fromJson(Map<String, dynamic> json) {
    List fav = json["usersFav"]??[];
    return EventModel(
      id: json["id"],
      categoryId: json["categoryId"],
      date: json["date"],
      desc: json["desc"],
      time: json["time"],
      title: json["title"],
      userId: json["userId"],
      usersFav: fav.map<String>((e) {
        return e.toString();
      },).toList()
    );
  }
}
