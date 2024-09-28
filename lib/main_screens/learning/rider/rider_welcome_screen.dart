import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/learning/rider/rider_module.dart';

class RiderWaiteLearningWelcomeScreen extends StatefulWidget {
  const RiderWaiteLearningWelcomeScreen({super.key});

  @override
  State<RiderWaiteLearningWelcomeScreen> createState() => _RiderWaiteLearningWelcomeScreenState();
}

class _RiderWaiteLearningWelcomeScreenState extends State<RiderWaiteLearningWelcomeScreen> {
  bool _isScrolled = false;
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize = 16;
  late double ButtonFontsSize = 10;

  @override
  void initState() {
    super.initState();
    _loadLocalData();
  }

  _loadLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      TitleFontsSize = prefs.getDouble('TitleFontSize') ?? 23;
      SubTitleFontsSize = prefs.getDouble('SubtitleFontSize') ?? 18;
      ContentFontsSize = prefs.getDouble('ContentFontSize') ?? 16;
      ButtonFontsSize = prefs.getDouble('ButtonFontSize') ?? 18;
    });
  }

  _enrollUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnrolled', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RiderLearningModuleScreen()),
    );
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
                  Color(0xFF171625),
                  Color(0xFF171625),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg2.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.1),
            ),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels > 0) {
                if (!_isScrolled) {
                  setState(() {
                    _isScrolled = true;
                  });
                }
              } else {
                if (_isScrolled) {
                  setState(() {
                    _isScrolled = false;
                  });
                }
              }
              return true;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 25),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.05,
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.welcome}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Welcome to Rider Waite Learning Module',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TitleFontsSize,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Text(
                                "Welcome to the Rider Waite Learning Module. This course is designed to guide you through the mystical and enlightening world of Rider Waite Tarot. The course is structured into five modules, each focusing on a different aspect of the tarot deck.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SubTitleFontsSize,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Text(
                                "How It Works",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: TitleFontsSize,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Text(
                                "1. Introduction to Major Arcana: Begin with the Major Arcana cards to understand the core principles.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SubTitleFontsSize,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "2. Pentacles Module: Learn about the Pentacles cards which represent practicality, stability, and material concerns.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SubTitleFontsSize,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "3. Cups Module: Understand the Cups cards that symbolize emotions, relationships, and intuition.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SubTitleFontsSize,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "4. Swords Module: Explore the Swords cards which reflect the mind, thoughts, and conflicts.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SubTitleFontsSize,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "5. Wands Module: Delve into the Wands cards that represent energy, action, and creativity.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SubTitleFontsSize,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildAppBar(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 5,
      left: 0,
      right: 0,
      child: AppBar(
        scrolledUnderElevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_circle_left, color: Colors.white, size: 30),
        ),
        leadingWidth: 35,
        backgroundColor: _isScrolled ? Color(0xFF171625) : Colors.transparent,
        elevation: 0,
        title: Text(
          '${AppLocalizations.of(context)!.apptitle}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Color(0xFF171625),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: _enrollUser,
          child: Text(
            'Start Learning',
            style: TextStyle(
              color: Colors.black,
              fontSize: ButtonFontsSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
