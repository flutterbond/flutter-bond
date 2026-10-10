// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  uuid: json['uuid'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  color: json['color'] as String,
  description: json['description'] as String?,
  urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
  likes: json['likes'] as num,
  author: Author.fromJson(json['author'] as Map<String, dynamic>),
  views: json['views'] as num,
  downloads: json['downloads'] as num,
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'uuid': instance.uuid,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'color': instance.color,
  'description': instance.description,
  'urls': instance.urls,
  'likes': instance.likes,
  'author': instance.author,
  'views': instance.views,
  'downloads': instance.downloads,
};

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
  uuid: json['uuid'] as String,
  updatedAt: DateTime.parse(json['updated_at'] as String),
  username: json['username'] as String,
  name: json['name'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String?,
  avatar: json['avatar'] as String,
  twitterUsername: json['twitter_username'] as String?,
  instagramUsername: json['instagram_username'] as String?,
  bio: json['bio'] as String?,
  totalLikes: json['total_likes'] as num,
  totalPhotos: json['total_photos'] as num,
);

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
  'uuid': instance.uuid,
  'updated_at': instance.updatedAt.toIso8601String(),
  'username': instance.username,
  'name': instance.name,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'avatar': instance.avatar,
  'twitter_username': instance.twitterUsername,
  'instagram_username': instance.instagramUsername,
  'bio': instance.bio,
  'total_likes': instance.totalLikes,
  'total_photos': instance.totalPhotos,
};

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
  raw: json['raw'] as String,
  full: json['full'] as String,
  regular: json['regular'] as String,
  small: json['small'] as String,
  thumb: json['thumb'] as String,
  smallS3: json['small_s3'] as String,
);

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
  'raw': instance.raw,
  'full': instance.full,
  'regular': instance.regular,
  'small': instance.small,
  'thumb': instance.thumb,
  'small_s3': instance.smallS3,
};
