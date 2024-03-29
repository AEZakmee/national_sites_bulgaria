import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser {
  bool admin;
  String uniqueID;
  String email;
  String username;
  String? picture;
  List<String> favouriteSites;
  List<SiteVote> votes;
  DateTime joined;

  AppUser({
    required this.uniqueID,
    required this.email,
    required this.username,
    required this.favouriteSites,
    required this.votes,
    required this.joined,
    this.admin = false,
    this.picture,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}

@JsonSerializable()
class SiteVote {
  String siteId;
  int vote;

  SiteVote(this.siteId, this.vote);

  factory SiteVote.fromJson(Map<String, dynamic> json) =>
      _$SiteVoteFromJson(json);
  Map<String, dynamic> toJson() => _$SiteVoteToJson(this);
}
