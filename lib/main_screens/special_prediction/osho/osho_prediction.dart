import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class SpecialPredictionOshoPrediction extends StatefulWidget {
  final List<int> randomNumbers;

  const SpecialPredictionOshoPrediction({
    super.key,
    required this.randomNumbers,
  });

  @override
  State<SpecialPredictionOshoPrediction> createState() =>
      _SpecialPredictionOshoPredictionState();
}

class _SpecialPredictionOshoPredictionState
    extends State<SpecialPredictionOshoPrediction> {
  bool _isScrolled = false;
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize = 16;
  late double ButtonFontsSize = 10;
  List<Map<String, dynamic>> _filteredCards = [];

  @override
  void initState() {
    super.initState();
    _loadLocalData();
    _loadCardsData();
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

  _loadCardsData() async {
    final String response = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
    final data = await json.decode(response);
    final cards = data['en']['cards'] as List<dynamic>;

    setState(() {
      _filteredCards = cards
          .where((card) => widget.randomNumbers.contains(card['id']))
          .map((card) => card as Map<String, dynamic>)
          .toList();
    });
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: TitleFontsSize,
    );
  }

  TextStyle _getCustomTextStyle(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: ContentFontsSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> durations = ['1 month', '3 months', '6 months', '12 months'];

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
                  child: ListView.builder(
                    itemCount: _filteredCards.length,
                    itemBuilder: (context, index) {
                      final cardData = _filteredCards[index];
                      final duration = durations[index % durations.length];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  duration,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TitleFontsSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Image.asset(
                                  "assets/images/tarot_cards/Osho Zen/${cardData['card_category']}/${cardData['card_image']}",
                                  width: 150,
                                ),
                                SizedBox(height: 16),
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
                                          Icon(Icons.star, color: Colors.white),
                                          Container(
                                            width: MediaQuery.sizeOf(context).width * 0.5,
                                            child: Text(
                                              cardData['card_name'],
                                              style: _getTitleTextStyle(context),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Icon(Icons.star, color: Colors.white),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${AppLocalizations.of(context)!.cardcategory}: ${cardData['card_translated_category']}',
                                        style: _getCustomTextStyle(context),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        cardData['card_content'],
                                        style: _getCustomTextStyle(context),
                                      ),
                                      SizedBox(height: 20),
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
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
}
