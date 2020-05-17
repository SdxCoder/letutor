import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:letutor/core/constants/constants.dart';
import 'package:letutor/core/utils/colors.dart';
import 'package:meta/meta.dart';

class DateRangePicker extends StatefulWidget {
  //final ValueChanged<dp.DatePeriod> onNewRangeSelected;
  final Function(dp.DatePeriod) onChanged;
  final String flag;

  DateRangePicker({Key key,@required this.onChanged, @required this.flag})
      : super(key: key);

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _flagBasedPicker();
  }

  Widget _flagBasedPicker(){
    if(widget.flag == DatePickerType.date){
      return _buildDayPicker();
    }
    if(widget.flag == DatePickerType.range){
      return _buildRangePicker();
    }

    return _buildWeekPicker();
  }

  Widget _buildDayPicker() {
    return Column(
       mainAxisSize: MainAxisSize.min,
      children: [
        Text("Select Date"),
        dp.DayPicker(
            selectedDate: _selectedDate,
            onChanged: (dateTime) {
              setState(() {
                _selectedDate = dateTime;
              });
              widget.onChanged(dp.DatePeriod(dateTime, dateTime));
            },
            firstDate: _firstDate,
            lastDate: _lastDate),
      ],
    );
  }

  // Widget _buildMonthPicker() {
  //   return dp.MonthPicker(
  //     selectedDate: _selectedDate,
  //     onChanged: (dateTime) {
  //       setState(() {
  //         _selectedDate = dateTime;
  //       });
  //        widget.onChanged(period);
  //     },
  //     firstDate: _firstDate,
  //     lastDate: _lastDate,
  //     datePickerStyles: _datePickerStyles,
  //   );
  // }

  Widget _buildWeekPicker() {
    return Column(
       mainAxisSize: MainAxisSize.min,
       
      children: [
        Text("Select Week"),
        dp.WeekPicker(
            selectedDate: _selectedDate,
            onChanged: (period) {
              _selectWeek(period);
              widget.onChanged(period);
            },
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: _styles),
      ],
    );
  }

  Widget _buildRangePicker() {
    // add some colors to default settings

    return Column(
        mainAxisSize: MainAxisSize.min,
       
      children: [
        Text("Select Date Range"),
        dp.RangePicker(
            selectedPeriod: _selectedPeriod,
            onChanged: (period) {
              selectPeriod(period);
              widget.onChanged(period);
            },
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: _styles),
      ],
    );
  }

  dp.DatePeriod _selectedPeriod;
  DateTime _selectedDate;
  Color _periodStartColor;
  Color _periodLastColor;
  Color _periodMiddleColor;
  DateTime _firstDate;
  DateTime _lastDate;
  dp.DatePickerRangeStyles _styles;
  dp.DatePickerStyles _datePickerStyles;

  void initialize() {
    _selectedDate = DateTime.now().add(Duration(milliseconds: 1));
    _selectedPeriod = dp.DatePeriod(DateTime.now().add(Duration(days: 1)),
        DateTime.now().add(Duration(days: 1)));
    _firstDate = DateTime.now();
    _lastDate = DateTime.now().add(Duration(days: 30));
    _periodStartColor = Colors.blue;
    _periodLastColor = Colors.blue;
    _periodMiddleColor = Colors.blue.withOpacity(0.5);

    _datePickerStyles = dp.DatePickerStyles(
      selectedDateStyle: bodyText2.copyWith(color: Colors.blue),
      selectedSingleDateDecoration: BoxDecoration(
        color: _periodStartColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
    );

    _styles = dp.DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: _periodLastColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: _periodStartColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
      selectedPeriodMiddleDecoration:
          BoxDecoration(color: _periodMiddleColor, shape: BoxShape.rectangle),
    );
  }

  void _selectWeek(dp.DatePeriod period) {
    setState(() {
      _selectedDate = period.start;
      _selectedPeriod = period;
      _periodStartColor = Colors.blue;
      _periodLastColor = Colors.blue;
      _periodMiddleColor = Colors.blue.withOpacity(0.5);
    });
  }

  void selectPeriod(dp.DatePeriod period) {
    setState(() {
      _selectedPeriod = period;
      _periodStartColor = Colors.blue;
      _periodLastColor = Colors.blue;
      _periodMiddleColor = Colors.blue.withOpacity(0.5);
    });
  }
}

Future<String> showCalenderDialogBox(
    {@required String title,
    @required Widget content,
    model,
    String buttonText = "OK",
    String buttonTextCancel = "Close"}) async {
  print("show dialog");
  return await showDialog<String>(
    context: Modular.navigatorKey.currentState.overlay.context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Padding(padding: const EdgeInsets.all(16.0), child: content),
                  SizedBox(height: 16),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(buttonTextCancel,
                              style: TextStyle(color: Colors.blue)),
                          onPressed: () {
                            String result = "false";
                            return Modular.to.pop(result);
                          }),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.blue,
                          elevation: 0,
                          child: Text(buttonText),
                          onPressed: () {
                            return Modular.to.pop("true");
                          }),
                    ],
                  ),
                ]),
          ),
        ),
      );
    },
  );
}
