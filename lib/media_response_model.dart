// To parse this JSON data, do
//
//     final mediaResponseModel = mediaResponseModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<MediaResponseModel> mediaResponseModelFromJson(String str) =>
    List<MediaResponseModel>.from(
        json.decode(str).map((x) => MediaResponseModel.fromJson(x)));

String mediaResponseModelToJson(List<MediaResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MediaResponseModel {
  MediaResponseModel({
    required this.files,
    required this.folderName,
  });

  List<FileElement> files;
  String folderName;

  factory MediaResponseModel.fromJson(Map<String, dynamic> json) =>
      MediaResponseModel(
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
        folderName: json["folderName"],
      );

  Map<String, dynamic> toJson() => {
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "folderName": folderName,
      };
}

class FileElement {
  FileElement({
    required this.album,
    required this.artist,
    required this.path,
    required this.dateAdded,
    required this.displayName,
    required this.duration,
    required this.size,
  });

  String album;
  String artist;
  String path;
  String dateAdded;
  String displayName;
  String duration;
  String size;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        album: json["album"],
        artist: json["artist"],
        path: json["path"],
        dateAdded: json["dateAdded"],
        displayName: json["displayName"],
        duration: json["duration"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "album": album,
        "artist": artist,
        "path": path,
        "dateAdded": dateAdded,
        "displayName": displayName,
        "duration": duration,
        "size": size,
      };
}
