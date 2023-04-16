import 'dart:convert';
import 'dart:developer';
import 'package:equalizer_example/bottmNavBar.dart';
import 'package:equalizer_example/pages/model/deviceListingModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../TabPages/homePage.dart';
import '../helpers/constant.dart';
import '../helpers/stringConstant.dart';

class DeviceListingPage extends StatefulWidget {
  const DeviceListingPage({Key key}) : super(key: key);

  @override
  State<DeviceListingPage> createState() => _DeviceListingPageState();
}

class _DeviceListingPageState extends State<DeviceListingPage> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();

  }
  String imageUrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Row(
          children:  [
            Text(
              "Select your Device",
              style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // controller: controller,
        child: Column(

          children: [

            ListView(
              // controller: controller,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: [
                FutureBuilder<List<Results>>(
                    future: getdeviceListings(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return deviceListingsCard(snapshot.data);
                          }
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  deviceListingsCard(List<Results> data) {
    return data != null
        ? ListView.builder(
        // controller: controller,
        shrinkWrap: true,
        itemCount: data.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          imageUrl = data[index].image;
          return GestureDetector(
            onTap: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("guid", data[index].guid);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabPage()));

            },
            child: Card(
              margin: kMarginPaddSmall,
              color: Colors.white,
              elevation: kCardElevation,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Container(
                padding: kMarginPaddSmall,
                child: Column(
                  children: [

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 70.0,
                            backgroundColor: Colors.transparent,
                          // backgroundColor: Colors.brown.shade800,
                          child:  ClipOval(child: Image.network(imageUrl))
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 200,
                          child: Text(
                            "${data[index].title}",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),

                      ],
                    ),
                    kHeightSmall,

                  ],
                ),
              ),
            ),
          );
        })
        : Center(
      child: Text(
        "No Data available",
        style: kTextStyleBlack,
      ),
    );
  }

  Future<List<Results>> getdeviceListings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('${StringConst.protocol}${StringConst.baseUrl}${StringConst.deviceListings}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        });


    if (response.statusCode == 401) {
    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {

        return DeviceListings.fromJson(jsonDecode(response.body.toString())).results;
      } else {

      }
    }
   
    return null;
  }
}
