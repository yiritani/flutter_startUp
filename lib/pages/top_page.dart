import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/model/memo.dart';


class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});
  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<Memo> memoList = [
    Memo(title: 'aaaaaa', text: 'bbbbbbbbb', createdDate: Timestamp.now()),
  ];

  Future<void> fetchMemoList() async {
    final memoCollection = await FirebaseFirestore.instance.collection('memo').get();
    final docs = memoCollection.docs;
    for (final doc in docs) {
      final data = doc.data();
      Memo fetchMemo = Memo(
        title: data['title'],
        text: data['detail'],
        createdDate: data['createdDate'],
      );
      memoList.add(fetchMemo);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchMemoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(memoList[index].title),
            subtitle: Text(memoList[index].text),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
