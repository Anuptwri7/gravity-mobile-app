import 'dart:convert';
import 'dart:developer';

import 'package:equalizer_example/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login/loginScreen.dart';
import 'TabPages/cartPage.dart';
import 'TabPages/homePage.dart';
import 'TabPages/profilePage.dart';
import 'helpers/stringConstant.dart';

import 'package:http/http.dart' as http;

String currentDevice='';
class TabPage extends StatefulWidget {
  const TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;

  String guid='';
  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }
  Future getDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      guid= prefs.getString("guid");
      // log(guid);
    });
    getdeviceListings();

  }
  Future getdeviceListings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('${StringConst.protocol}${StringConst.baseUrl}${StringConst.deviceListings}/${guid}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        });

    print("Response Code Drop: ${response.statusCode}");
    log("${response.body}");

    if (response.statusCode == 401) {
    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {
        prefs.setString("currentDevice", jsonDecode(response.body)['title']);
        setState(() {
          currentDevice=prefs.getString("currentDevice");
        });
        return jsonDecode(response.body);
      } else {

      }
    }

    return null;
  }
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    getDetails();
  }

  @override
  final int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbackgroundColor,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children:  [
          HomePage(),
          CartTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: CustomBottomNavigationBar(
            iconList: const [
              Icons.home,
              Icons.shopping_cart,
              Icons.person,
            ],
            onChange: (index) {
              setState(() {
                selectedIndex = index;
                tabController.index = selectedIndex;
              });
            },
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;

  final Function(int) onChange;
  final List<IconData> iconList;

  const CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
         this.iconList,
         this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 1;
  List<IconData> _iconList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding:
        const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 10),
        // child: Container(
        //   height: 30,
        //   width: 32,
        //   decoration: index == _selectedIndex
        //       ? BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(10),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.grey.shade500,
        //               offset: const Offset(4, 4),
        //               spreadRadius: 1,
        //               blurRadius: 2,
        //             ),
        //           ],
        //         )
        //       : BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(15),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.blue.shade100,
        //               offset: const Offset(5, 8),
        //               spreadRadius: 1,
        //               blurRadius: 5,
        //             ),
        //           ],
        //         ),
        //   child: Icon(
        //     icon,
        //     color: index == _selectedIndex ? Colors.blue : Colors.grey,
        //   ),
        // ),
        child: Icon(
          icon,
          color: index == _selectedIndex ? Colors.red : Colors.black,
          size: 35,
        ),
      ),
    );
  }
}
