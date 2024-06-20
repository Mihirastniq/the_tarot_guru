import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/Products/cart.dart';
import 'package:the_tarot_guru/main_screens/OshoZen.dart';
import 'package:the_tarot_guru/main_screens/Profile/profile.dart';
import 'package:the_tarot_guru/main_screens/RiderWaite.dart';
import 'package:the_tarot_guru/main_screens/other_screens/help_and_support.dart';
import 'package:the_tarot_guru/main_screens/products/products.dart';
import 'package:the_tarot_guru/main_screens/subscription/pre_subscribe.dart';
import 'package:the_tarot_guru/main_screens/subscription/subscribe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_tarot_guru/main_screens/warnings/unsubscribe.dart';
import 'package:http/http.dart' as http;



class AppSelect extends StatefulWidget {
  @override
  _AppSelectState createState() => _AppSelectState();
}

class _AppSelectState extends State<AppSelect> with SingleTickerProviderStateMixin {
  String firstName = '';
  String lastName = '';
  String createdAt = '';
  int SubscriptionStatus = 0;
  int freebyadmin = 0;
  int freewarning = 0;
  int trialperiod = 0;
  int accountStatus = 0;
  late int userId;
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize = 16;
  late double ButtonFontsSize = 10;

  Timer? _timer;
  String remainingTime = '';

  @override
  void initState() {
    super.initState();
    _loadLocalData();
    _fetchUserDetails();
  }

