import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelust_app/utils/theme.dart';

class IntroScreen extends StatelessWidget {
  final String svgPath;
  final String title;
  final String subtitle;
  final String content;
  const IntroScreen({
    super.key,
    required this.svgPath,
    required this.title,
    required this.subtitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            child: SvgPicture.asset(
              width: MediaQuery.of(context).size.width,
              svgPath,
              fit: BoxFit.scaleDown,
            ),
          ),
          Center(
            child: Column(
              children: [
                HighlightedTitle(title: title),
                Subtitle(subtitle: subtitle),
                Content(content: content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: "IBMPlex",
          fontWeight: FontWeight.w300,
          color: MyTheme.black,
        ),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: "IBMPlex",
          fontWeight: FontWeight.normal,
          color: MyTheme.black,
        ),
      ),
    );
  }
}

class HighlightedTitle extends StatelessWidget {
  const HighlightedTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            height: 7,
            color: MyTheme.highlightColor.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontFamily: "IBMPlex",
              fontWeight: FontWeight.bold,
              color: MyTheme.primaryColorDark,
            ),
          ),
        ),
      ],
    );
  }
}
