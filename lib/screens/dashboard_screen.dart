import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travelust_app/screens/onboard_screen.dart';
import 'package:travelust_app/utils/theme.dart';
import 'package:travelust_app/widgets/city_carousel.dart';
import 'package:travelust_app/widgets/note_list.dart';
import 'package:travelust_app/widgets/plan_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.explore,
    Icons.edit_calendar_rounded,
    Icons.notes,
  ];

  final List<String> _labels = [
    "Explore",
    "Plan",
    "Notes",
  ];

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? MyTheme.highlightColor.withOpacity(0.25)
              : MyTheme.grey,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icons[index],
              size: 25.0,
              color: _selectedIndex == index
                  ? MyTheme.highlightColorDark
                  : MyTheme.darkGrey,
            ),
            Text(
              _labels[index],
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'IBMPlex',
                color: _selectedIndex == index
                    ? MyTheme.highlightColorDark
                    : MyTheme.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');
    bool firstTimeState = box.get('introduction') ?? true;
    return firstTimeState
        ? const OnBoardScreen()
        : Scaffold(
            appBar: buildAppBar(),
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "What would you like to explore today?",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IBMPlex',
                        color: MyTheme.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _icons
                        .asMap()
                        .entries
                        .map((MapEntry map) => _buildIcon(map.key))
                        .toList(),
                  ),
                  const SizedBox(height: 20.0),
                  buildMenuContent(_selectedIndex),
                ],
              ),
            ),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu, color: MyTheme.highlightColor),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person, color: MyTheme.highlightColor),
        ),
      ],
    );
  }

  Widget buildMenuContent(int selectedIndex) {
    if (selectedIndex == 0) {
      return const CityCarousel();
    } else if (selectedIndex == 1) {
      return const PlanList();
    } else {
      return const NoteList();
    }
  }
}
