class StoriesModel {
  int? id;
  String? userName;
  String? partnerName;
  String? description;
  String? marriageDate;
  String? imageUrl;
  int? rating;
  int? isApproved;
  String? createdAt;

  StoriesModel({
    this.id,
    this.userName,
    this.partnerName,
    this.description,
    this.marriageDate,
    this.imageUrl,
    this.rating,
    this.isApproved,
    this.createdAt,
  });

  StoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    partnerName = json['partner_name'];
    description = json['description'];
    marriageDate = json['marriage_date'];
    imageUrl = json['image_url'];
    rating = json['rating'];
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['partner_name'] = partnerName;
    data['description'] = description;
    data['marriage_date'] = marriageDate;
    data['image_url'] = imageUrl;
    data['rating'] = rating;
    data['is_approved'] = isApproved;
    data['created_at'] = createdAt;
    return data;
  }
}
