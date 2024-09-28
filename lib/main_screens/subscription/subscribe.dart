import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:the_tarot_guru/main_screens/subscription/fail.dart';
import 'package:the_tarot_guru/main_screens/subscription/success.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscribeApp extends StatefulWidget {
  @override
  _SubscribeAppState createState() => _SubscribeAppState();
}

class _SubscribeAppState extends State<SubscribeApp> {
  late Razorpay _razorpay;
  String firstName = '';
  String lastName = '';
  int? userid = 0;
  String email = '';
  int phone = 0;

  _loadFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      userid = prefs.getInt('userid') ?? 0;
      email = prefs.getString('email') ?? '';
      phone = prefs.getInt('phone')??0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFirstName();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = 'https://thetarotguru.com/tarotapi/subscription.php';
    var body = {
      'user_id': userid.toString(),
      'payment_amount': '1499',
      'payment_method': 'razorpay',
      'transaction_id': response.paymentId,
      'payment_date': DateTime.now().toIso8601String(),
      'payment_status': 'Success',
      'payment_type': 'subscription',
    };

    var webresponse = await http.post(Uri.parse(url), body: body);
    var responseData = json.decode(webresponse.body);
    if (responseData['status'] == 'success') {
      prefs.setInt('subscription_status', 1);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubscriptionSuccessPage(title: 'Thank you for subscribe',)),
      );
    } else {
      print('Error Message: ${responseData['message']}');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentFailScreen()),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Navigator.pop(context);
  }

  void _startPayment() {
    var userDetails = {
        'userId': userid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
    var options = {
      'key': 'rzp_live_BOSf3y7tudC48z',
      'amount': 159900,
      'name': 'The Tarot Guru',
      'description': 'Subscription Payment',
      'prefill': {'contact': '${phone}', 'email': '${email}'},
      'external': {
        'wallets': ['paytm']
      },
      'notes': userDetails,
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark astrology theme
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF161F58),
                  Color(0xFF0C0E27),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg1.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.2),
            ),
          ),
          Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  // height: MediaQuery.sizeOf(context).height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                         Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Icon(
                              Icons.close,color: Colors.black
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                            'assets/images/other/subscription.png',
                          width: MediaQuery.sizeOf(context).width *0.6,
                          height: MediaQuery.sizeOf(context).height *0.3,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('${AppLocalizations.of(context)!.subscriptionmaintitle}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w800
                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${AppLocalizations.of(context)!.sucscriptionsubtitle}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.orangeAccent,Colors.orange,Colors.pink],
                                )
                            ),
                            child: Icon(Icons.done,color: Colors.white,size: 25,weight: 800,),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('${AppLocalizations.of(context)!.subsctiptionpointone}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.orangeAccent,Colors.orange,Colors.pink],
                                )
                            ),
                            child: Icon(Icons.done,color: Colors.white,size: 25,weight: 800,),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('${AppLocalizations.of(context)!.subsctiptionpointtwo}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.orangeAccent,Colors.orange,Colors.pink],
                                )
                            ),
                            child: Icon(Icons.done,color: Colors.white,size: 25,weight: 800,),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('${AppLocalizations.of(context)!.subsctiptionpointthree}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),)
                        ],
                      ),
                      SizedBox(
                        height: 85,
                      ),
                      FullWidthButton(text: '${AppLocalizations.of(context)!.subscribenow}', onPressed: (){
                        _startPayment();
                      })
                    ],
                  ),
                ),
              )
          ),
        ],
      )
    );
  }
}