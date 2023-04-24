import 'package:flutter/material.dart';
import 'package:travelust_app/screens/plan_screen.dart';
import 'package:travelust_app/utils/theme.dart';

class PlanList extends StatelessWidget {
  const PlanList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      color: MyTheme.highlightColor.withOpacity(0.5),
                    ),
                  ),
                  const Text(
                    "Travel Plans",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "IBMPlex",
                      fontWeight: FontWeight.normal,
                      color: MyTheme.black,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PlanScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(6.0),
                  foregroundColor: MyTheme.highlightColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      width: 1,
                      color: MyTheme.highlightColor,
                    ),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
