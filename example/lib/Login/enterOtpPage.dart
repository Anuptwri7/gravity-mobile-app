import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:equalizer_example/Login/loginScreen.dart';
import 'package:equalizer_example/Signup/signupPage.dart';
import 'package:equalizer_example/bottmNavBar.dart';
import 'package:equalizer_example/helpers/stringConstant.dart';
import 'package:flutter/material.dart';
import '../helpers/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';


class EnterOtpPage extends StatefulWidget {
  String email;

  EnterOtpPage(this.email);
  @override
  _EnterOtpPageState createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {

  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController otp = TextEditingController();




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
                          "Enter the OTP",
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
                              controller: otp,

                              cursorColor: Color(0xff00FFFF),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {

                              },
                              style: TextStyle(color: Colors.grey),
                              decoration: kFormFieldDecoration.copyWith(

                                hintText: 'OTP',
                                prefixIcon: const Icon(
                                  Icons.numbers,
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
                              enterOtpToVerifyEmail();
                            },
                            child: Text("Verify",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
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

  Future<void> enterOtpToVerifyEmail() async {
    var response = await http.post(
      Uri.parse('${StringConst.protocol}${StringConst.baseUrl}${StringConst.verifyForOtp}'),
      body: ({
        "otp": otp.text.toString(),
        "email": widget.email.toString(),

      }),
    );
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200||response.statusCode==201) {
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

    } else {
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

      log(json.decode(response.body));
      // Fluttertoast.showToast(msg: "${json.decode(response.body)}");
    }
  }

}