  _loadLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      userId = prefs.getInt('userid') ?? 0;
      TitleFontsSize = prefs.getDouble('TitleFontSize') ?? 23;
      SubTitleFontsSize = prefs.getDouble('SubtitleFontSize') ?? 18;
      ContentFontsSize = prefs.getDouble('ContentFontSize') ?? 16;
      ButtonFontsSize = prefs.getDouble('ButtonFontSize') ?? 10;
    });
  }

  _fetchUserDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('userid') ?? 0;

      var url = 'https://thetarotguru.com/tarotapi/userprofile.php';
      var response = await http.post(Uri.parse(url), body: {
        'user_id': userId.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        var userDetails = responseData['user_details'] ?? {};
        var subscriptionDetails = responseData['subscription_details'] ?? {};

        setState(() {
          SubscriptionStatus = int.tryParse(subscriptionDetails['subscription_status'] ?? '0') ?? 0;
          freebyadmin = int.tryParse(subscriptionDetails['free_by_admin'] ?? '0') ?? 0;
          freewarning = int.tryParse(subscriptionDetails['warning'] ?? '0') ?? 0;
          trialperiod = int.tryParse(subscriptionDetails['trial_warning']) ?? 0;
          accountStatus = int.tryParse(userDetails['account_status']) ?? 0;
          prefs.setInt('subscription_status', SubscriptionStatus);
          prefs.setInt('free_by_admin', freebyadmin);
          prefs.setInt('warning', freewarning);
          prefs.setInt('trial_warning', trialperiod);
          prefs.setInt('account_status', accountStatus);
          createdAt = userDetails['created_at'] ?? '';
          prefs.setString('created_at', createdAt);
        });

        print(SubscriptionStatus);
        print(freebyadmin);
        print(freewarning);
        print(trialperiod);
        print(accountStatus);

        if (isWithin48Hours()) {
          startCountdown();
        }
      } else {
        print('Failed to fetch user details. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }

  void startCountdown() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
          (Timer timer) {
        setState(() {
          remainingTime = calculateRemainingTime();
        });
      },
    );
  }

  String calculateRemainingTime() {
    if (createdAt.isEmpty) {
      return '00:00:00';
    }

    DateTime createdAtDateTime = DateTime.parse(createdAt);
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAtDateTime);

    int remainingHours = 48 - difference.inHours;
    int remainingMinutes = 59 - difference.inMinutes % 60;
    int remainingSeconds = 59 - difference.inSeconds % 60;

    return '$remainingHours:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool isWithin48Hours() {
    if (createdAt.isEmpty) {
      return false;
    }

    DateTime createdAtDateTime = DateTime.parse(createdAt);
    Duration difference = DateTime.now().difference(createdAtDateTime);

    return difference.inHours < 48;
  }

  @override
  void dispose() {
    // Cancel the timer only if it has been initialized
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(19, 14, 42, 1),
                  Color.fromRGBO(19, 14, 42, 1),
                  Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg1.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile(),
                    ),
                  );
                }, icon: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.white,
                )),
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage(),
                    ),
                  );
                }, icon: Icon(
                  Icons.shopping_bag,
                  size: 30,
                  color: Colors.white,
                )),
                IconButton(onPressed: () {
                  if(SubscriptionStatus == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PreSubscribeUSer(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubscribeApp(),
                      ),
                    );
                  }
                }, icon: Icon(
                  Icons.money,
                  size: 30,
                  color: Colors.white,
                ))
              ],
              title: Text(
                '${AppLocalizations.of(context)!.apptitle}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SubTitleFontsSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppBar().preferredSize.height*2,
                      ),
                      Text(
                        AppLocalizations.of(context)!.hello,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SubTitleFontsSize,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${firstName} ${lastName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: TitleFontsSize,
                            fontWeight: FontWeight.w600
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (isWithin48Hours())
                    Text(
                      'Remaining Time: $remainingTime',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ContentFontsSize,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (!isWithin48Hours() && SubscriptionStatus == 0 && trialperiod == 1)
                    Text(
                      'Subscription Expired!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: SubTitleFontsSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (!isWithin48Hours() && SubscriptionStatus == 0 && freebyadmin == 1 && freewarning == 1)
                    Text(
                      'Subscription Given By admin!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: SubTitleFontsSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(SubscriptionStatus == 1 || freebyadmin == 1 || isWithin48Hours()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OshoZenTarot()));
                          } else if (accountStatus == 0){
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AccountBlocked(
                              title: 'Your Account is Blocked!!',
                              message: 'Your Account is blocked due to unusual activity. Please contact us at support@thetarotguru.com for unblock account.',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HelpAndSuppportScreen(),
                                  ),
                                );
                              },
                            );
                          },
                          );
                          }
                          else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SubscriptionExpire(
                                  title: 'Please Subscribe the application!!',
                                  message: 'Your subscription has expired. Please subscribe to continue using the app.',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SubscribeApp(),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),

                              image: DecorationImage(
                                image: AssetImage('assets/images/other/LogoBg.png'),
                                fit: BoxFit.cover,
                                opacity: 0.5,
                              ),
                              border: Border.all(
                                  width: 2,
                                  color: Color(0xFF906BFF)
                              )
                          ),
                          width: double.infinity,
                          height: 150,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                height: 100,
                                width: 100,
                                child: Image.asset('assets/images/cards/osho.jpg',width: 50,height: 50,),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text('${AppLocalizations.of(context)!.oshotitle}',style: TextStyle(color: Colors.white,fontSize: ButtonFontsSize,fontWeight: FontWeight.w800),),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          if(SubscriptionStatus == 1 || freebyadmin == 1 || isWithin48Hours()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RiderWaiteTarot()));
                          }else if (accountStatus == 0){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AccountBlocked(
                                  title: 'Your Account is Blocked!!',
                                  message: 'Your Account is blocked due to unusual activity. Please contact us at support@thetarotguru.com for unblock account.',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HelpAndSuppportScreen(),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SubscriptionExpire(
                                  title: 'Your Subscription is Expired!',
                                  message: 'Your subscription has expired. Please subscribe to continue using the app.',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SubscribeApp(),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.grey.withOpacity(0.4),
                                    Colors.grey.withOpacity(0.4)
                                  ]
                              ),
                              border: Border.all(
                                  width: 2,
                                  color: Color(0xFF906BFF)
                              )
                          ),
                          width: double.infinity,
                          height: 150,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey.withOpacity(0.1),

                                ),
                                height: 100,
                                width: 100,
                                child: Image.asset('assets/images/cards/rider.jpg',width: 75,height: 75,),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width *0.9-200,
                                child: Text('${AppLocalizations.of(context)!.ridertitle}',style: TextStyle(color: Colors.white,fontSize: ButtonFontsSize,fontWeight: FontWeight.w800),),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Products()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.grey.withOpacity(0.4),
                                    Colors.grey.withOpacity(0.4)
                                  ]
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/images/other/LogoBg.png'),
                                fit: BoxFit.cover,
                                opacity: 0.5,
                              ),
                              border: Border.all(
                                  width: 2,
                                  color: Color(0xFF906BFF)
                              )
                          ),
                          width: double.infinity,
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('${AppLocalizations.of(context)!.producttitle}',style: TextStyle(color: Colors.white,fontSize: ButtonFontsSize,fontWeight: FontWeight.w800),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}