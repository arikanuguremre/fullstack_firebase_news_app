import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:fullstack_firebase_news_app/product/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

class WavyBoldText extends StatelessWidget {
  const WavyBoldText({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        WavyAnimatedText(
          title,
          textStyle: context.textTheme.headlineSmall?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
