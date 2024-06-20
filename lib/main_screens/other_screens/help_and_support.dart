import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpAndSuppportScreen extends StatefulWidget {
  const HelpAndSuppportScreen({super.key});

  @override
  State<HelpAndSuppportScreen> createState() => _HelpAndSuppportScreenState();
}

class _HelpAndSuppportScreenState extends State<HelpAndSuppportScreen> {

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

  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;

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

  TextStyle _getSubtitleTextStyle(BuildContext context) {
    double lineHeight = 1.8;

    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        fontSize: 21,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: lineHeight);

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: 20,
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
                '${AppLocalizations.of(context)!.helpandsupportlabel}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
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
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportlabel}',
                            style: _getTitleTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportintro}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 30),
                        Text('${AppLocalizations.of(context)?.helpandsupportsubscriptionlabel}',
                            style: _getTitleTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportsubscriptiontext1label} : ${AppLocalizations.of(context)?.helpandsupportsubscriptiontext1}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportsubscriptiontext2label} : ${AppLocalizations.of(context)?.helpandsupportsubscriptiontext2}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 30),
                        Text('${AppLocalizations.of(context)?.helpandsupportprivacylabel}',
                            style: _getTitleTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportprivacytext1label} : ${AppLocalizations.of(context)?.helpandsupportprivacytext1}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportprivacytext2label} : ${AppLocalizations.of(context)?.helpandsupportprivacytext2}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 30),
                        Text('${AppLocalizations.of(context)?.helpandsupportcontactuslabel}',
                            style: _getTitleTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportcontactustext1label}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportcontactustext1}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportcontactustext2label}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 10),
                        Text('${AppLocalizations.of(context)?.helpandsupportcontactustext2}',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 10),

                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
