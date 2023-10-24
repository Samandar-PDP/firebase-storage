import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'content_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ListResult>(
        future: FirebaseStorage.instance.ref('/wallpapers').listAll(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final images = snapshot.data?.items ?? [];
             return ContentList(result: images);
          } else if (snapshot.connectionState == ConnectionState.none || snapshot.hasError) {
            return const Center(child: Text("Error occurred"),);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
