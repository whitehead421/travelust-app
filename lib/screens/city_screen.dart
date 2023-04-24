import 'package:flutter/material.dart';
import 'package:travelust_app/models/city_model.dart';
import 'package:travelust_app/utils/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CityScreen extends StatefulWidget {
  final City city;
  const CityScreen({super.key, required this.city});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  var selectedImageIndex = 0;

  List<int> getSubImageList(int index) {
    if (index == 0) {
      return [1, 2];
    } else if (index == 1) {
      return [2, 0];
    } else {
      return [0, 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: const [MyTheme.kBoxShadow26],
                ),
                child: Hero(
                  tag: widget.city.images[0],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: AssetImage(widget.city.images[selectedImageIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: MyTheme.highlightColor.withOpacity(0.5),
                      ),
                      child: IconButton(
                          icon: const Icon(FontAwesomeIcons.arrowLeft),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: MyTheme.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: MyTheme.highlightColor.withOpacity(0.5),
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {},
                          color: MyTheme.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: MyTheme.highlightColorDark.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 20.0,
                      top: 5.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.city.cityName,
                          style: const TextStyle(
                            fontSize: 35.0,
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
                              size: 15.0,
                              color: MyTheme.white,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              widget.city.country,
                              style: const TextStyle(
                                color: MyTheme.white,
                                fontSize: 20.0,
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
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.city.images.length - 1,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                List<int> subImageList = getSubImageList(selectedImageIndex);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImageIndex =
                          getSubImageList(selectedImageIndex)[index];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 150,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: AssetImage(
                              widget.city.images[subImageList[index]]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
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
                      "History",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "IBMPlex",
                        fontWeight: FontWeight.normal,
                        color: MyTheme.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SelectableText(
                      widget.city.history,
                      textAlign: TextAlign.justify,
                      cursorColor: MyTheme.highlightColor,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'IBMPlex',
                        color: MyTheme.black,
                        height: 1.5,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
