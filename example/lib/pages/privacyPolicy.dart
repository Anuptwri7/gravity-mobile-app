
import 'package:flutter/material.dart';
import '../helpers/constant.dart';


class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Privacy Policy",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.arrow_back,color: appbackgroundColor,),
        ),
        backgroundColor: appbackgroundColor,
        body: Stack(
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

                    Card(
                      // margin: EdgeInsets.all(5.0),
                      color: Colors.white,
                      elevation: kCardElevation,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text(
                            "Thank you for choosing Gravity Earbud. We respect your privacy and are committed to protecting it through our policies, procedures, and technology. This Privacy Policy describes how we collect, use, disclose, and protect your personal information in connection with our products and services.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "1.Information We Collect",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "We may collect personal information when you use our product and services. The information we collect includes:\n * Your name, email address, phone number, and other contact information\n * Your payment information, such as credit card or bank account information \n * Your device information, such as the device model, operating system, and unique device identifiers\n * Your usage information, such as your browsing and search history, and your interactions with our products and services\n * Your location information, if you enable location services on your device \n * Any other information you provide to us voluntarily"

                                ,
                            style: TextStyle(),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "2.How We Use Your Information",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "We use your personal information for the following purposes:\n * To provide you with our products and services, including customer support\n * To improve our products and services, including developing new features and functionalities \n * To communicate with you about our products and services, including sending you marketing communications\n * To protect our legal rights and interests, including detecting and preventing fraud and other unauthorized activities\n * To comply with applicable laws and regulations"

                            ,
                            style: TextStyle(),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "3.Disclosure of Your Information",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "We may share your personal information with third parties for the following purposes:\n * With our service providers, who help us provide our products and services, including hosting, payment processing, and customer support\n * With our business partners, who help us promote our products and services \n * With law enforcement agencies, regulators, and other government authorities, as required by law or to protect our legal rights and interests\n * In connection with a merger, acquisition, or sale of all or a portion of our assets\n"

                            ,
                            style: TextStyle(),
                          ),

                          kHeightSmall,

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
    );


  }



}
