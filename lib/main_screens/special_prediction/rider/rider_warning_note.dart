import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/special_prediction/rider/detail_form.dart';

class RiderWaiteSpecialPredictionWarningScreen extends StatefulWidget {
  const RiderWaiteSpecialPredictionWarningScreen({super.key});

  @override
  State<RiderWaiteSpecialPredictionWarningScreen> createState() => _RiderWaiteSpecialPredictionWarningScreenState();
}

class _RiderWaiteSpecialPredictionWarningScreenState extends State<RiderWaiteSpecialPredictionWarningScreen> {
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
              'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
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
                                '${AppLocalizations.of(context)!.sprecialpredictionlabel}',
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
                                "The Rider Waite Tarot is a timeless and insightful tool for self-discovery and guidance. However, it is important to remember that the cards do not offer absolute predictions of the future. The meanings and interpretations provided here are based on traditional symbolism and intuitive insights. Use these as a guide to explore your inner world and address life's challenges.",
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
                                "How it Works",
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
                                "1. Start Your Reading: Press the 'Start' button to begin your journey.",
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
                                "2. Enter Your Details: Provide your basic details such as your name, date of birth, and time of birth. These details help us personalize your reading.",
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
                                "3. Card Selection: Once your details are entered, we will draw 4 random cards from the Rider Waite Tarot deck for you. Each card represents a different aspect of your life and future:\n   - 1 Month: The first card gives insight into the coming month.\n   - 3 Months: The second card looks ahead to the next three months.\n   - 6 Months: The third card offers a perspective on the next six months.\n   - 12 Months: The fourth card provides a glimpse into the next year.",
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
                                "4. Interpretation: Read the interpretations provided for each card. Reflect on their meanings and how they might apply to your life.",
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
                                "5. Personal Reflection: Use the insights from the cards to guide your thoughts and actions. Remember, the cards offer guidance, but your choices shape your destiny.",
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
          Positioned(
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
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF171625),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RiderWaiteSpecialPredictionDetailFormScreen(),
                ),
              );
            },
            child: Text(
              'Start',
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
      ),
    );
  }
}
