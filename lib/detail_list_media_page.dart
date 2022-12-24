// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';
import 'dart:developer';

import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sample_vlc_player/media_response_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class DetailListMediaPage extends StatefulWidget {
  final List<FileElement> mediaFiles;
  final String albumName;
  const DetailListMediaPage(
      {Key? key, required this.mediaFiles, required this.albumName})
      : super(key: key);

  @override
  State<DetailListMediaPage> createState() => _DetailListMediaPageState();
}

class _DetailListMediaPageState extends State<DetailListMediaPage> {
  List<FileElement> get mediaFiles => widget.mediaFiles;
  List<Uint8List?> listThumbnail = [];

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<Uint8List?> fetchThumb(FileElement video) =>
      VideoThumbnail.thumbnailData(
        video: video.path,
        imageFormat: ImageFormat.PNG,
        maxWidth: 150,
        quality: 50,
      );

  init() async* {
    listThumbnail = List.generate(mediaFiles.length, (index) => null);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.albumName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: mediaFiles.length,
            itemBuilder: (context, index) {
              final file = mediaFiles[index];
              final dateAdded = DateTime.fromMillisecondsSinceEpoch(
                  int.parse(file.dateAdded) * 1000);
              final duration =
                  Duration(milliseconds: (int.parse(file.duration)));
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 10, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 100,
                        child: Stack(
                          children: [
                            FutureBuilder(
                              future: fetchThumb(file),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Uint8List?> snapshot) {
                                log("Snapshot =>  ${file.displayName}${snapshot.connectionState.toString()} ${snapshot.hasData}");

                                if (snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedMemoryImage(
                                      width: 150,
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                      uniqueKey:
                                          "app://image/${file.dateAdded}",
                                      bytes: snapshot.data,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Text(
                                "${formatDuration(duration)}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${file.displayName}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${dateAdded.year}-${dateAdded.month}-${dateAdded.day}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "${(double.parse(file.size) / 1048576).toStringAsFixed(1)} MB",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_vert_outlined),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
