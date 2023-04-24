import 'package:travelust_app/models/city_model.dart';

class Plan {
  String planName;
  Map<City, List<DateTime>> locations;
  DateTime startDate;
  DateTime endDate;
  // Herhangi bir şehrin son tarihi, planın son tarihinden büyük olamaz.
  // Herhangi bir şehrin ilk tarihi, planın ilk tarihinden küçük olamaz.

  Plan({
    required this.locations,
    required this.planName,
    required this.startDate,
    required this.endDate,
  });
}
