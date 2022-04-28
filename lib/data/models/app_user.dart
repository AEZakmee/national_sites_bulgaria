class AppUser {
  String uniqueID;
  String email;
  String username;
  String picture;
  int totalPlaces;
  List<int> places;
  List<int> votedPlaces;

  AppUser({
    required this.uniqueID,
    required this.email,
    required this.username,
    required this.places,
    required this.picture,
    required this.totalPlaces,
    required this.votedPlaces,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uniqueID: json['uniqueID'],
        email: json['email'],
        username: json['username'],
        picture: json['picture'],
        totalPlaces: json['totalPlaces'],
        places: List.from(json['places']),
        votedPlaces: List.from(json['votedPlaces']),
      );

  Map<String, dynamic> toMap() => {
        'uniqueID': uniqueID,
        'username': username,
        'email': email,
        'picture': picture,
        'totalPlaces': totalPlaces,
        'places': places,
        'votedPlaces': votedPlaces
      };
}
