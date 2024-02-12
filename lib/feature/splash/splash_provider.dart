import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstack_firebase_news_app/product/enums/platform_enum.dart';
import 'package:fullstack_firebase_news_app/product/models/version_model.dart';
import 'package:fullstack_firebase_news_app/product/utility/firebase/firebase_collections.dart';
import 'package:fullstack_firebase_news_app/product/utility/version_manager.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(SplashState());

  Future<void> checkApplicationVersion(String clientVersion) async {
    final databaseValue = await getVersionNumberFromDatabase();
    if (databaseValue == null || databaseValue.isEmpty) {
      state = state.copyWith(isRedirectHome: false);
      return;
    }

    final checkIsNeedForceUpdate = VersionManager(
        deviceValue: clientVersion, dataBaseValue: databaseValue);

    if (checkIsNeedForceUpdate.isNeeUpdate()) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }

    state = state.copyWith(isRedirectHome: true);
  }

  Future<String?> getVersionNumberFromDatabase() async {
    if (kIsWeb) {
      return null; // if user coming from web dont check version update.
    }
    final response = await firebaseCollections.version.reference
        .withConverter<Version>(
          fromFirestore: (snapshot, option) => Version().fromFireBase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(PlatformEnum.versionName)
        .get();

    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  SplashState({this.isRequiredForceUpdate, this.isRedirectHome});

  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  @override
  List<Object?> get props => [isRequiredForceUpdate, isRedirectHome];

  SplashState copyWith({
    bool? isRequiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
        isRequiredForceUpdate:
            isRequiredForceUpdate ?? this.isRequiredForceUpdate,
        isRedirectHome: isRedirectHome ?? this.isRedirectHome);
  }
}
