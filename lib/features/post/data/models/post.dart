import 'package:json_annotation/json_annotation.dart';
import 'package:bond_network/bond_network.dart';

part 'author.dart';
part 'post.g.dart';
part 'urls.dart';

@JsonSerializable()
class Post extends Model {
  final String uuid;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String color;
  final String? description;
  final Urls urls;
  final num likes;
  final Author author;
  final num views;
  final num downloads;

  const Post({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
    this.description,
    required this.urls,
    required this.likes,
    required this.author,
    required this.views,
    required this.downloads,
  }) : super(id: -1);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostToJson(this);

  // Posts have no numeric id (always -1), so compare them by uuid. Riverpod 3
  // only notifies when a state is != the previous one.
  @override
  List<Object?> get props => [uuid, updatedAt];
}
