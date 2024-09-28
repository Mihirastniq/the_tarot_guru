import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/deck/osho_option_deck.dart';
import 'package:the_tarot_guru/main_screens/learning/osho/osho_welcome_screen.dart';
import 'package:the_tarot_guru/main_screens/other_screens/about_osho.dart';
import 'package:the_tarot_guru/main_screens/special_prediction/osho/osho_warning_note.dart';
import 'package:the_tarot_guru/main_screens/spread/osho_new_spread.dart';
import 'package:the_tarot_guru/main_screens/spread/saved_spread/osho_saved_spread.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OshoZenTarot extends StatefulWidget {
  @override
  _AppSelectState createState() => _AppSelectState();
}

class _AppSelectState extends State<OshoZenTarot> with TickerProviderStateMixin {

  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize = 16;
  late double ButtonFontsSize = 10;
  bool _isScrolled = false;

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
                          padding: EdgeInsets.fromLTRB(20, 30, 0, 25),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                ' ${AppLocalizations.of(context)!.oshofulltitle}',
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
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewSpread(tarotType: "Osho Zen"),
                                      ),
                                    );
                                  },
                                  text: "${AppLocalizations.of(context)!.newspreadd}",
                                  color1: Color(0xFF8826FE),
                                  color2: Color(0xFF9443F6),
                                  icons: Icons.add,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              _buildButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DeckScreen(tarotType: "Osho Zen"),
                                    ),
                                  );
                                },
                                text: "${AppLocalizations.of(context)!.decktitle}",
                                color1: Color(0xFFD7735C),
                                color2: Color(0xFFD87D68),
                                opacity: 0.9,
                                imagePath:'assets/images/demoimg/logo.png',
                                icons: Icons.apps,
                              ),
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OshoSavedSpreadList(),
                                      ),
                                    );
                                  },
                                  text: "${AppLocalizations.of(context)!.savespread}",
                                  color1: Color(0xFF00B493),
                                  color2: Color(0xFF1BB89C),
                                  icons: Icons.folder,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AboutOshoZen(),
                                      ),
                                    );
                                  },
                                  text: "${AppLocalizations.of(context)!.aboutoshozen}",
                                  color1: Color(0xFF32C0D4),
                                  color2: Color(0xFF00A7BE),
                                  icons: Icons.question_mark,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OshoSpecialPredictionWarningScreen(),
                                      ),
                                    );
                                  },
                                  text: "${AppLocalizations.of(context)!.sprecialpredictionlabel}",
                                  color1: Color(0xFF8826FE),
                                  color2: Color(0xFF9443F6),
                                  icons: Icons.token,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OshoLearningWelcomeScreen(),
                                      ),
                                    );
                                  },
                                  text: "${AppLocalizations.of(context)!.learninglabel}",
                                  color1: Color(0xFF8826FE),
                                  color2: Color(0xFF9443F6),
                                  icons: Icons.school,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              )
                            ],
                          ),
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
    );
  }

  Widget _buildButton({
    required Function()? onPressed,
    required String text,
    required Color color1,
    required Color color2,
    required double opacity,
    required String imagePath, required IconData icons,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: double.infinity, // Full width
          height: 120.0, // Set desired height
          margin: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF141945).withOpacity(0.1),Colors.deepPurple.shade900.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade900.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/other/stars.png'),
                    fit: BoxFit.cover
                )
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 0.5,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width*0.6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: ButtonFontsSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Container(

                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Icon(
                                  icons,
                                  color: Color(0xFF141945),
                                  size: 35,
                                )
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
