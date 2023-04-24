import "package:flutter/material.dart";
import "package:travelust_app/models/city_model.dart";
import "package:travelust_app/screens/city_screen.dart";
import "package:travelust_app/utils/cities.dart";
import "package:travelust_app/utils/theme.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class CityCarousel extends StatelessWidget {
  const CityCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                    "Popular Cities",
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
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(6.0),
                  foregroundColor: MyTheme.highlightColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IBMPlex',
                    color: MyTheme.highlightColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cities.length,
            itemBuilder: (BuildContext context, int index) {
              City city = cities[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CityScreen(city: city),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 210.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 120.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [MyTheme.kBoxShadow26],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  city.description,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'IBMPlex',
                                    color: MyTheme.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [MyTheme.kBoxShadow26],
                        ),
                        child: Stack(
                          children: [
                            Hero(
                              tag: city.images[0],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  height: 180.0,
                                  width: 180.0,
                                  image: AssetImage(city.images[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyTheme.highlightColorDark
                                      .withOpacity(0.6),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5.0,
                                    right: 20.0,
                                    top: 5.0,
                                    bottom: 5.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        city.cityName,
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'IBMPlex',
                                          color: MyTheme.white,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.locationArrow,
                                            size: 10.0,
                                            color: MyTheme.white,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            city.country,
                                            style: const TextStyle(
                                              color: MyTheme.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
