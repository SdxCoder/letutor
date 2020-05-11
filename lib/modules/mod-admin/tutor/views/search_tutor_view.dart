import 'package:flutter/material.dart';
import 'package:letutor/modules/mod-admin/tutor/view_models/search_tutor_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/core.dart';

class SearchTutorView extends StatelessWidget {
  final _searchController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    // _searchController.addListener(() {
      
    // });
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SearchTutorViewModel(),
      builder: (context,SearchTutorViewModel model, child)=>
          Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              FindTutorTopNavBar(
                actions: <Widget>[],
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: SearchBar(
                  controller: TextEditingController(),
                  onChanged: (String value) {
                    model.searchResults(value);
                    print(value);
                  },
                  onSubmit: (String value) {
                    print(value);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(child: _buildTutors(model))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutors(SearchTutorViewModel model) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: model.tempList.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return UpcomingBookingCard(
            heroTag: index.toString(),
            title: "Tutor Luis",
            subtitle: model.tempList.elementAt(index),
            trailing: (index.isEven)
                ? Text(
                    "Pending",
                    style: bodyText2.copyWith(color: Colors.red),
                  )
                : Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  ),
            onTap: () {},
          );
        });
  }
}
