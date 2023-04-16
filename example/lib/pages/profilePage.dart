import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equalizer_example/Signup/signupPage.dart';
import 'package:equalizer_example/bottmNavBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../helpers/captured_photo.dart';
import '../helpers/constant.dart';
import '../helpers/stringConstant.dart';
import 'model/customerProfile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();
  bool obsecureTextState = true;
  var username, password;
  IconData showPasswordIcon = Icons.remove_red_eye;
  var checkedValue = false;
  List<String> list = <String>['Male', 'Female', 'Others'];
  String dropdownValue = 'Select Gender';

  String customerName = '';
  String customerPhone = '';
  String customerAddress = '';

  Future getCustomerProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String finalUrl = prefs.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse(
            '${StringConst.protocol}${StringConst.baseUrl}${StringConst.customerProfile}'),
        // Uri.parse('${StringConst.protocol}${finalUrl}:8081${StringConst.getChalanDetailInfo}?id=&chalan_master=${widget.id}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        });

    print("Response Code Drop: ${response.statusCode}");
    log("body:${response.body}");

    if (response.statusCode == 401) {
    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          customerName = jsonDecode(response.body)['full_name'];
          customerPhone = jsonDecode(response.body)['phone_no'];
          customerAddress = jsonDecode(response.body)['address'];
        });

        return jsonDecode(response.body);
      } else {}
    }

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getCustomerProfile();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Profile".toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          automaticallyImplyLeading: false,
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
                      SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: Image.asset("assets/defaultUser.png"),
                            ),
                            Positioned(
                                left: 200,
                                top: -5,
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      showImageDialog(context);
                                    },
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.black,
                                        )),
                                  ),
                                ))
                          ],
                        ),
                      ),

                      // SizedBox(height: 20,),
                      // Center(
                      //   child: GestureDetector(
                      //     onTap:()=>showImageDialog(context),
                      //     child: Stack(
                      //       children: [
                      //         CircleAvatar(
                      //           child: Image.asset("assets/defaultUser.png"),
                      //           radius: 50,
                      //         ),
                      //         Positioned(
                      //             left: 0,
                      //             top: -20,
                      //             child: IconButton(
                      //               onPressed: () {},
                      //               icon: const Icon(
                      //                 Icons.camera_alt,
                      //                 size: 50,
                      //               ),
                      //
                      //             ))
                      //       ],
                      //
                      //
                      //     ),
                      //
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Name';
                                }
                              },
                              controller: fullName,
                              cursorColor: Color(0xff00FFFF),
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},

                              style: TextStyle(color: Colors.black),
                              decoration: kFormFieldDecoration.copyWith(
                                hintText: '${customerName}',
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.red,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00FFFF)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),
                            ),
                            kHeightVeryBigForForm,
                            // kHeightVeryBigForForm,
                            kHeightVeryBigForForm,
                            // kHeightVeryBigForForm,

                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your phone number';
                                }
                              },
                              controller: phone,
                              cursorColor: Color(0xff00FFFF),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              style: TextStyle(color: Colors.black),
                              decoration: kFormFieldDecoration.copyWith(
                                hintText: '${customerPhone}',
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00FFFF)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),
                            ),
                            kHeightVeryBigForForm,
                            // kHeightVeryBigForForm,

                            kHeightVeryBigForForm,

                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Address';
                                }
                              },
                              style: TextStyle(color: Colors.black),
                              controller: address,
                              cursorColor: Color(0xff00FFFF),
                              onChanged: (value) {},
                              decoration: kFormFieldDecoration.copyWith(
                                hintText: '${customerAddress}',
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.home,
                                  color: Colors.red,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00FFFF)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),
                            ),
                            kHeightVeryBigForForm,

                            /// image
                            // InkWell(
                            //   onTap: () => showImageDialog(context),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: const [
                            //     Icon(Icons.camera),
                            //       SizedBox(
                            //         height: 10,
                            //       ),
                            //       Text(
                            //         "Take Photo",
                            //         style: TextStyle(
                            //             fontSize: 20, fontWeight: FontWeight.bold),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            kHeightMedium,
                            kHeightMedium,
                            kHeightMedium,

                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      width: 2.0,
                                      color: Color(0xff00FFFF),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    primary: appbackgroundColor,
                                  ),
                                  onPressed: () {
                                    // updateProfile() ;
                                    Register();
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            kHeightMedium,
                          ],
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

  Future Register() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${pref.get("access_token")}'
    };

    Map<String, String> msg = {
      "full_name": fullName.text.toString().isEmpty
          ? customerName
          : fullName.text.toString(),
      "address": address.text.toString().isEmpty
          ? customerAddress
          : address.text.toString(),
      "phone_no":
          phone.text.toString().isEmpty ? customerPhone : phone.text.toString()
    };
    var request = http.MultipartRequest(
      "PATCH",
      Uri.parse(
          '${StringConst.protocol}${StringConst.baseUrl}${StringConst.updateProfile}'),
    );
    request.headers.addAll(headers);
    request.fields.addAll(msg);
    request.files.add(
      http.MultipartFile.fromBytes(
        "Photo",
        File(imageFile.path).readAsBytesSync(),
        filename: imageFile.path,
      ),
    );
    log(imageFile.path);
    log(msg.toString());
    request.send().then((response) {
      log(response.statusCode.toString());
      log(response.reasonPhrase.toString());
      try {
        if (response.statusCode == 200) {
          // Fluttertoast.showToast(msg: "Sent Successfully");
          final snackBar = SnackBar(
            content: Text('Profile Updated Successfully!'),
            backgroundColor: (Colors.black12),
            action: SnackBarAction(
              label: 'dismiss',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return const Text("data");
        } else {
          log(jsonDecode(response.reasonPhrase.toString()));
        }
      } catch (e) {
        throw Exception(e);
      }
    });
  }

  Future updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.patch(
        Uri.parse(
            '${StringConst.protocol}${StringConst.baseUrl}${StringConst.updateProfile}'),
        // Uri.parse('${StringConst.protocol}$finalUrl:8081${StringConst.addChalanRePackaging}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        },
        body: (jsonEncode({
          "full_name": fullName.text.toString(),
          "address": address.text.toString(),
          "phone_no": phone.text.toString(),
          // "photo": imageFile.path,
        })));

    // log(imageFile.path);
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      final snackBar = SnackBar(
        content: Text('Updated Successfully'),
        backgroundColor: (Colors.black12),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('${jsonDecode(response.body)}'),
        backgroundColor: (Colors.black12),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // displayToast(msg: StringConst.somethingWrongMsg);
    }
  }
}
