import 'package:cloud_firestore/cloud_firestore.dart';

enum firebaseCollections {
  version;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
