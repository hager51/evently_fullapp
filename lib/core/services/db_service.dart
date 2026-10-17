import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c20_online/core/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  static var firebase = FirebaseFirestore.instance;

  static Future<void> addEvent(EventModel event) async {
    var doc = await firebase.collection("Events").doc();
    event.id = doc.id;
    doc.set(event.toJson());
  }

  static Future<List<EventModel>> getEvents(String? categoryId) async {
    List<EventModel> events = [];
    var data;
    if (categoryId == null) {
      data = await firebase.collection("Events").get();
    } else {
      data = await firebase
          .collection("Events")
          .where("categoryId", isEqualTo: categoryId)
          .get();
    }

    for (var e in data.docs) {
      var event = EventModel.fromJson(e.data());
      events.add(event);
    }

    return events;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getEventsStream(
      String? categoryId,
      ) {
    // List<EventModel> events = [];
    Stream<QuerySnapshot<Map<String, dynamic>>> data;
    if (categoryId == null) {
      data = firebase.collection("Events").snapshots();
    } else {
      data = firebase
          .collection("Events")
          .where("categoryId", isEqualTo: categoryId)
          .snapshots();
    }

    return data;
  }

  static Future<List<EventModel>> getFavEvents() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    List<EventModel> events = [];
    var data = await firebase
        .collection("Events")
        .where("usersFav", arrayContains: userId)
        .get();

    for (var e in data.docs) {
      var event = EventModel.fromJson(e.data());
      events.add(event);
    }

    return events;
  }

  static Future<void> toggleFav(EventModel event) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    if (event.usersFav.contains(userId)) {
      event.usersFav.remove(userId);
    } else {
      event.usersFav.add(userId);
    }
    await firebase.collection("Events").doc(event.id).update(event.toJson());
  }

  // بيجيب حدث واحد ويفضل يسمع لأي تغيير فيه (تعديل أو حذف)
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getEventStream(
      String id,
      ) {
    return firebase.collection("Events").doc(id).snapshots();
  }

  // بيعدّل بيانات الحدث بس (من غير ما يغيّر صاحب الحدث أو اللي حاطينه في المفضلة)
  static Future<void> updateEvent(EventModel event) async {
    await firebase.collection("Events").doc(event.id).update({
      "title": event.title,
      "desc": event.desc,
      "categoryId": event.categoryId,
      "date": event.date,
      "time": event.time,
    });
  }

  static Future<void> deleteEvent(String id) async {
    await firebase.collection("Events").doc(id).delete();
  }
}