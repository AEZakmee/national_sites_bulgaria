import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/models/app_user.dart';
import '../data/models/chat_room.dart';
import '../data/models/message.dart';
import '../data/models/site.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  //user fetching
  Future<void> addUser(AppUser user) =>
      _db.collection('users').doc(user.uniqueID).set(user.toJson());

  Future<AppUser> fetchUser() => _db
      .collection('users')
      .doc(_userId)
      .get()
      .then((snapshot) => AppUser.fromJson(snapshot.data()!));

  Stream<AppUser> userStream() => _db
      .collection('users')
      .doc(_userId)
      .snapshots()
      .map((event) => AppUser.fromJson(event.data()!));

  Future<void> updateUserVotes(List<SiteVote> votes) async {
    await _db.collection('users').doc(_userId).update({'votes': votes});
  }

  Future<void> updateUserFavourites(List<String> favorites) async {
    await _db
        .collection('users')
        .doc(_userId)
        .update({'favouriteSites': favorites});
  }

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

  Future<Site> fetchSite(String uid) => _db
      .collection('sites')
      .doc(uid)
      .get()
      .then((snapshot) => Site.fromJson(snapshot.data()!));

  Future<void> voteForSite(String uid, int rating) async {
    await _db.runTransaction((transaction) async {
      final siteSnapshot = await transaction.get(
        _db.collection('sites').doc(uid),
      );

      final userSnapshot = await transaction.get(
        _db.collection('users').doc(_userId),
      );

      final freshSite = Site.fromJson(siteSnapshot.data()!);
      final freshUser = AppUser.fromJson(userSnapshot.data()!);

      final vote = freshUser.votes.where((element) => element.siteId == uid);
      final bool userAlreadyVoted = vote.isNotEmpty;
      final int currentUserVote = userAlreadyVoted ? vote.first.vote : 0;

      if (!userAlreadyVoted) {
        freshSite.rating.count++;
      }

      freshSite.rating.total -= currentUserVote;
      freshSite.rating.total += rating;
      transaction.update(siteSnapshot.reference, freshSite.toJson());

      if (userAlreadyVoted) {
        freshUser.votes.removeWhere((element) => element.siteId == uid);
      }
      freshUser.votes.add(SiteVote(uid, rating));
      transaction.update(userSnapshot.reference, freshUser.toJson());
    });
  }

  //Messages
  Future<bool> checkRoomExists(String siteId) =>
      _db.collection('rooms').doc(siteId).get().then((value) => value.exists);

  Future<void> createRoom(ChatRoom room) =>
      _db.collection('rooms').doc(room.siteId).set(room.toJson());

  Future<ChatRoom> fetchRoom(String siteId) => _db
      .collection('rooms')
      .doc(siteId)
      .get()
      .then((value) => ChatRoom.fromJson(value.data()!));

  Future<void> sendMessage(ChatMessage message, String siteId) async {
    await _db
        .collection('rooms')
        .doc(siteId)
        .collection('messages')
        .doc('${message.sendTime.millisecondsSinceEpoch}')
        .set(message.toJson());

    await _db.collection('rooms').doc(siteId).update({
      'lastMessage': message.message,
      'lastMessageTime': message.sendTime.toString(),
    });
  }

  Stream<List<ChatRoom>> roomsStream() => _db
      .collection('rooms')
      .snapshots()
      .map((query) => query.docs)
      .map((doc) => doc.map((e) => ChatRoom.fromJson(e.data())).toList());

  Stream<List<ChatMessage>> messagesStream(String siteId) => _db
      .collection('rooms')
      .doc(siteId)
      .collection('messages')
      .snapshots()
      .map((query) => query.docs)
      .map((doc) => doc.map((e) => ChatMessage.fromJson(e.data())).toList());
}
