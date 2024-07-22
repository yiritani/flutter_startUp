import 'package:flutter/material.dart';
import 'package:untitled1/model/memo.dart';

class MemoDetailPage  extends StatelessWidget {
  final Memo memo;
  const MemoDetailPage(this.memo, {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memo.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: ${memo.title}'),
            Text('Detail: ${memo.text}', style: TextStyle(fontSize: 20, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
