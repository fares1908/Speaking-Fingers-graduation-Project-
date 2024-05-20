import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VideoResponse {
  VideoResponse({
    this.status,
    this.data,
    this.message,
  });

  VideoResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? status;
  Data? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.videos,
  });

  Data.fromJson(dynamic json) {
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Videos.fromJson(v));
      });
    }
  }

  List<Videos>? videos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (videos != null) {
      map['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Videos {
  Videos({
    this.id,
    this.title,
    this.description,
    this.videoFile,
    this.thumbnail,
    this.isFav,
  });

  Videos.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    videoFile = json['video_file'];
    thumbnail = json['thumbnail'];
    isFav = json['is_fav'] is bool ? json['is_fav'] : (json['is_fav'] == 'true' ? true : false);
  }

  num? id;
  String? title;
  String? description;
  String? videoFile;
  String? thumbnail;
  bool? isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['video_file'] = videoFile;
    map['thumbnail'] = thumbnail;
    map['is_fav'] = isFav;
    return map;
  }
}