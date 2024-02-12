import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fullstack_firebase_news_app/product/utility/exceptions/custom_exception.dart';

abstract class IdModel {
  String? get id;
}

abstract class BaseFireBaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  T? fromFireBase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw FireBaseCustomException('$snapshot data is null');
    }
    //fixme
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
