import 'package:json_annotation/json_annotation.dart';

part 'site.g.dart';

@JsonSerializable()
class Site {
  Coordinates coordinates;
  Image image;
  Info info;
  Rating rating;
  String siteNumber;

  Site(
    this.coordinates,
    this.image,
    this.info,
    this.rating,
    this.siteNumber,
  );

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);
  Map<String, dynamic> toJson() => _$SiteToJson(this);
}

@JsonSerializable()
class Coordinates {
  double lat;
  double lng;

  Coordinates(
    this.lat,
    this.lng,
  );

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

@JsonSerializable()
class Image {
  String hash;
  String url;

  Image(
    this.hash,
    this.url,
  );

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Info {
  String description;
  String name;
  String town;

  Info(
    this.description,
    this.name,
    this.town,
  );

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Rating {
  double count;
  double total;

  Rating(
    this.count,
    this.total,
  );

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
