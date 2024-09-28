import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:the_tarot_guru/home.dart';

class SpecialPredictionRiderPrediction extends StatefulWidget {
  final List<int> randomNumbers;

  const SpecialPredictionRiderPrediction({
    super.key,
    required this.randomNumbers,
  });

  @override
  State<SpecialPredictionRiderPrediction> createState() => _SpecialPredictionRiderPredictionState();
}

class _SpecialPredictionRiderPredictionState extends State<SpecialPredictionRiderPrediction> {
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
    final String response = await rootBundle.loadString('assets/json/rider_waite_data.json');
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
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: TitleFontsSize,
    );
  }

  TextStyle _getCustomTextStyle(BuildContext context) {
    return TextStyle(
      color: Colors.black,
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
                                  "assets/images/tarot_cards/Rider Waite/${cardData['card_category']}/${cardData['card_image']}",
                                  width: 150,
                                ),
                                SizedBox(height: 16),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.star, color: Colors.black),
                                          Container(
                                            width: MediaQuery.sizeOf(context).width * 0.5,
                                            child: Text(
                                              cardData['card_name'],
                                              style: _getTitleTextStyle(context),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Icon(Icons.star, color: Colors.black),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${AppLocalizations.of(context)!.cardcategory}: ${cardData['card_translated_category']}',
                                        style: _getCustomTextStyle(context),
                                      ),
                                      SizedBox(height: 20),
                                      cardData['card_content'] != null && cardData['card_content'].isNotEmpty?
                                      Column(
                                        children: [
                                          Text(
                                            cardData['card_content'] ?? '', // If 'card_discription' is null, use an empty string
                                            style: _getCustomTextStyle(context),
                                          ),
                                        ],
                                      ) : SizedBox( height: 1,),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      cardData['card_description'] != null && cardData['card_description'].isNotEmpty ?
                                      Column(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context)!.descriptioninspread}',
                                              textAlign: TextAlign.center,
                                              style: _getTitleTextStyle(context)
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            cardData['card_description'] ?? '', // If 'card_discription' is null, use an empty string
                                            style: _getCustomTextStyle(context),
                                          ),
                                        ],
                                      ) : SizedBox(
                                        height: 1,
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      cardData['reversed_content'] != null && cardData['reversed_content'].isNotEmpty?
                                      Column(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context)!.reversedinspread}',
                                              textAlign: TextAlign.center,
                                              style: _getTitleTextStyle(context)
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            cardData['reversed_content'] ?? '', // If 'card_discription' is null, use an empty string
                                            style: _getCustomTextStyle(context),
                                          ),
                                        ],
                                      ) : SizedBox(
                                        height: 1,
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      cardData['niscure_content'] != null && cardData['niscure_content'].isNotEmpty?
                                      Column(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context)!.niscureinspread}',
                                              textAlign: TextAlign.center,
                                              style: _getTitleTextStyle(context)
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            cardData['niscure_content'] ?? '', // If 'card_discription' is null, use an empty string
                                            style: _getCustomTextStyle(context),
                                          ),
                                        ],
                                      ) : SizedBox(
                                        height: 1,
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      cardData['vivran_content'] != null && cardData['vivran_content'].isNotEmpty?
                                      Column(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context)!.vivraninspread}',
                                              textAlign: TextAlign.center,
                                              style: _getTitleTextStyle(context)
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            cardData['vivran_content'] ?? '', // If 'card_discription' is null, use an empty string
                                            style: _getCustomTextStyle(context),
                                          ),
                                        ],
                                      ) : SizedBox(
                                        height: 1,
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      cardData['parinam_content'] != null && cardData['parinam_content'].isNotEmpty?
                                      Column(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context)!.parinaminspread}',
                                              textAlign: TextAlign.center,
                                              style: _getTitleTextStyle(context)
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            cardData['parinam_content'] ?? '', // If 'card_discription' is null, use an empty string
                                            style: _getCustomTextStyle(context),
                                          ),
                                        ],
                                      ) : SizedBox(
                                        height: 1,
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      cardData['vishesta_content'] != null && cardData['vishesta_content'].isNotEmpty?
                                      Column(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context)!.vishestainspread}',
                                              textAlign: TextAlign.center,
                                              style: _getTitleTextStyle(context)
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            cardData['vishesta_content'] ?? '', // If 'card_discription' is null, use an empty string
                                            style: _getCustomTextStyle(context),
                                          ),
                                        ],
                                      ) : SizedBox(
                                        height: 1,
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
                  builder: (context) => AppSelect(),
                ),
              );
            },
            child: Text(
              'Home',
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
