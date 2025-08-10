// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_login_in_status_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveLoginStatusParams _$SaveLoginStatusParamsFromJson(
        Map<String, dynamic> json) =>
    SaveLoginStatusParams(
      isLoggedIn: json['isLoggedIn'] as bool,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveLoginStatusParamsToJson(
        SaveLoginStatusParams instance) =>
    <String, dynamic>{
      'isLoggedIn': instance.isLoggedIn,
      'user': instance.user,
    };
