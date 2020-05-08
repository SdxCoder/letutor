import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomIcons {
  static const IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
  static const IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
  static const IconData googlePlus =
      IconData(0xe902, fontFamily: "CustomIcons");
  static const IconData linkedin = IconData(0xe800, fontFamily: "CustomIcons");
}

class AuthView extends StatelessWidget {
  final Widget formCard;
  final Widget authButton;
  final Widget navigatorButton;
  final model;

  const AuthView(
      {Key key,
      this.formCard,
      this.authButton,
      this.navigatorButton,
      this.model})
      : super(key: key);

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize:MainAxisSize.min ,
              children: <Widget>[
                Container(
                  height: sizingInfo.screenSize.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Image.asset("assets/image_01.png"),
                          ),
                          Spacer(),
                          Image.asset("assets/image_02.png")
                        ],
                      ),

                    

                      Padding(
                        padding: EdgeInsets.only(
                            left: 28.0, right: 28.0, top: 55.0, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/logo.png",
                                  width: ScreenUtil().setWidth(110),
                                  height: ScreenUtil().setHeight(110),
                                ),
                                Text("LOGO",
                                    style: TextStyle(
                                        fontFamily: "Poppins-Bold",
                                        fontSize: ScreenUtil().setSp(46),
                                        letterSpacing: .6,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            //  SizedBox(
                            //   height: sizingInfo.screenSize.height*0.01,
                            // ),

                            Spacer(),
                            this.formCard,
                            SizedBox(height: ScreenUtil().setHeight(40)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                  ],
                                ),
                                authButton,
                              ],
                            ),
                            Spacer(),
                            // SizedBox(
                            //   height: ScreenUtil().setHeight(40),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                horizontalLine(),
                                Text("Social Login",
                                    style: TextStyle(
                                        fontSize: 16.0, fontFamily: "Poppins-Medium")),
                                horizontalLine()
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(40),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SocialIcon(
                                  colors: [
                                    Color(0xFF102397),
                                    Color(0xFF187adf),
                                    Color(0xFF00eaf8),
                                  ],
                                  iconData: CustomIcons.facebook,
                                  onPressed: () async {
                                    await model.signInWithFacebook();
                                  },
                                ),
                                SocialIcon(
                                  colors: [
                                    Color(0xFFff4f38),
                                    Color(0xFFff355d),
                                  ],
                                  iconData: CustomIcons.googlePlus,
                                  onPressed: () async {
                                    await model.signInWithGoogle();
                                  },
                                ),
                                // SocialIcon(
                                //   colors: [
                                //     Color(0xFF00c6fb),
                                //     Color(0xFF005bea),
                                //   ],
                                //   iconData: Icons.apple,
                                //   onPressed: () {},
                                // )
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            navigatorButton,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   ScreenUtil.init(context, allowFontScaling: true);
  //   return ResponsiveBuilder(
  //     builder: (context, sizingInfo) => new Scaffold(
  //       backgroundColor: Colors.white,
  //       resizeToAvoidBottomPadding: true,
  //       body: Scaffold(
  //         body: Stack(
  //           fit: StackFit.expand,
  //           children: <Widget>[
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: <Widget>[
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 20.0),
  //                   child: Image.asset("assets/image_01.png"),
  //                 ),
  //                 Spacer(),
  //                 Image.asset("assets/image_02.png")
  //               ],
  //             ),

  //             Padding(
  //               padding: EdgeInsets.only(
  //                   left: 28.0, right: 28.0, top: 55.0, bottom: 16),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Row(
  //                     children: <Widget>[
  //                       Image.asset(
  //                         "assets/logo.png",
  //                         width: ScreenUtil().setWidth(110),
  //                         height: ScreenUtil().setHeight(110),
  //                       ),
  //                       Text("LOGO",
  //                           style: TextStyle(
  //                               fontFamily: "Poppins-Bold",
  //                               fontSize: ScreenUtil().setSp(46),
  //                               letterSpacing: .6,
  //                               fontWeight: FontWeight.bold))
  //                     ],
  //                   ),
  //                   //  SizedBox(
  //                   //   height: sizingInfo.screenSize.height*0.01,
  //                   // ),

  //                   Spacer(),
  //                   this.formCard,
  //                   SizedBox(height: ScreenUtil().setHeight(40)),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       Row(
  //                         children: <Widget>[
  //                           SizedBox(
  //                             width: 12.0,
  //                           ),
  //                           SizedBox(
  //                             width: 8.0,
  //                           ),
  //                         ],
  //                       ),
  //                       authButton,
  //                     ],
  //                   ),
  //                   Spacer(),
  //                   // SizedBox(
  //                   //   height: ScreenUtil().setHeight(40),
  //                   // ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       horizontalLine(),
  //                       Text("Social Login",
  //                           style: TextStyle(
  //                               fontSize: 16.0, fontFamily: "Poppins-Medium")),
  //                       horizontalLine()
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: ScreenUtil().setHeight(40),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       SocialIcon(
  //                         colors: [
  //                           Color(0xFF102397),
  //                           Color(0xFF187adf),
  //                           Color(0xFF00eaf8),
  //                         ],
  //                         iconData: CustomIcons.facebook,
  //                         onPressed: () async {
  //                           await model.signInWithFacebook();
  //                         },
  //                       ),
  //                       SocialIcon(
  //                         colors: [
  //                           Color(0xFFff4f38),
  //                           Color(0xFFff355d),
  //                         ],
  //                         iconData: CustomIcons.googlePlus,
  //                         onPressed: () async {
  //                           await model.signInWithGoogle();
  //                         },
  //                       ),
  //                       // SocialIcon(
  //                       //   colors: [
  //                       //     Color(0xFF00c6fb),
  //                       //     Color(0xFF005bea),
  //                       //   ],
  //                       //   iconData: Icons.apple,
  //                       //   onPressed: () {},
  //                       // )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: ScreenUtil().setHeight(30),
  //                   ),
  //                   navigatorButton,
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
