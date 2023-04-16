import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:equalizer_example/Signup/signupPage.dart';
import 'package:equalizer_example/bottmNavBar.dart';
import 'package:equalizer_example/helpers/stringConstant.dart';
import 'package:flutter/material.dart';
import '../helpers/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'enterOtpPage.dart';


class SendOtpPage extends StatefulWidget {
  @override
  _SendOtpPageState createState() => _SendOtpPageState();
}

class _SendOtpPageState extends State<SendOtpPage> {

  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();




  @override
  void initState() {
    // TODO: implement initState
    ;
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

                      Image.asset('assets/gravityName.png',height: 70,),
                      SizedBox(height: 20,),
                      Center(
                        child: Text(
                          "Send Verification Code",
                          style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      kHeightVeryBig,
                      // kHeightMedium,


                      Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            TextFormField(

                              // The validator receives the text that the user has entered.
                              controller: emailController,

                              cursorColor: Color(0xff00FFFF),
                              keyboardType: TextInputType.name,
                              onChanged: (value) {

                              },
                              style: TextStyle(color: Colors.grey),
                              decoration: kFormFieldDecoration.copyWith(

                                hintText: 'Email',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.red,
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),


                      kHeightVeryBigForForm,
                      kHeightVeryBigForForm,
                      kHeightVeryBigForForm,
                      kHeightVeryBigForForm,
                      kHeightVeryBigForForm,
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width/2,

                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 2.0,
                                color: Color(0xff00FFFF),
                              ),
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ) ,
                              primary: appbackgroundColor,
                            ),

                            onPressed: (){
                              sendEmailForOtp();
                            },
                            child: Text("Submit",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                        ),
                      ),



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

  Future<void> sendEmailForOtp() async {
    var response = await http.post(
      Uri.parse('${StringConst.protocol}${StringConst.baseUrl}${StringConst.emailForOtp}'),
      body: ({
        "email": emailController.text.toString(),

      }),
    );
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200||response.statusCode==201) {

      final snackBar = SnackBar(
        content:  Text(jsonDecode(response.body)['message']),
        backgroundColor: (Colors.black12),
        // action: SnackBarAction(
        //   label: 'dismiss',
        //   onPressed: () {
        //   },
        // ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EnterOtpPage(emailController.text.toString())));
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();


    } else {

      log(json.decode(response.body));
      // Fluttertoast.showToast(msg: "${json.decode(response.body)}");
    }
  }

}
