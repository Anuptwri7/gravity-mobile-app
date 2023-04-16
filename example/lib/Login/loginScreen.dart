import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:equalizer_example/Login/sendOtpPage.dart';
import 'package:equalizer_example/Signup/signupPage.dart';
import 'package:equalizer_example/bottmNavBar.dart';
import 'package:equalizer_example/helpers/stringConstant.dart';
import 'package:flutter/material.dart';
import '../helpers/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/deviceListingPage.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',

  ],
);
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  GoogleSignInAccount _currentUser;
  String _contactText = '';


  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obsecureTextState = true;
  var username, password;
  IconData showPasswordIcon = Icons.remove_red_eye;
  var checkedValue = false;


  @override
  void initState() {
    // TODO: implement initState
 ;
    super.initState();
 _googleSignIn.onCurrentUserChanged.listen(( account) {
   setState(() {
     _currentUser = account;
   });

 });
 _googleSignIn.signInSilently();
  }
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }
  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'] as List<dynamic>;
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic> name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>;
      if (name != null) {
        return name['displayName'] as String;
      }
    }
    return null;
  }
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();

    } catch (error) {
      print(error);
    }
  }
  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  Widget _buildBody() {
    final GoogleSignInAccount user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
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
                          "LOG IN",
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
                                  return 'Please Enter Your Name';
                                }
                              },
                              controller: emailController,
                              cursorColor: Color(0xff00FFFF),
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: kFormFieldDecoration.copyWith(

                                hintText: 'Email',
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
                            TextFormField(
                              controller: passwordController,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Password';
                                }
                              },
                              style: TextStyle(color: Colors.black),
                              obscureText: obsecureTextState,
                              cursorColor: Color(0xff00FFFF),
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: kFormFieldDecoration.copyWith(
                                  hintText: 'Password',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.red,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (obsecureTextState == false) {
                                          obsecureTextState = true;
                                          showPasswordIcon = Icons.visibility;
                                        } else if(obsecureTextState==true) {
                                          obsecureTextState = false;
                                          showPasswordIcon =
                                              Icons.visibility_off;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      showPasswordIcon,
                                      color: Colors.red,
                                    ),

                                  ),
                                enabledBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),

                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff00FFFF)),
                                ),
                              ),
                            ),
                            kHeightMedium,
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot your Password?",
                                style: TextStyle(fontSize: 12,color: Colors.black),
                              ),
                            ),
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

                                  onPressed: (){
                                    emailController.text.toString().isEmpty||passwordController.text.toString().isEmpty?log("error"):login();
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>TabPage()));
                                  },
                                  child: Text("Log in",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                              ),
                            ),
                            kHeightMedium,
                            kHeightMedium,
                            kHeightMedium,
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),color: Colors.black),
                                      height: 2,
                                      // margin: CustomPaddings.horizontal(),
                                    ),
                                  ),
                                  SizedBox(width: 5,),

                                  Text(
                                    "or create with",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black),
                                      height: 2,
                                      // margin: CustomPaddings.horizontal(),
                                    ),
                                  ),
                                ],


                              ),

                            ),
                            SizedBox(height: 5,),
                            SizedBox(height: 5,),
                            GestureDetector(
                                onTap: _handleSignIn,
                                child
                                : Image.asset('assets/google.png',color: Colors.black,)),
                            SizedBox(height:15,),

                          ],
                        ),
                      ),


                      kHeightVeryBigForForm,

                      Center(
                        child: Text(
                          "Don’t have a gravity account?",
                          style: TextStyle(fontSize: 12,color: Colors.black),
                        ),

                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupScreen()));
                        },
                        child: Center(
                          child: Text(
                            "Sign Up",
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

  Future<void> login() async {
    var response = await http.post(
      Uri.parse('${StringConst.protocol}${StringConst.baseUrl}${StringConst.login}'),
      body: ({
          "email": emailController.text.toString(),
          "password": passwordController.text.toString(),
      }),
    );
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200||response.statusCode==201) {
      emailController.clear();
      passwordController.clear();
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString("access_token",
          json.decode(response.body)['tokens']['access'] ?? '#');
      sharedPreferences.setString("refresh_token",
          json.decode(response.body)['tokens']['refresh'] ?? '#');
      sharedPreferences.setString("email",
          json.decode(response.body)['email']?? '#');
      sharedPreferences.setBool("emailVerified",
          json.decode(response.body)['is_email_verified']?? '#');
      sharedPreferences.setBool("phoneVerified",
          json.decode(response.body)['is_phone_verified']?? '#');
      sharedPreferences.setBool("active",
          json.decode(response.body)['is_active']?? '#');
      sharedPreferences.setString("photo",
          json.decode(response.body)['photo']?? '#');
      sharedPreferences.setInt("uid",
          json.decode(response.body)['id']?? '#');
      sharedPreferences.setString("name",
          json.decode(response.body)['full_name']?? '#');
      if(json.decode(response.body)['is_email_verified'].toString()=="false"){
        final snackBar = SnackBar(
          content:  Text("Email Not verified , Please verify your Email"),
          backgroundColor: (Colors.black12),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SendOtpPage()));
      }else if(json.decode(response.body)['is_active'].toString()=="false"){
        final snackBar = SnackBar(
          content:  Text("Account not Active please contact Gravity!"),
          backgroundColor: (Colors.black12),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DeviceListingPage()));
      }

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabPage()));


    } else {

      log(json.decode(response.body)['detail']);
      final snackBar = SnackBar(
        content:  Text(json.decode(response.body)['detail']),
        backgroundColor: (Colors.black12),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Fluttertoast.showToast(msg: "${json.decode(response.body)}");
    }
  }

}
