// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      uniqueID: json['uniqueID'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      places:
          (json['places'] as List<dynamic>).map((e) => e as String).toList(),
      picture: json['picture'] as String,
      totalPlaces: json['totalPlaces'] as int,
      votedPlaces: (json['votedPlaces'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'uniqueID': instance.uniqueID,
      'email': instance.email,
      'username': instance.username,
      'picture': instance.picture,
      'totalPlaces': instance.totalPlaces,
      'places': instance.places,
      'votedPlaces': instance.votedPlaces,
    };
