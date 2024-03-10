import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Datashowscreen extends StatelessWidget {
  const Datashowscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Show Screen"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshots.data!.docs[index];
                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: doc[("name")]));
                    },
                    icon: Icon(Icons.copy),
                  ),
                  title: Text(doc[("name")]),
                  subtitle: Text("id : ${doc[("id")]}"),
                  trailing: IconButton(
                    onPressed: () {
                      Share.share('check out my website https://example.com');
                    },
                    icon: Icon(Icons.share),
                  ),
                );
              });
        },
      ),
    );
  }
}
