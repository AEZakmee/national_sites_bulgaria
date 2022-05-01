// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Site _$SiteFromJson(Map<String, dynamic> json) => Site(
      Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      Image.fromJson(json['image'] as Map<String, dynamic>),
      Info.fromJson(json['info'] as Map<String, dynamic>),
      Rating.fromJson(json['rating'] as Map<String, dynamic>),
      json['siteNumber'] as String,
    );

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'coordinates': instance.coordinates,
      'image': instance.image,
      'info': instance.info,
      'rating': instance.rating,
      'siteNumber': instance.siteNumber,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      json['hash'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'hash': instance.hash,
      'url': instance.url,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      json['description'] as String,
      json['name'] as String,
      json['town'] as String,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'description': instance.description,
      'name': instance.name,
      'town': instance.town,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      (json['count'] as num).toDouble(),
      (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
    };
