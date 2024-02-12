import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstack_firebase_news_app/feature/home/home_view.dart';
import 'package:fullstack_firebase_news_app/feature/splash/splash_provider.dart';
import 'package:fullstack_firebase_news_app/product/constants/color_constants.dart';
import 'package:fullstack_firebase_news_app/product/constants/string_constants.dart';
import 'package:fullstack_firebase_news_app/product/enums/image_constants.dart';
import 'package:fullstack_firebase_news_app/product/widget/text/wavy_text.dart';
import 'package:kartal/kartal.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });

  @override
  void initState() {
    super.initState();
    sleep(Duration(seconds: 3));
    ref.read(splashProvider.notifier).checkApplicationVersion(''.version);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      splashProvider,
      (previous, next) {
        if (next.isRequiredForceUpdate ?? false) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Update Required !'),
                content: Text(
                    'Your App version is old, please update new version from Google play or App Store'),
              );
            },
          );
          return;
        }

        if (next.isRedirectHome != null) {
          if (next.isRedirectHome!) {
            context.navigateToPage(const HomeView());
          } else {
            //else
          }
        }
      },
    );
    return Scaffold(
      backgroundColor: ColorConstants.purplePrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.appIcon.toImage,
            Padding(
              padding: context.onlyTopPaddingMedium,
              child: const WavyBoldText(title: StringConstants.appName),
            ),
          ],
        ),
      ),
    );
  }
}
