import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/other_screens/help_and_support.dart';
import 'package:the_tarot_guru/main_screens/other_screens/language_selection.dart';
import 'package:the_tarot_guru/main_screens/profile/profile_screens_options.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _firstName = '';
  late String _lastName = '';
  late String _email = '';

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = prefs.getString('firstName') ?? '';
    _lastName = prefs.getString('lastName') ?? '';
    _email = prefs.getString('email') ?? '';
    setState(() {});
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
                  Color(0xFF1C1C2D),
                  Color(0xFF1C1C2D),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_circle_left,
                      color: Colors.white,
                      size: 35,
                    )),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '${AppLocalizations.of(context)!.profilelabel}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 25,
                  right: 20
                ),
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height- AppBar().preferredSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),

                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF1C1C2D),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Image.asset('assets/images/intro/logo.png',width: 50,height: 50,)
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$_firstName $_lastName',style: TextStyle(color: Colors.white,fontSize: 20),),
                                Text('$_email',style: TextStyle(color: Colors.white,fontSize: 16),),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      const Divider(
                        height: 15,
                        thickness: 1,
                        indent: 5,
                        endIndent: 0,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(
                          text: '${AppLocalizations.of(context)!.userdetails}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserDetailsScreen()),
                            );
                          },
                          icon: Icons.person_2),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(text: '${AppLocalizations.of(context)!.addresslabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserAddresses()),
                            );
                          },
                          icon: Icons.location_city),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(text: '${AppLocalizations.of(context)!.orderslabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrdersScreen()),
                            );
                          },
                          icon: Icons.shopping_cart),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(
                          text: '${AppLocalizations.of(context)!.languageslabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LanguageSelectionScreen()),
                            );
                          },
                          icon: Icons.language),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(
                          text: '${AppLocalizations.of(context)!.helpandsupportlabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HelpAndSuppportScreen()),
                            );
                          },
                          icon: Icons.language),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
