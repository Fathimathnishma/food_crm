import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeProvider with ChangeNotifier {
  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;

  String get formattedDate => DateFormat('EEE d').format(_dateTime);
  String get formattedTime => DateFormat('h:mm a').format(_dateTime);

  int usersCount = 0;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? countListner;

  void updateDateTime(DateTime newDateTime) {
    _dateTime = newDateTime;
    notifyListeners();
  }

  Future<void> getUsersCount() async {
    countListner = FirebaseFirestore.instance
        .collection('general')
        .doc('general')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        usersCount = snapshot.data()?['count'] ?? 0;
        notifyListeners();
      }
    });
  }
}
