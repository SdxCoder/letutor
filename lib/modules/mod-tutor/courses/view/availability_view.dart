import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
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
      onModelReady: (model) async {
        await model.fetchLessons();
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: (model.events.isEmpty)
              ? Offstage()
              : FloatingActionButton(
                  child:
                  Icon(Icons.add),
                  onPressed: () async {
                    // String confirm = await showActionDialogBox(
                    //   title: "Reminder",
                    //   description: "Are you sure you want to proceed?"
                    // );
                    // if(confirm == "true"){

                    // }
                    await model.addAvailablity();
                  },
                ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: model.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      TopNavBar(title: [
                        Text("Add your", style: headline6),
                        Text("Availablity",
                            style:
                                headline5.copyWith(fontWeight: FontWeight.bold))
                      ]),
                      SizedBox(height: 20),
                      _buildTimeSlots(model),
                      SizedBox(height: 8),
                      (model.selectedSlots.isEmpty)
                          ? Offstage()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Choose Date",
                                style: bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      SizedBox(height: 8),
                      (model.selectedSlots.isEmpty)
                          ? Offstage()
                          : Container(
                              height: 35,
                              padding: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Text(
                                    "Select Date",
                                    style: bodyText1.copyWith(
                                        color: lightBlackColor),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        String changed =
                                            await showDialog<String>(
                                                context: context,
                                                builder: (context) => CalDialog(
                                                      alreadySelectedDates: model
                                                          .alreadySelectedDates,
                                                      flag: model
                                                          .selectedDatePickerType,
                                                      onChanged: (period) {
                                                        model
                                                            .selectDate(period);
                                                      },
                                                    ));
                                        print(changed);

                                        if (changed == "true") {
                                          model.recordSelectedDatesAndEvents();
                                          print(model
                                              .alreadySelectedDates.length);
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
                      SizedBox(height: 8),
                      (model.events.isNotEmpty)
                          ? Center(
                              child: Text("Swipe to cancel",
                                  style: bodyText1.copyWith(
                                      color: lightBlackColor)),
                            )
                          : Offstage(),
                      SizedBox(height: 8),
                      Expanded(child: _buildEvents(model)),
                      SizedBox(height: 8),
                    ],
                  ),
          )),
    );
  }

  Widget _buildEvents(AvailablityViewModel model) {
    print("events : " + model.events?.length.toString());
    return (model.events.isNotEmpty)
        ? Dismissible(
            key: UniqueKey(),
            onDismissed: (d) {
              model.removeEvents();
            },
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Chosen Dates",
                      style: bodyText1.copyWith(color: lightBlackColor),
                    ),
                  
                    Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 2,
                      spacing: 2,
                      direction: Axis.horizontal,
                      children: model.events.entries
                          .map<Widget>((val) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: CapsuleTile(
                                title: DateTime.parse(val.key).dob,
                                titleColor: Colors.black,
                                cancelIcon: Icon(
                                  Icons.cancel,
                                  size: ScreenUtil().setSp(45),
                                ),
                                onTapCancelIcon: () {
                                  model.removeParticularEvents(val.key);
                                },
                              )))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          )
        : Offstage();
  }

  Widget _buildTimeSlots(AvailablityViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    style: bodyText2.copyWith(color: lightBlackColor),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: lightBlackBorderColor))),
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
              slot: slot,
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
