import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/captured_photo.dart';
import '../helpers/constant.dart';
import '../helpers/stringConstant.dart';
import 'package:http/http.dart' as http;

import '../helpers/take_picture_page.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool obsecureTextState = true;
  IconData showPasswordIcon = Icons.remove_red_eye;
  var checkedValue = false;
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                      Center(
                        child: Text(
                          "SIGN UP",
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your full Name';
                                }
                              },
                              controller: firstName,
                              cursorColor: Color(0xff00FFFF),
                              keyboardType: TextInputType.name,
                              onChanged: (value) {

                              },
                              style: TextStyle(color: Colors.grey),
                              decoration: kFormFieldDecoration.copyWith(
                                hintText: 'Enter your full name',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.red,
                                ),
                                enabledBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),

                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),

                            ),
                            kHeightVeryBigForForm,


                            kHeightVeryBigForForm,
                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your address';
                                }
                              },
                              controller: address,
                              cursorColor: Color(0xff00FFFF),
                              keyboardType: TextInputType.name,
                              onChanged: (value) {

                              },
                              style: TextStyle(color: Colors.grey),
                              decoration: kFormFieldDecoration.copyWith(
                                hintText: 'Enter your address',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.red,
                                ),
                                enabledBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),

                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),
                            ),
                            kHeightVeryBigForForm,
                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Email';
                                }
                              },
                              controller: email,
                              style: TextStyle(color: Colors.grey),

                              cursorColor: Color(0xff00FFFF),
                              onChanged: (value) {

                              },
                              decoration: kFormFieldDecoration.copyWith(
                                  hintText: 'Please Enter Your Email',
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.red,
                                  ),
                                enabledBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),

                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),
                            ),
                            kHeightVeryBigForForm,
                            kHeightVeryBigForForm,

                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your phone number';
                                }
                              },
                              controller: phone,
                              cursorColor: Color(0xff00FFFF),

                              keyboardType: TextInputType.name,
                              onChanged: (value) {

                              },
                              style: TextStyle(color: Colors.grey),
                              decoration: kFormFieldDecoration.copyWith(
                                hintText: 'Please Enter Your phone number',
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                ),
                                enabledBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),

                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),
                            ),
                            kHeightVeryBigForForm,
                            kHeightVeryBigForForm,

                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Password';
                                }
                              },
                              controller: password,
                              style: TextStyle(color: Colors.grey),
                              obscureText: obsecureTextState,
                              cursorColor: Color(0xff00FFFF),
                              decoration: kFormFieldDecoration.copyWith(
                                  hintText: 'Please Enter Your Password',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.red,
                                  ),
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff00FFFF)),

                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff00FFFF)),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (obsecureTextState != false) {
                                          obsecureTextState = true;
                                          showPasswordIcon = Icons.remove_red_eye;
                                        } else {
                                          obsecureTextState = true;
                                          showPasswordIcon =
                                              Icons.remove_red_eye_outlined;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      showPasswordIcon,
                                      color: Colors.red,
                                    ),


                                  )
                              ),
                            ),
                            kHeightVeryBigForForm,
                            kHeightVeryBigForForm,

                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Password';
                                }
                              },
                              style: TextStyle(color: Colors.grey),
                              obscureText: obsecureTextState,
                              cursorColor: Color(0xff00FFFF),
                              decoration: kFormFieldDecoration.copyWith(
                                  hintText: 'Please Enter Your Password again',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.red,
                                  ),
                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff00FFFF)),

                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff00FFFF)),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (obsecureTextState != false) {
                                          obsecureTextState = true;
                                          showPasswordIcon = Icons.remove_red_eye;
                                        } else {
                                          obsecureTextState = true;
                                          showPasswordIcon =
                                              Icons.remove_red_eye_outlined;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      showPasswordIcon,
                                      color: Colors.red,
                                    ),
                                  )),
                            ),
                            kHeightVeryBigForForm,
/// image
//                             InkWell(
//                               onTap: () => showImageDialog(context),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                 Icon(Icons.camera),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     "Take Photo",
//                                     style: TextStyle(
//                                         fontSize: 20, fontWeight: FontWeight.bold),
//                                   )
//                                 ],
//                               ),
//                             ),

                            kHeightMedium,
                            kHeightMedium,

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

                                  onPressed: ()=>{
                                    Register()
                                  },
                                  child: Text("Sign up",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                              ),
                            ),
                            kHeightMedium,
                            kHeightMedium,
                            kHeightMedium,


                          ],
                        ),
                      ),



                      kHeightVeryBigForForm,
                      kHeightVeryBigForForm,

                      Center(
                        child: Text(
                          "Already have a gravity account?",
                          style: TextStyle(fontSize: 12,color: Colors.black),
                        ),

                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
                          ),

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


  // Future Register() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   Map<String, String> headers = {
  //     'Content-Type': 'multipart/form-data',
  //   };
  //
  //   Map<String, String> msg = {
  //     "phone_no": phone.text,
  //     "email": email.text,
  //     "first_name": firstName.text,
  //     "last_name": lastName.text,
  //     "middle_name": middleName.text,
  //     "gender": "M",
  //     "birth_date": "2023-03-27",
  //     "address": address.text,
  //     "groups": "1",
  //   };
  //   var request = http.MultipartRequest(
  //     "POST",
  //     Uri.parse('${StringConst.protocol}${StringConst.baseUrl}${StringConst.register}'),
  //   );
  //   request.headers.addAll(headers);
  //   request.fields.addAll(msg);
  //   request.files.add(
  //     http.MultipartFile.fromBytes(
  //       "Photo",
  //       File(imageFile.path).readAsBytesSync(),
  //       filename: imageFile.path,
  //     ),
  //   );
  //   log(imageFile.path);
  //   log(msg.toString());
  //   request.send().then((response) {
  //     log(response.statusCode.toString());
  //     log(response.reasonPhrase.toString());
  //     try {
  //       if (response.statusCode == 200) {
  //         // Fluttertoast.showToast(msg: "Sent Successfully");
  //
  //         return const Text("data");
  //       }else{
  //         log(jsonDecode(response.reasonPhrase.toString()));
  //       }
  //     } catch (e) {
  //       throw Exception(e);
  //     }
  //   });
  // }

Future<void> Register() async {

  var response = await http.post(
    Uri.parse('${StringConst.protocol}${StringConst.baseUrl}${StringConst.register}'),
    body: ({
      "full_name":firstName.text,
      "address": address.text,
      "email": email.text,
      "phone_no": phone.text,
      "password": password.text
    }),
  );
  log(response.body);
  log(response.statusCode.toString());
  if (response.statusCode == 200||response.statusCode==201) {
  firstName.clear();
  address.clear();
  email.clear();
  password.clear();
  phone.clear();
    final snackBar = SnackBar(
      content: const Text('You are Successfully Registered!'),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    await SharedPreferences.getInstance();
    Navigator.pop(context);
  } else {
    final snackBar = SnackBar(
      content:  Text('${jsonDecode(response.body)}'),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

}
