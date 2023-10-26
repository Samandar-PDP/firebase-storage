import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FullImage extends StatefulWidget {
  const FullImage({super.key, required this.imageAccess});

  final String imageAccess;

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(widget.imageAccess,width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
          Positioned(
            left: 10,
            top: 20,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12
                ),
                child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setWallpaper();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
        },
        child: const Icon(Icons.wallpaper),
      ),
    );
  }

  void setWallpaper() async {
    final cachedImage = await DefaultCacheManager().getSingleFile(widget.imageAccess);
    await WallpaperManager.setWallpaperFromFile(cachedImage.path, WallpaperManager.BOTH_SCREEN);
  }
}
