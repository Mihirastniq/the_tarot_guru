import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/controller/audio/audio_controller.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import '../controller/spread_controller/save_spread_controller.dart';
import 'ActiveSpread.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TheSpreadDetailsScreen extends StatefulWidget {
  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  TheSpreadDetailsScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });
@override
_TheSpreadDetailsScreenState createState() => _TheSpreadDetailsScreenState();

}

class _TheSpreadDetailsScreenState extends State<TheSpreadDetailsScreen> {


  late final AudioController _audioController;
  List<dynamic> cardData = [];
  final TextEditingController _spreadNameController = TextEditingController();
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize =16 ;
  late double ButtonFontsSize =25;

  @override
  void dispose() {
    _audioController.stopAudio();
    _spreadNameController.dispose();
    super.dispose();
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
  Future<List<dynamic>> fetchData() async {
    List<dynamic> allCardData = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String language = sp.getString('lang') ?? 'en';

    try {
      String data = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      List<int> cardIds = widget.selectedCards.map((card) => card.id).toList();
      for (int id in cardIds) {
        Map<String, dynamic>? card = jsonData[language]['cards'].firstWhere(
              (card) => card['id'] == id,
          orElse: () => null,
        );

        if (card != null) {
          allCardData.add({
            'card_image': card['card_image'],
            'card_category': card['card_category'],
            'card_name': card['card_name'],
            'card_content':card['card_content'],
            'card_description':card['card_description'],
            'card_index':card['card_index'],
            'card_translated_category':card['card_translated_category']
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
    _loadLocalData();
    _audioController = AudioController();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width * 0.9;
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('${AppLocalizations.of(context)!.cancel}'),
            ),
            TextButton(
              onPressed: () async {
                String name = _spreadNameController.text;
                await saveSpread(name, widget.tarotType, widget.spreadName, widget.selectedCards);
                Navigator.pop(context);
              },
              child: Text('${AppLocalizations.of(context)!.save}'),
            ),
          ],
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
                                              Container(
                                                width: MediaQuery.sizeOf(context).width *0.1,
                                                child: Icon(Icons.star,color: Colors.white,),
                                              ),
                                              Container(
                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                child: Text(currentCard['card_name'],style: _getTitleTextStyle(context),textAlign: TextAlign.center,),
                                              ),
                                              Container(
                                                width: MediaQuery.sizeOf(context).width *0.1,
                                                child: Icon(Icons.star,color: Colors.white,),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('${AppLocalizations.of(context)!.cardcategory} : ${currentCard['card_translated_category']}',style: _getCustomTextStyle(context),textAlign: TextAlign.left,),
                                          SizedBox(
                                            height: 20,
                                          ),

                                          Text("${currentCard['card_content']}",
                                              style: _getCustomTextStyle(context),textAlign: TextAlign.left),
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
                                            style: _getCustomTextStyle(context),
                                              textAlign: TextAlign.left

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
                    _audioController.stopAudio();
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

              actions: [
                IconButton(
                    onPressed: () {
                      _showSaveDialog(context);
                    },
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    )
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
        ],
      ),
    );

  }
  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
      fontSize: ContentFontsSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
        height: lineHeight
    );

    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
        fontSize: ContentFontsSize,
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
        fontSize: TitleFontsSize,
        fontWeight:
        FontWeight.w600,
        height: lineHeight
    );

    // Check the language and set appropriate font
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