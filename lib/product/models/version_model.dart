import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fullstack_firebase_news_app/product/utility/base/base_firebase_model.dart';
import 'package:fullstack_firebase_news_app/product/utility/exceptions/custom_exception.dart';

class Version extends Equatable implements IdModel, BaseFireBaseModel<Version> {
  final String? number;

  Version({
    this.number,
  });

  Version copyWith({
    String? number,
  }) {
    return Version(
      number: number ?? this.number,
    );
  }

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      number: json['number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  @override
  Version fromJson(Map<String, dynamic> json) {
    return Version(
      number: json['number'] as String?,
    );
  }

  @override
  Version fromFireBase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw FireBaseCustomException('$snapshot data is null');
    }
    //fixme
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }

  @override
  // TODO: implement id
  String? get id => '';

  @override
  List<Object?> get props => [number];
}
