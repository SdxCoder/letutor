import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/userprofile/view_model/user_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      builder: (context, UserProfileViewModel model, child) => Scaffold(
        backgroundColor: Colors.blue,
        bottomNavigationBar: Container(height: 0.0),
        appBar: AppBar(
          elevation: 0.0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 7.0),
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: NetworkImage(
                        model.currentUser.user.photoUrl ??
                            model.currentUser.user.photoPlaceholder),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.currentUser.user.name.toUpperCase(),
                        style: headline5.copyWith(color:Colors.white),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 8.0),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Icon(Icons.location_on,
                      //           color: Colors.white, size: 17),
                      //       Padding(
                      //         padding: const EdgeInsets.only(left: 5.0),
                      //         child: Text(
                      //           "San Pedro Sula, HN",
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Profile",
                        style: subtitle1.copyWith(
                          fontWeight:FontWeight.w600
                        ),
                      ),
                    ),
                    InfoSection(
                      icon: Icons.email,
                      title: "Email",
                      value: Text(model.currentUser.user.email, style: bodyText1),
                    ),
                    (model.currentUser.user.phoneNo.isNotEmpty)
                        ? InfoSection(
                            icon: Icons.email,
                            title: "Phone No",
                            value: Text( model.currentUser.user.phoneNo, style: bodyText1,),
                          )
                        : Offstage(),
                    raisedButton(
                      btnText: "Logout",
                      onPressed: () async {
                        await model.signOut();
                        Modular.to.pushNamed('/');
                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffEFEFEF),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(34),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
