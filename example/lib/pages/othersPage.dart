import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:equalizer_example/Signup/signupPage.dart';
import 'package:equalizer_example/bottmNavBar.dart';
import 'package:equalizer_example/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/constant.dart';
import '../pages/privacyPolicy.dart';


class OtherPage extends StatefulWidget {
  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  final _loginFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appbackgroundColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Stack(

            children: [
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: kMarginPaddMedium,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [

                      Image.asset('assets/gravity.png',height: 100,),
                      SizedBox(height: 20,),

                      kHeightVeryBig,
                      kHeightBig,
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 2.0,
                                color: Color(0xff00FFFF),
                              ),
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ) ,
                              primary: appbackgroundColor,
                            ),

                            onPressed: (){

                                },
                            child: Text("Auto Shut-Down Timer",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                        ),
                      ),
                      kHeightBig,
                      kHeightVeryBig,
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 2.0,
                                color: Color(0xff00FFFF),
                              ),
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ) ,
                              primary: appbackgroundColor,
                            ),

                            onPressed: ()=>{},
                            // UrlLauncher.launch('tel:+${9815236505}'),

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>TabPage()));

                            child: Text("Device Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                        ),
                      ),
                      kHeightVeryBig,
                      kHeightBig,
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 2.0,
                                color: Color(0xff00FFFF),
                              ),
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ) ,
                              primary: appbackgroundColor,
                            ),

                            onPressed: (){
                                   },
                            child: Text("Earbuds Light Pattern",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                        ),
                      ),
                      // kHeightMedium,
                      kHeightBig,
                      kHeightBig,
                      kHeightBig,


                    ],

                  ),

                ),

              )

            ],

          ),

        ),
      ),
    );

  }
  Future<void> _dialCall(String phone) async {
    String phoneNumber = phone;
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
  Future<void> _email(String email) async {
    String emailId = email;
    final Uri launchUri = Uri(
      scheme: 'mailTo',
      path: emailId,
    );
    await launch(launchUri.toString());
  }
  Future openDialogCaller(BuildContext context) =>
      showDialog(
        barrierColor: Colors.black38,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: appbackgroundColor,
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
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      children: [
                        kHeightVeryBig,
                        kHeightVeryBig,
                        kHeightVeryBig,
                        kHeightVeryBig,

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.phone,color: Colors.red,),
                            SizedBox(width: 20,),
                            GestureDetector(
                                onTap: ()=>_dialCall("+9779810773412"),
                                child: Text("+9779810773412",style: TextStyle(fontWeight: FontWeight.bold),)),

                          ],
                        ),
                        kHeightVeryBig,
                        kHeightVeryBig,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.mail,color: Colors.red,),
                            SizedBox(width: 20,),
                            GestureDetector(
                                onTap: ()=>_email("info@gravitylifestyle.com.np"),
                                child: Text("info@gravitylifestyle.com.np",style: TextStyle(fontWeight: FontWeight.bold),)),
                          ],
                        ),
                        kHeightVeryBig,
                        kHeightVeryBig, kHeightVeryBig,



                      ],
                    ),
                  ),

                ),
              ),
              Positioned(
                  top:-35,

                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Image.asset("assets/gravity.png"),
                    radius: 40,

                  )),


            ],
          ),
        ),

      );

// Future<void> login() async {
//   List<String> getCodeName =[];
//   List<String> getSuperUser = [];
//   log("http://${subDomain}/api/v1/login");
//   var response = await http.post(
//     Uri.parse('https://${subDomain}/api/v1/user-app/login'),
//     body: ({
//       'user_name': username,
//       'password': password,
//     }),
//   );
//   log(response.body);
//   log(response.statusCode.toString());
//   if (response.statusCode == 200) {
//     final SharedPreferences sharedPreferences =
//     await SharedPreferences.getInstance();
//     sharedPreferences.setString("access_token",
//         json.decode(response.body)['tokens']['access'] ?? '#');
//     sharedPreferences.setString("refresh_token",
//         json.decode(response.body)['tokens']['refresh'] ?? '#');
//     sharedPreferences.setString("user_name",
//         json.decode(response.body)['user_name'] ?? '#');
//     sharedPreferences.setString("subDomain" , subDomain);
//
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
//   } else {
//     Fluttertoast.showToast(msg: "${json.decode(response.body)}");
//   }
// }

}
