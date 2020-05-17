import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/shared_widgets/top_navbar.dart';
import 'package:letutor/core/utils/colors.dart';
import 'package:letutor/modules/mod-tutor/courses/view_model/availablity_view_model.dart';
import 'package:stacked/stacked.dart';

class AvailablityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AvailablityViewModel>.reactive(
      viewModelBuilder: () => AvailablityViewModel(),
      builder: (context, model, child) => Scaffold(
          body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 8,
          ),
          TopNavBar(
            title: [
              Text(
                "Add your",
                style: headline6,
              ),
              Text(
                "Availablity",
                style: headline5.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 32),
          _buildTimeSlots(model),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Choose Date",
              style: bodyText1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 35,
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Text(
                  "Select Date",
                  style: bodyText1.copyWith(color: lightBlackColor),
                ),
                Spacer(),
                IconButton(
                    onPressed: () async {
                      String changed = await showCalenderDialogBox(
                          content: DateRangePicker(
                         
                            alreadySelectedDates: model.alreadySelectedDates,
                            flag: model.selectedDatePickerType,
                            onChanged: (period) {
                              model.selectDate(period);
                              print(period.start.dob);
                              print(period.end.dob);
                              print("called");
                            },
                          ));
                      if (changed == "true") {
                        model.recordSelectedDates();
                        print(model.alreadySelectedDates.length);
                      } else {
                        print("closed");
                      }
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      size: ScreenUtil().setSp(45),
                      color: lightBlackColor,
                    ))
              ],
            ),
          ),
          SizedBox(height: 16),
         
        ]),
      )),
    );
  }

  

  Widget _buildTimeSlots(AvailablityViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal : 8),
          child: Row(
            children: [
              Text(
                "Choose Available Slots",
                style: bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 100,
                height: 35,
                child: DropdownButtonFormField(
                
                   value: model.selectedDatePickerType,
                   
                   style: bodyText2.copyWith(
                     color:lightBlackColor
                   ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left:8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: lightBlackBorderColor))),
                    items: model.datePickerTypes.map<DropdownMenuItem>((value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value.toString()));
                    }).toList(),
                    onChanged: (val) {
                      model.changePickerType(val);
                    }),
              )
            ],
          ),
        ),
        SizedBox(height: 16),
        GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 3,
          childAspectRatio: 2.1,
          shrinkWrap: true,
          children: model.timeSlots.map<Widget>((slot) {
            return TimeSlotTile(
              title: slot,
              titleColor: lightBlackColor,
              onSelection: (val) {
                model.selectSlot(val);
                print(model.selectedSlots.length);
              },
              onCancelSelection: (val) {
                model.unselectSlot(val);
                print(model.selectedSlots.length);
              },
             
            );
          }).toList(),
        ),
      ],
    );
  }
}
