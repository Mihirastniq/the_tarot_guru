import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OshoLearningContentScreen extends StatefulWidget {
  final int card;

  OshoLearningContentScreen({required this.card});

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<OshoLearningContentScreen> {
  late Future<Map<String, dynamic>> _cardData;
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize = 16;
  late double ButtonFontsSize = 15;

  @override
  void initState() {
    super.initState();
    _cardData = fetchData();
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

  Future<Map<String, dynamic>> fetchData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String language = sp.getString('lang') ?? 'en';

    try {
      String data = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      Map<String, dynamic>? card = jsonData[language]['cards'].firstWhere(
            (card) => card['id'] == widget.card,
        orElse: () => null,
      );

      if (card != null) {
        return {
          'card_image': card['card_image'],
          'card_category': card['card_category'],
          'card_name': card['card_name'],
          'card_content': card['card_content'],
          'card_description': card['card_description'],
          'card_index': card['card_index'],
          'card_translated_category': card['card_translated_category'],
        };

      }
    } catch (e) {
      print('Error fetching card data: $e');
    }

    return {};
  }

  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;

    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
      fontSize: ContentFontsSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: lineHeight,
    );

    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
        fontSize: ContentFontsSize,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: lineHeight,
      );
    } else {
      return defaultStyle;
    }
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
      color: Colors.white,
      fontSize: TitleFontsSize,
      fontWeight: FontWeight.w600,
    );

    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
        color: Colors.white,
        fontSize: TitleFontsSize,
        fontWeight: FontWeight.w600,
      );
    } else {
      return defaultStyle;
    }
  }

  Future<void> _markAsComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> completedCards = prefs.getStringList('osho_completed_cards') ?? [];
    if (!completedCards.contains(widget.card.toString())) {
      completedCards.add(widget.card.toString());
      await prefs.setStringList('osho_completed_cards', completedCards);
      await prefs.setInt('osho_last_completed_card', widget.card);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Marked as complete')),
      );
      Navigator.pop(context);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: _cardData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No content available'));
                      } else {
                        Map<String, dynamic> cardData = snapshot.data!;
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        width: 150,
                                        "assets/images/tarot_cards/Osho Zen/${cardData['card_category']}/${cardData['card_image']}",
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        width: MediaQuery.sizeOf(context).width * 0.9,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.sizeOf(context).width * 0.1,
                                                  child: Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                                  child: Text(
                                                    cardData['card_name'],
                                                    style: _getTitleTextStyle(context),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.sizeOf(context).width * 0.1,
                                                  child: Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${AppLocalizations.of(context)!.cardcategory}: ${cardData['card_translated_category']}',
                                              style: _getCustomTextStyle(context),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "${cardData['card_content']}",
                                              style: _getCustomTextStyle(context),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              '${AppLocalizations.of(context)!.descriptioninspread}',
                                              textAlign: TextAlign.center,
                                              style: _getTitleTextStyle(context),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(
                                              cardData['card_description'],
                                              style: _getCustomTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  Widget _buildBottomNavigationBar() {
    return Container(
      color: Color(0xFF171625),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: _markAsComplete,
          child: Text(
            'Mark as Complete',
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
