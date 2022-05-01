// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      uniqueID: json['uniqueID'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      favouriteSites: (json['favouriteSites'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      votes: (json['votes'] as List<dynamic>)
          .map((e) => SiteVote.fromJson(e as Map<String, dynamic>))
          .toList(),
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'uniqueID': instance.uniqueID,
      'email': instance.email,
      'username': instance.username,
      'picture': instance.picture,
      'favouriteSites': instance.favouriteSites,
      'votes': instance.votes,
    };

SiteVote _$SiteVoteFromJson(Map<String, dynamic> json) => SiteVote(
      json['siteId'] as String,
      json['vote'] as int,
    );

Map<String, dynamic> _$SiteVoteToJson(SiteVote instance) => <String, dynamic>{
      'siteId': instance.siteId,
      'vote': instance.vote,
    };
