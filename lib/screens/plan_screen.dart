import 'package:flutter/material.dart';
import 'package:travelust_app/models/city_model.dart';
import 'package:travelust_app/utils/theme.dart';
import 'package:travelust_app/widgets/city_list.dart';
import 'package:intl/intl.dart';
import 'package:travelust_app/utils/cities.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Map<City, List<DateTime>> locations = {};
  String planName = "";

  void sortLocationsByStartDate() {
    locations = Map.fromEntries(locations.entries.toList()
      ..sort((e1, e2) => e1.value[0].compareTo(e2.value[0])));
  }

  void _addCity(City city, List<DateTime> dates) {
    setState(() {
      locations[city] = dates;
    });
    sortLocationsByStartDate();
  }

  @override
  Widget build(BuildContext context) {
    bool isAllCitiesAdded = cities.length == locations.length;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.highlightColor,
        onPressed: () {
          if (locations.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please add a city to your plan"),
              ),
            );
          } else {
            // save function here
            // go to home screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Plan saved"),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Plan",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "IBMPlex",
                                fontWeight: FontWeight.normal,
                                color: MyTheme.black,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "Create a new travel plan!",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "IBMPlex",
                            fontWeight: FontWeight.normal,
                            color: MyTheme.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CityList(
                addCity: _addCity,
                locations: locations,
                isAllCitiesAdded: isAllCitiesAdded,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locations.keys.toList()[index].cityName),
                        Column(
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(
                                    locations.values
                                        .toList()[index][0]
                                        .toLocal(),
                                  )
                                  .toString(),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(
                                    locations.values
                                        .toList()[index][1]
                                        .toLocal(),
                                  )
                                  .toString(),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  itemCount: locations.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
