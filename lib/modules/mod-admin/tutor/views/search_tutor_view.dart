import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-admin/tutor/view_models/search_tutor_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/core.dart';

class SearchTutorView extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
   
    return ViewModelBuilder<SearchTutorViewModel>.reactive(
      viewModelBuilder: () => SearchTutorViewModel(),
      onModelReady: ( model) {
        model.getAllUsers();
      },
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
              TopNavBar(),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: SearchBar(
                  onEditingComplete: (){

                  },
                  onChanged: (String value) {
                    model.searchResults(value);
                    print(value);
                  },
                  onSubmit: (String value) {
                    model.searchResults(value);
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

  // Widget _buildTutorsStream(SearchTutorViewModel model){
  //    return StreamBuilder(
  //      stream: model.getAllUsers() ,
       
  //      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){

  //         if(snapshot.hasData){
  //           final users = snapshot.data;
  //           return _buildTutorsList(model, users);
  //         }  
         
  //      },
  //    );
  // }

  Widget _buildTutors(SearchTutorViewModel model) {
    return Container(
      child: (model.tempList.isEmpty) ? 
              Center(child:Text("No users", style: bodyText1,)): 
      ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: model.tempList.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final user = model.tempList.elementAt(index);
            return UpcomingBookingCard(
              avatarImage: user.photoUrl ?? user.photoPlaceholder,
              heroTag: index.toString(),
              title: user.name,
              subtitle: user.email,
              trailing: (user.bookingStatus == "none")
                  ? Offstage() : (user.bookingStatus == "Pending") ? Text(
                      user.bookingStatus,
                      style: bodyText2.copyWith(color: Colors.red),
                    ) : Icon(Icons.check_circle, size: ScreenUtil().setSp(45), color: Colors.blue,),
                 
              onTap: () {
                String id = user.uid;
                Modular.to.pushNamed(Routes.tutorDetails.replaceAll(":id", id), arguments: user);
              },
            );
          }),
    );
  }
}
