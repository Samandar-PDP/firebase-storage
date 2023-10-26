import 'package:f_storage/full_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContentList extends StatefulWidget {
  const ContentList({super.key, required this.result});

  final List<Reference> result;

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  final List<String> _accessTokens = [];

  @override
  void initState() {
    super.initState();
    getAllTokens();
  }

  void getAllTokens() async {
    for (Reference i in widget.result) {
      final url = await i.getDownloadURL();
      _accessTokens.add(url);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: _accessTokens.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FullImage(
                      imageAccess: _accessTokens[index])));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: FadeInImage(
                placeholder: const NetworkImage(
                    "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"),
                image: NetworkImage(_accessTokens[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
