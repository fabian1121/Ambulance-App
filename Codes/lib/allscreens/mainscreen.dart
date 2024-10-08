import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:se_app/AllWidgets/dividerwidget.dart';


class mainscreen extends StatefulWidget
{

  static const String idscreen = "mainscreen";

  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('MAIN SCREEN'),
      ),

      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: ListView(
          children: [
            //drawer header
            Container(
              height: 165.0,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Image.asset("images/user_icon.png",height: 65.0,width: 65.0,),
                    SizedBox(width: 16.0,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile name", style: TextStyle(fontSize: 16.0,fontFamily: "Brand Bold"),),
                        SizedBox(height: 6.0,),
                        Text("Visit Profile"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            DividerWidget(),

            SizedBox(height: 12.0,),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile",style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About",style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("History",style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings",style: TextStyle(fontSize: 15.0),),
            ),
          ],
        ),

      ),

      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
          ),

          //Hamburger button for Drawer
          //Positioned(
            //top: 45.0,
            //left: 22.0,
            //child: GestureDetector(
              //onTap: ()
              //{
                //scaffoldKey.currentState.openDrawer();
              //},
              //child: Container(
                //decoration: BoxDecoration(
                  //color: Colors.white,
                  //borderRadius: BorderRadius.circular(22.0),
                  //boxShadow:[
                    //BoxShadow(
                      //color: Colors.black,
                      //blurRadius: 6.0,
                      //spreadRadius: 0.5,
                      //offset: Offset(
                        //0.7,
                        //0.7,
                      //),
                    //),
                  //],
                //),
                //child: CircleAvatar(
                  //backgroundColor: Colors.white,
                  //child: Icon(Icons.menu, color: Colors.black,),
                 // radius: 20.0,
               // ),
             // ),
           // ),
          //),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  ),
                ],

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0),
                    Text("Hi there!",style: TextStyle(fontSize: 12.0),),
                    Text("Where to?",style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7,0.7),
                          ),
                        ],

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.blueAccent,),
                            SizedBox(width: 10.0,),
                            Text("Search nearby hospital")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0,),

                    DividerWidget(),


                    SizedBox(height: 16.0,),
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.grey,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text("Add nearest hospital"),
                            SizedBox(height: 4.0,),
                            Text("........",style: TextStyle(color: Colors.grey[200],fontSize: 12.0),),
                          ],
                        )
                      ],
                    ),

                    //SizedBox(height: 24.0,),
                    //Row(
                      //children: [
                        //Icon(Icons.home, color: Colors.grey,),
                        //SizedBox(width: 12.0,),
                        //Column(
                          //crossAxisAlignment:CrossAxisAlignment.start,
                          //children: [
                            //Text("Add nearest hospital"),
                            //SizedBox(height: 4.0,),
                            //Text("........",style: TextStyle(color: Colors.grey[200],fontSize: 12.0),),
                          //],
                        //),
                      //],
                    //), //sized box

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
