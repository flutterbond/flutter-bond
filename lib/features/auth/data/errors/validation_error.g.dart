// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) =>
    ValidationError(
      message: json['message'] as String,
      errors: (json['errors'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{'message': instance.message, 'errors': instance.errors};
