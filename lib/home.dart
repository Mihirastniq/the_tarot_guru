import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/Products/cart.dart';
import 'package:the_tarot_guru/main_screens/OshoZen.dart';
import 'package:the_tarot_guru/main_screens/Profile/profile.dart';
import 'package:the_tarot_guru/main_screens/RiderWaite.dart';
import 'package:the_tarot_guru/main_screens/products/products.dart';
import 'package:the_tarot_guru/main_screens/subscription/pre_subscribe.dart';
import 'package:the_tarot_guru/main_screens/subscription/subscribe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_tarot_guru/main_screens/warnings/unsubscribe.dart';



class AppSelect extends StatefulWidget {
  @override
  _AppSelectState createState() => _AppSelectState();
}

class _AppSelectState extends State<AppSelect> with SingleTickerProviderStateMixin {

  String firstName = '';
  String lastName = '';
  String createdAt = '';
  int SubscriptionStatus=0;
  int freebyadmin=0;
  int freewarning=0;


  @override
  void initState() {
    super.initState();
    _loadFirstName();
  }

  _loadFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      SubscriptionStatus = prefs.getInt('subscription_status') ?? 0;
      freebyadmin = prefs.getInt('free_by_admin') ?? 0 ;
      freewarning = prefs.getInt('warning') ?? 0 ;
      createdAt = prefs.getString('created_at')?? '';
    });
  }

  bool isWithin48Hours() {
    if (createdAt.isEmpty) {
      return false; // Assuming createdAt is a non-empty string
    }
  DateTime createdAtDateTime = DateTime.parse(createdAt);

    Duration difference = DateTime.now().difference(createdAtDateTime);

    return difference.inHours < 24;
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
                  fontSize: 25.0,
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
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        '${firstName} ${lastName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                        ),
                      ),

                    ],
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
                          } else {
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
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                child: Text('${AppLocalizations.of(context)!.oshotitle}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),),
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
                                child: Text('${AppLocalizations.of(context)!.ridertitle}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),),
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
                              Text('${AppLocalizations.of(context)!.producttitle}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
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