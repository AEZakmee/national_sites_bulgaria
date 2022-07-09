import 'package:cloud_firestore/cloud_firestore.dart';

DocumentReference<Map<String, dynamic>> firebaseDocRefFromJson(dynamic value) {
  if (value is DocumentReference) {
    return FirebaseFirestore.instance.doc(value.path);
  }
  return FirebaseFirestore.instance.doc(value);
}

String firebaseDocRefToJson(DocumentReference<Map<String, dynamic>> ref) =>
    ref.path;
