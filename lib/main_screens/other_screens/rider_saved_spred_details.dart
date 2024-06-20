import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';

class RiderSavedSpreadDetails extends StatefulWidget {
  final List selectedCards;
  final String tarotType;
  final String spreadName;

  RiderSavedSpreadDetails({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });
  @override
  _TheSavedSpreadDetailsScreenRiderState createState() => _TheSavedSpreadDetailsScreenRiderState();

}

class _TheSavedSpreadDetailsScreenRiderState extends State<RiderSavedSpreadDetails> {

  List<dynamic> cardData = [];
  final TextEditingController _spreadNameController = TextEditingController();


  Future<List<dynamic>> fetchData() async {
    List<dynamic> allCardData = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String language = sp.getString('lang') ?? 'en';

    try {
      String data =
      await rootBundle.loadString('assets/json/rider_waite_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      for (int id in widget.selectedCards) {
        Map<String, dynamic>? card = jsonData[language]['cards'].firstWhere(
              (card) => card['id'] == id,
          orElse: () => null,
        );

        if (card != null) {
          allCardData.add({
            'card_image': card['card_image'],
            'card_category': card['card_category'],
            'card_name': card['card_name'],
            'card_content': card['card_content'],
            'card_description': card['card_description'],
            'card_index': card['card_index'],
          });
        }
      }
    } catch (e) {
      print('Error fetching card data: $e');
    }

    return allCardData;
  }


  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.7;
    double containerHeight = screenHeight / 7;
    double imageAspectRatio = 671 / 457;

    double containerWidth = screenWidth/1.5 - 5;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;

    void _showSaveDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('${AppLocalizations.of(context)!.spreadsave}'),
          content: TextField(
            controller: _spreadNameController,
            decoration: InputDecoration(
              hintText: '${AppLocalizations.of(context)!.spreadtextinputname}',
            ),
          ),
        ),
      );
    }


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
                  Theme.of(context).primaryColor.withOpacity(0.2),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg3.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),

          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50,bottom: 10),
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
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
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      margin: EdgeInsets.fromLTRB(
                                          15, 0, 25, 0),
                                      width: containerWidth,
                                      height:
                                      containerHeightWithAspectRatio,
                                      decoration: BoxDecoration(

                                      ),
                                      // child: Text('image here'),
                                      child: Image.asset(
                                        'assets/images/tarot_cards/${widget.tarotType}/${currentCard['card_category']}/${currentCard['card_image']}',
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      width: MediaQuery.sizeOf(context).width*0.9,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.star,color: Colors.white,),
                                              Text(currentCard['card_name'],style: _getTitleTextStyle(context)),
                                              Icon(Icons.star,color: Colors.white,)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('${AppLocalizations.of(context)!.cardcategory} : ${currentCard['card_translated_category']}',style: _getCustomTextStyle(context),),
                                          SizedBox(
                                            height: 20,
                                          ),

                                          Text("${currentCard['card_content']}",
                                              style: _getCustomTextStyle(context)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                                '${AppLocalizations.of(context)!.descriptioninspread}',
                                                style: _getCustomTextStyle(context)
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${currentCard['card_description']}",
                                              style: _getCustomTextStyle(context)
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
                  FullWidthButton(text: 'Back to home', onPressed: (){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AppSelect()),
                          (route) => false, // Remove all routes
                    );
                  })
                ],
              )
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: Icon(Icons.arrow_circle_left,color: Colors.white,size: 30,),
              ),
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
            ),
          ),
        ],
      ),
    );

  }
  TextStyle _getCustomTextStyle(BuildContext context) {
    // Define default text style
    double lineHeight = 1.8;
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        fontSize: 21,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: lineHeight
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: lineHeight
      );
    } else {
      return defaultStyle;
    }
  }
  TextStyle _getTitleTextStyle(BuildContext context) {
    // Define default text style
    double lineHeight = 1.8;
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.white,
        fontSize: 23,
        fontWeight:
        FontWeight.w600,
        height: lineHeight
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.white,
          fontSize: 23,
          fontWeight:
          FontWeight.w600,
          height: lineHeight
      );
    } else {
      return defaultStyle;
    }
  }
}