import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  String title;
  String text;
  Timestamp createdDate;
  DateTime? updatedDate;

  Memo({
    required this.title,
    required this.text,
    required this.createdDate,
    this.updatedDate
  });
}
