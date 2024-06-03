class News {
  String? sId;
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  News(
      {this.sId,
      this.title,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  News.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
