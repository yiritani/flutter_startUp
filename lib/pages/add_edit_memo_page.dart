import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/model/memo.dart';

class AddMemoPage extends StatefulWidget {
  final Memo? currentMemo;
  const AddMemoPage({super.key, this.currentMemo});

  @override
  State<AddMemoPage> createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  Future<void> addMemo() async {
    final memoCollection = FirebaseFirestore.instance.collection('memo');
    await memoCollection.add({
      'title': titleController.text,
      'detail': textController.text,
      'createdDate': Timestamp.now(),
    });
  }

  Future<void> editMemo() async {
    final memoCollection = FirebaseFirestore.instance.collection('memo');
    await memoCollection.doc(widget.currentMemo!.id).update({
      'title': titleController.text,
      'detail': textController.text,
    });
  }

  @override
  void initState() {
    super.initState();
    if(widget.currentMemo != null) {
      titleController.text = widget.currentMemo!.title;
      textController.text = widget.currentMemo!.text;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentMemo == null ? 'Add Memo' : 'Edit Memo'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                labelText: 'Text',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    if(widget.currentMemo == null) {
                      await addMemo();
                    } else {
                      await editMemo();
                    }
                    Navigator.pop(context);
                  },
                  child: Text(widget.currentMemo == null ? 'Add' : 'Edit')
              ),
            )
          ],
        ),
      ),
    );
  }
}
