import 'package:flutter/material.dart';
import 'package:travelust_app/utils/cities.dart';
import 'package:travelust_app/utils/theme.dart';
import 'package:travelust_app/models/city_model.dart';
import 'package:travelust_app/widgets/date_picker.dart';

class CityList extends StatelessWidget {
  final Map<City, List<DateTime>> locations;
  // addCity function
  final Function addCity;
  final bool isAllCitiesAdded;
  const CityList({
    required this.isAllCitiesAdded,
    required this.addCity,
    required this.locations,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isAllCitiesAdded) {
      return const SizedBox();
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Start with adding a city to your plan...",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "IBMPlex",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200,
                  color: MyTheme.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: cities.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final City city = cities[index];
              bool isAdded = locations.containsKey(city);
              if (!isAdded) {
                return Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [MyTheme.kBoxShadow45],
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Hero(
                            tag: city.images[0],
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                city.images[0],
                                height: 100,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 10,
                            child: Text(
                              city.cityName,
                              style: const TextStyle(
                                fontSize: 32,
                                fontFamily: "IBMPlex",
                                fontWeight: FontWeight.bold,
                                color: MyTheme.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 20.0,
                                    color: MyTheme.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Image widget'ının üzerine yarı saydam overlay ekle
                          Opacity(
                            opacity: isAdded ? 0.8 : 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                color: MyTheme.black,
                              ),
                              height: 50,
                              width: 300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: isAdded
                          ? null
                          : () {
                              // open date time picker
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DatePicker(
                                    addCity: addCity,
                                    locations: locations,
                                    city: city,
                                  ),
                                ),
                              );
                            },
                      splashRadius: 20,
                      icon: Icon(
                        Icons.add,
                        color: isAdded ? MyTheme.grey : MyTheme.highlightColor,
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
