class Video {
  String? sId;
  String? title;
  String? description;
  String? videoUrl;
  String? thumbnail;
  List<String>? viewers;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Video({
    this.sId,
    this.title,
    this.description,
    this.videoUrl,
    this.thumbnail,
    this.viewers,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Video.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    thumbnail = json['thumbnail'];
    viewers = json['viewers'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['videoUrl'] = videoUrl;
    data['thumbnail'] = thumbnail;
    data['viewers'] = viewers;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
