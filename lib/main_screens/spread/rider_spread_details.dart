import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../other_screens/settings.dart';
import '../controller/functions.dart';
import 'ActiveSpread.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TheRiderSpreadDetailsScreen extends StatefulWidget {
  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  TheRiderSpreadDetailsScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });
  @override
  _TheSpreadDetailsScreenState createState() => _TheSpreadDetailsScreenState();
}

class _TheSpreadDetailsScreenState extends State<TheRiderSpreadDetailsScreen> {
  List<dynamic> cardData = [];


  Future<List<dynamic>> fetchData() async {
    List<dynamic> allCardData = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String language = sp.getString('lang') ?? 'en';

    try {
      String data = await rootBundle.loadString('assets/json/rider_waite_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      // Access the top-level cards array directly
      List<dynamic>? cards = jsonData[language]['cards'];

      // Check if cards exist and iterate through them
      if (cards != null) {
        List<int> cardIds = widget.selectedCards.map((card) => card.id).toList();
        for (int id in cardIds) {
          Map<String, dynamic>? card = cards.firstWhere(
                (card) => card['id'] == id.toString(),
            orElse: () => null,
          );

          if (card != null) {
            allCardData.add({
              'card_image': card['card_image'] ?? '',
              'card_category': card['card_category'] ?? '',
              'card_name': card['card_name'] ?? '',
              'card_english_content': card['card_english_content'] ?? '',
              'card_discription': card['card_discription'] ?? '',
              'card_index': card['card_index'] ?? '',
              'reversed_content': card['reversed_content'] ?? '',
              'niscurse_content': card['niscurse_content'] ?? '',
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching card data: $e');
    }

    return allCardData;
  }



  void init() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.7;
    double containerHeight = screenHeight / 7;
    double imageAspectRatio = 2600 / 1480;

    double containerWidth = screenWidth / 2.5 - 5;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;
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
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
          //     fit: BoxFit.cover,
          //     opacity: const AlwaysStoppedAnimation(.3),
          //   ),
          // ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "${AppLocalizations.of(context)!.spreaddetails}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.save),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingScreenClass()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.palette),
                  color: Colors.white,
                  onPressed: () {
                    changeTheme(context);
                  },
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Center(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.fromLTRB(22, 60, 22, 60),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/other/contentbg.png'),
                          fit: BoxFit.fitHeight,
                        )
                        // color: Colors.white
                        ),
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // or any other loading indicator
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<dynamic> cardData = snapshot.data!;
                          return ListView.builder(
                            itemCount: cardData.length,
                            itemBuilder: (context, index) {
                              var currentCard = cardData[index];
                              // Build UI for each card here
                              return Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            margin: EdgeInsets.fromLTRB(
                                                15, 15, 25, 0),
                                            width: containerWidth,
                                            height:
                                                containerHeightWithAspectRatio,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/other/cardbg.png'),
                                                    fit: BoxFit.cover)
                                                // color: Colors.white
                                                ),
                                            // child: Text('image here'),
                                            child: Image.asset(
                                              'assets/images/tarot_cards/${widget.tarotType}/${currentCard['card_category']}/${currentCard['card_image']}',
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  currentCard['card_name'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  '${AppLocalizations.of(context)!.cardcategory} : ${currentCard['card_category']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${currentCard['card_english_content']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${AppLocalizations.of(context)!.discriptioninspread}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "${currentCard['card_discription']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),

                                          Container(
                                            // Reversed Hindi Content if not null
                                            child: currentCard['reversed_hindi_content'] != null
                                                ? Column(
                                              children: [
                                                Text(
                                                  "${AppLocalizations.of(context)!.reversedinspread}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Text(
                                                  "${currentCard['reversed_hindi_content']}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            )
                                                : SizedBox.shrink(), // Placeholder if null
                                          ),
                                          Container(
                                            // Reversed Hindi Content if not null
                                            child: currentCard['card_niscurse_hindi'] != null
                                                ? Column(
                                              children: [
                                                Text(
                                                  "${AppLocalizations.of(context)!.niscurseinspread}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Text(
                                                  "${currentCard['card_niscurse_hindi']}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            )
                                                : SizedBox.shrink(), // Placeholder if null
                                          ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 60.0,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF7CB89C), Color(0xFF7CB89C)],
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Make button transparent
                                elevation: 0, // Remove elevation
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                '${AppLocalizations.of(context)!.backtohome}',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}