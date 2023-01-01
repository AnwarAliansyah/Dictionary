import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  String? id;
  String? keyword;
  bool? isFavorite;

  History({
    this.id,
    this.isFavorite,
    this.keyword,
  });

  History.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        keyword = snapshot["keyword"],
        isFavorite = snapshot["is_favorite"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "keyword": keyword,
        "is_favorite": isFavorite,
      };
}
