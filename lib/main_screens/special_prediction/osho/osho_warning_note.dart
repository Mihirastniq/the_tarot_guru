import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/special_prediction/osho/detail_form.dart';

class OshoSpecialPredictionWarningScreen extends StatefulWidget {
  const OshoSpecialPredictionWarningScreen({super.key});

  @override
  State<OshoSpecialPredictionWarningScreen> createState() => _SpecialPredictionWarningScreenState();
}

class _SpecialPredictionWarningScreenState extends State<OshoSpecialPredictionWarningScreen> {
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
                  Color.fromRGBO(19, 14, 42, 1),
                  Color.fromRGBO(19, 14, 42, 1),
                  Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/other/bluebg.jpg', // Replace with your image path
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
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.05,
                              ),
                              Text(
                                // textAlign: TextAlign.center
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
                                "The Osho Zen Tarot is a powerful tool for self-reflection and insight. However, it's essential to remember that the cards do not predict the future with absolute certainty. The interpretations provided here are based on traditional and intuitive meanings associated with each card. They serve as a guide to help you explore your inner self and navigate life's challenges.",
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
                                "3. Card Selection: Once your details are entered, we will draw 4 random cards from the Osho Zen Tarot deck for you. Each card represents a different time frame in your future:\n   - 1 Month: The first card gives insight into the coming month.\n   - 3 Months: The second card looks ahead to the next three months.\n   - 6 Months: The third card offers a perspective on the next six months.\n   - 12 Months: The fourth card provides a glimpse into the next year.",
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
              // forceMaterialTransparency: true, // Removed this line
              leading: IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: Icon(Icons.arrow_circle_left,color: Colors.white,size: 30,),
              ),
              leadingWidth: 35,
              backgroundColor: _isScrolled ? Colors.deepPurple.shade900.withOpacity(1) : Colors.transparent,
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
        color: Colors.blueAccent,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OshoSpecialPredictionDetailFormScreen(),
                ),
              );
            },
            child: Text(
              'Start',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: ButtonFontsSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Background color
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
