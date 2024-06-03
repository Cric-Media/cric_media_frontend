class SocialLink {
  String? mediaType;
  String? link;
  String? sId;
  int? iV;

  SocialLink({this.mediaType, this.link, this.sId, this.iV});

  SocialLink.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    link = json['link'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaType'] = mediaType;
    data['link'] = link;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
