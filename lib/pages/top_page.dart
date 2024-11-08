import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/model/memo.dart';
import 'package:untitled1/pages/add_edit_memo_page.dart';
import 'package:untitled1/pages/memo_detail.dart';


class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});
  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final memoCollection = FirebaseFirestore.instance.collection('memo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: memoCollection.snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final Memo fetchMemo = Memo(
                id: docs[index].id,
                title: docs[index]['title'],
                text: docs[index]['detail'],
                createdDate: docs[index]['createdDate'],
              );
              return ListTile(
                title: Text(fetchMemo.title),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    showModalBottomSheet(context: context, builder: (context) {
                      return SafeArea(
                        child:  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemoPage(currentMemo: fetchMemo)));
                              },
                              title: Text('Edit'),
                            ),
                            ListTile(
                              leading: Icon(Icons.delete),
                              onTap: () async {
                                await memoCollection.doc(fetchMemo.id).delete();
                                Navigator.pop(context);
                              },
                              title: Text('Delete'),
                            )
                          ],
                        )
                      );
                    });
                  },
                ),
                subtitle: Text(fetchMemo.text),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MemoDetailPage(fetchMemo)));
                },
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMemoPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
