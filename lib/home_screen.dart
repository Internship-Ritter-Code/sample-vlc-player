// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:sample_vlc_player/detail_list_media_page.dart';
import 'package:sample_vlc_player/media_response_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MediaResponseModel> listMedia = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    setState(() {});
  }

  Future<String> getVideoPath() async {
    String videoPath = "";
    try {
      isLoading = true;
      videoPath = (await StoragePath.videoPath)!;

      final response = mediaResponseModelFromJson(videoPath);
      listMedia = response;
      setState(() {});
      log("Response Path => $videoPath");
      log("Response Length => ${response.length}");
    } on PlatformException {
      videoPath = 'Failed to get path';
    } finally {
      isLoading = false;
    }
    return videoPath;
  }

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getVideoPath();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Media Player")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listMedia.length,
              itemBuilder: (context, index) {
                final media = listMedia[index];
                return ListTile(
                  leading: Icon(Icons.folder),
                  title: Text("${media.folderName}"),
                  subtitle: Text("${media.files.length} Videos"),
                  minLeadingWidth: 2,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailListMediaPage(
                          mediaFiles: media.files,
                          albumName: media.folderName,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
