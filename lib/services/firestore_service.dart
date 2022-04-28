import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/app_user.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(AppUser user) =>
      _db.collection('users').doc(user.uniqueID).set(user.toMap());

  Future<AppUser> fetchUser(String userId) => _db
      .collection('users')
      .doc(userId)
      .get()
      .then((snapshot) => AppUser.fromJson(snapshot.data()!));

  Stream<AppUser> userStream(String userId) => _db
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((event) => AppUser.fromJson(event.data()!));
}
