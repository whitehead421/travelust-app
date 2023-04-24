import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelust_app/models/city_model.dart';
import 'package:travelust_app/utils/theme.dart';

class DatePicker extends StatefulWidget {
  Map<City, List<DateTime>> locations;
  final Function addCity;
  final City city;
  DatePicker({
    super.key,
    required this.locations,
    required this.addCity,
    required this.city,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    final DateRangePickerController _controller = DateRangePickerController();

    bool predicateCallback(DateTime date) {
      if (widget.locations.isEmpty) {
        return true;
      }
      for (List<DateTime> dates in widget.locations.values) {
        if (date.isAfter(dates[0]) && date.isBefore(dates[1])) {
          return false;
        } else if (date.isAtSameMomentAs(dates[0]) ||
            date.isAtSameMomentAs(dates[1])) {
          return false;
        }
      }
      return true;
    }

    void selectionChanged(DateRangePickerSelectionChangedArgs args) {
      if (args.value is PickerDateRange) {
        final PickerDateRange range = args.value as PickerDateRange;
        DateTime? startDate = range.startDate;
        DateTime? endDate = range.endDate;
        debugPrint("Start date: $startDate");
        debugPrint("End date: $endDate");
        if (startDate != null && endDate != null) {
          for (int i = 0; i <= startDate.difference(endDate).inDays; i++) {
            DateTime date = startDate.add(Duration(days: i));
            debugPrint("Date: $date");
            if (!predicateCallback(date)) {
              debugPrint("Date $date is not available");
              _controller.selectedRange = const PickerDateRange(null, null);
              break;
            }
          }
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Hero(
                tag: widget.city.images[0],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage(widget.city.images[0]),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: SfDateRangePicker(
                  controller: _controller,
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    disabledDatesTextStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 13,
                        fontFamily: 'Roboto'),
                  ),
                  selectableDayPredicate: predicateCallback,
                  onSelectionChanged: selectionChanged,
                  rangeSelectionColor: MyTheme.highlightColor.withOpacity(0.1),
                  startRangeSelectionColor: MyTheme.highlightColor,
                  endRangeSelectionColor: MyTheme.highlightColor,
                  todayHighlightColor: MyTheme.highlightColor,
                  selectionColor: MyTheme.highlightColor,
                  rangeTextStyle: const TextStyle(
                    color: MyTheme.highlightColorDark,
                  ),
                  minDate: DateTime.now(),
                  headerHeight: 100,
                  headerStyle: const DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: "IBMPlex",
                      fontWeight: FontWeight.normal,
                      color: MyTheme.highlightColor,
                    ),
                  ),
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onSubmit: (Object? val) {
                    PickerDateRange? range = val as PickerDateRange?;
                    if (range != null) {
                      List<DateTime> dates = [];
                      dates.add(range.startDate!);
                      dates.add(range.endDate!);
                      widget.addCity(widget.city, dates);
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
