import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  String id;
  String title;
  String text;
  Timestamp createdDate;
  DateTime? updatedDate;

  Memo({
    required this.id,
    required this.title,
    required this.text,
    required this.createdDate,
    this.updatedDate
  });
}
