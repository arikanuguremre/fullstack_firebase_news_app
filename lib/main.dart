import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstack_firebase_news_app/feature/Auth/login_page.dart';

import 'package:fullstack_firebase_news_app/feature/splash/splash_view.dart';
import 'package:fullstack_firebase_news_app/product/constants/string_constants.dart';
import 'package:fullstack_firebase_news_app/product/initialize/application_start.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      home: SplashView(
        child: LoginPage(),
      ),
    );
  }
}
