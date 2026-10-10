// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformVersion _$PlatformVersionFromJson(Map<String, dynamic> json) =>
    PlatformVersion(
      minVersion: (json['min_version'] as num).toInt(),
      maxVersion: (json['max_version'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$PlatformVersionToJson(PlatformVersion instance) =>
    <String, dynamic>{
      'min_version': instance.minVersion,
      'max_version': instance.maxVersion,
      'message': instance.message,
    };
