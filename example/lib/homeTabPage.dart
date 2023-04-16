import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equalizer/equalizer.dart';
import 'package:equalizer_example/homePage.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class HomeTabPage extends StatefulWidget {
  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}
class _HomeTabPageState extends State<HomeTabPage> {


  @override
  void initState() {
    super.initState();
    Equalizer.init(0);
  }

  @override
  void dispose() {
    Equalizer.release();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black87,
      appBar:AppBar(


        title: Row(
          children:  [

            Text(
              "GRAVITY",
              style: TextStyle(color: Colors.red, fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage("https://gravitybackend.logindesigns.com/Bannerqq.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage("https://gravitybackend.logindesigns.com/Bannerqq.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage("https://gravitybackend.logindesigns.com/Bannerqq.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 150.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20,right:20 ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // height: 350,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(
                        color: Color(0x155665df),
                        spreadRadius: 5,
                        blurRadius: 17,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          SizedBox(width:15,),
                          _poButtonDesign('Dance',Icons.gamepad,"Gaming Mode",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()))),

                          _poButtonDesign('Classical',Icons.headphones,"Movie Mode",
                              goToPage: () => '#'),
                        ],
                      ),
                      SizedBox(height:15,),
                      SizedBox(height:15,),

                      Row(
                        children: [
                          SizedBox(width:15,),
                          _poButtonDesign('Rock',Icons.rocket_launch,"Rock Mode",
                              goToPage: () =>'#'),

                          _poButtonDesign('Pop',Icons.propane_outlined,"Pop Mode",
                              goToPage: () => '#'),
                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  _poButtonDesign(String value,IconData buttonIcon, String buttonString,
      { VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.red,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: GestureDetector(
          onTap: (){
            setState(() {
              Equalizer.setPreset(value);
              log(value.toString());
            });

          },
          child: Container(
            height: 60,
            width: 150,
            // color: Colors.blueGrey[700],
            // color: Colors.white10,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffeff3ff),
                  offset: Offset(-2, -2),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  buttonIcon,
                  size: 32,
                  color: Colors.black,
                ),
                Text(
                  buttonString,
                  // style: kTextStyleBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}



Future OpenDialogCustomer(BuildContext context) =>
    showDialog(
      barrierColor: Colors.black38,

      context: context,

      builder: (context) => Dialog(
        backgroundColor: Colors.indigo.shade50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // height:600,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: Column(
                    children: [


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView(
                            // controller: scrollController,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [

                            ],
                          ),


                        ],
                      ),


                    ],
                  ),
                ),

              ),
            ),
            Positioned(
                top:-35,

                child: CircleAvatar(
                  child: Icon(Icons.ac_unit_sharp,size: 40,),
                  radius: 40,

                )),

          ],
        ),
      ),

    );