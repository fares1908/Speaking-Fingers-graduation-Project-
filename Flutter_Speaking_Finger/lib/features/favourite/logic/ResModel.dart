class RespModel {
  String? status;
  Data? data;
  String? message;

  RespModel({
    this.status,
    this.data,
    this.message,
  });

  RespModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Video? video;

  Data({this.video});

  Data.fromJson(Map<String, dynamic> json) {
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    return data;
  }
}

class Video {
  int? id;
  String? title;
  String? description;
  String? videoFile;
  String? thumbnail;

  Video(
      {this.id, this.title, this.description, this.videoFile, this.thumbnail});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    videoFile = json['video_file'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['video_file'] = this.videoFile;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
