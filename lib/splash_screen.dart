import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/intro.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize =16 ;
  late double ButtonFontsSize =25;
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
      ButtonFontsSize = prefs.getDouble('ButtonFontSize') ?? 25;
    });
  }

  @override
  Widget build(BuildContext context) {

    Timer(
      const Duration(seconds: 6),
          () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool isLoggedIn = prefs.getBool("isLogin") ?? false;

        if (isLoggedIn) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppSelect()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashView()));
        }
      },
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(4, 2, 12, 1.0),
                  Color.fromRGBO(4, 2, 12, 1.0),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.1),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width*0.7,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset('assets/images/intro/logo.png'),
                    ),
                    Text(
                        '${AppLocalizations.of(context)!.punchline}',
                        textAlign: TextAlign.center,
                        style: _getTitleTextStyle(context)
                    ),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    double lineHeight = 1.8;
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.white,
        fontSize: TitleFontsSize,
        fontWeight:
        FontWeight.w600,
        height: lineHeight
    );

    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.white,
          fontSize: TitleFontsSize,
          fontWeight:
          FontWeight.w600,
          height: lineHeight
      );
    } else {
      return defaultStyle;
    }
  }
}
