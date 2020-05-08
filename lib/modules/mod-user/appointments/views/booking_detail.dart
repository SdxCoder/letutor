import 'package:flutter/material.dart';
import 'package:letutor/core/constants/constants.dart';

class BookingDetailView extends StatelessWidget {
  final String heroTag;

  BookingDetailView({this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: _buildAppBar(context),
      bottomNavigationBar: Container(height: 0.0),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Positioned(top: 0, child: _buildSplash(context)),
          Positioned(
            top: 220.0,
            left: (MediaQuery.of(context).size.width / 2) - 150.0,
            child: Hero(
              tag: heroTag,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 6.0, color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  ),
                  height: 110.0,
                  width: 110.0),
            ),
          ),
          Positioned(
            top: 350,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Diego',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Gallegos',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('Tutoring topics',
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Container _buildSplash(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(120.0),
        ),
        color: Colors.blue,
      ),
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "12 Jan 2020, \n 8am - 10am",
            style: TextStyle(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.blue,
      leading: IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
        ),
      ),
      title: Text(
        'Appointment Request',
        style: TextStyle(
          fontFamily: 'Monserrat',
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
          color: Colors.white,
        ),
      ],
    );
  }
}
