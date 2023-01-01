import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;

final historyRef = fireStore.collection("dictionary");

DocumentReference dictionaryRef(String keyword) {
  return historyRef.doc("history").collection("keyword").doc(keyword);
}
