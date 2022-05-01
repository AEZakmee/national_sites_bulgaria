import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/app_user.dart';
import '../data/models/site.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //user fetching
  Future<void> addUser(AppUser user) =>
      _db.collection('users').doc(user.uniqueID).set(user.toJson());

  Future<AppUser> fetchUser(String userId) => _db
      .collection('users')
      .doc(userId)
      .get()
      .then((snapshot) => AppUser.fromJson(snapshot.data()!));

  Stream<AppUser> userStream(String? userId) => _db
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((event) => AppUser.fromJson(event.data()!));

  //Sites fetching
  Stream<List<Site>> sitesStream() => _db
      .collection('sites')
      .snapshots()
      .map((query) => query.docs)
      .map((doc) => doc.map((e) => Site.fromJson(e.data())).toList());

  Future<List<Site>> fetchSites() async {
    final docs = await _db.collection('sites').get();
    return docs.docs.map((e) => Site.fromJson(e.data())).toList();
  }

  Future<Site> fetchSite(String number) => _db
      .collection('sites')
      .where('siteNumber', isEqualTo: number)
      .get()
      .then((snapshot) => Site.fromJson(snapshot.docs[0].data()));
}
