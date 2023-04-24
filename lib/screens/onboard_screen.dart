import 'package:flutter/material.dart';
import 'package:travelust_app/screens/dashboard_screen.dart';
import 'package:travelust_app/utils/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelust_app/screens/intro_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final box = Hive.box('');
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        onLastPage = (index == 2);
                      });
                    },
                    // TODO simplify the code below
                    children: const [
                      IntroScreen(
                        svgPath: "assets/images/onboard/intro_explore.svg",
                        title: "Explore",
                        subtitle: "Discover all the cities around the world!",
                        content:
                            "Embark on a journey of exploration as you discover the most fascinating cities from every corner of the world. Learn about their unique architecture, vibrant culture, and rich history in a way you never have before.",
                      ),
                      IntroScreen(
                        svgPath: "assets/images/onboard/intro_plan.svg",
                        title: "Plan",
                        subtitle: "A tool to plan your trips!",
                        content:
                            "Create unforgettable memories with our comprehensive trip planning tools. Map out your itinerary, track your expenses, and get insider tips on the best attractions to visit - all at your fingertips.",
                      ),
                      IntroScreen(
                        svgPath: "assets/images/onboard/intro_notes.svg",
                        title: "Notes",
                        subtitle: "Take notes on things you want to remember!",
                        content:
                            "Keep track of all the places you've been and the things you've seen with ease. Jot down your favorite restaurants, landmarks, and more, and access them later with just a few taps. Your personal travel guide is just a note away!",
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    width: MediaQuery.of(context).size.width,
                    alignment: const Alignment(0, 0.80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // skip button
                        GestureDetector(
                          onTap: () {
                            _controller.page!.toInt() == 2
                                ? null
                                : _controller.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInCirc,
                                  );
                          },
                          child: const IntroButton(text: "SKIP", isSkip: true),
                        ),

                        // indicator
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: const SwapEffect(
                            dotColor: MyTheme.primaryColor,
                            activeDotColor: MyTheme.primaryColorDark,
                            dotHeight: 12,
                            dotWidth: 12,
                            strokeWidth: 2,
                          ),
                        ),

                        // next or done button
                        onLastPage
                            ? GestureDetector(
                                onTap: () {
                                  if (_controller.page!.toInt() == 2) {
                                    box.put('introduction', false);
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const Dashboard(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                              opacity: animation, child: child);
                                        },
                                      ),
                                    );
                                  }
                                  _controller.animateToPage(
                                    (_controller.page!.toInt() + 1),
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const IntroButton(
                                    text: "DONE", isSkip: false),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (_controller.page!.toInt() == 2) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Dashboard(),
                                      ),
                                    );
                                  }
                                  _controller.animateToPage(
                                    (_controller.page!.toInt() + 1),
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const IntroButton(
                                    text: "NEXT", isSkip: false),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroButton extends StatelessWidget {
  final String text;
  final bool isSkip;
  const IntroButton({
    super.key,
    required this.text,
    required this.isSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: isSkip ? Border.all(color: MyTheme.primaryColorDark) : null,
        gradient: isSkip
            ? null
            : const RadialGradient(
                radius: 5,
                center: Alignment(-1, -2),
                colors: [MyTheme.primaryColorDark, MyTheme.primaryColor],
              ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSkip ? MyTheme.primaryColorDark : Colors.white,
            fontSize: 18,
            fontFamily: "IBMPlex",
            fontWeight: FontWeight.normal,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
