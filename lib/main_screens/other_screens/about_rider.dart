import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutRiderScreen extends StatefulWidget {
  const AboutRiderScreen({super.key});

  @override
  State<AboutRiderScreen> createState() => _AboutRiderScreenState();
}

class _AboutRiderScreenState extends State<AboutRiderScreen> {
  late String _title = '';
  late String _text = '';

  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize =16 ;
  late double ButtonFontsSize =25;
  @override
  void initState() {
    super.initState();
    _loadLocalData();
    _loadAboutOshoData();
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


  Future<void> _loadAboutOshoData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedLanguage = prefs.getString('lang') ?? 'en';

    try {
      // Load JSON data
      String data = await DefaultAssetBundle.of(context)
          .loadString('assets/json/about_rider.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      // Fetch data based on selected language
      List<dynamic> languageData = jsonData[selectedLanguage]['data'];
      Map<String, dynamic> aboutOshoData = languageData.isNotEmpty
          ? languageData.first
          : jsonData['en']['data'].first; // Fallback to English if data is not available for the selected language

      setState(() {
        _title = aboutOshoData['title'];
        _text = aboutOshoData['text'];
      });
    } catch (e) {
      print('Error loading about osho data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_circle_left,size: 40,),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context,true);
                  },
                ),

              ),
            ),
            Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.star, color: Colors.black, size: 20),
                              Icon(Icons.star, color: Colors.black, size: 20),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(_title ?? 'Loading...',
                              style: _getTitleTextStyle(context)),
                          SizedBox(height: 10),
                          Text(_text ?? 'Loading...',
                              style: _getCustomTextStyle(context)),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.star, color: Colors.black, size: 20),
                              Icon(Icons.star, color: Colors.black, size: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;

    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        fontSize: ContentFontsSize,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        height: lineHeight);

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: ContentFontsSize,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: lineHeight);
    } else {
      return defaultStyle;
    }
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.black, fontSize: TitleFontsSize, fontWeight: FontWeight.w600);

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.black, fontSize: TitleFontsSize, fontWeight: FontWeight.w600);
    } else {
      return defaultStyle;
    }
  }
}
