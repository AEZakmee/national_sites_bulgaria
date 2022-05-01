import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  String uniqueID;
  String email;
  String username;
  String picture;
  int totalPlaces;
  List<String> places;
  List<String> votedPlaces;

  AppUser({
    required this.uniqueID,
    required this.email,
    required this.username,
    required this.places,
    required this.picture,
    required this.totalPlaces,
    required this.votedPlaces,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
