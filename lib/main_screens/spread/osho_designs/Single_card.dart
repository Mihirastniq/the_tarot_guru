import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_tarot_guru/main_screens/controller/audio/audio_controller.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:the_tarot_guru/main_screens/spread/ActiveSpread.dart';
import '../osho_spread_details.dart';
import 'package:the_tarot_guru/main_screens/spread/animations/card_animation.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleCardScreen extends StatefulWidget {

  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  SingleCardScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });

  @override
  _SingleCardScreenState createState() => _SingleCardScreenState();
}

class _SingleCardScreenState extends State<SingleCardScreen> with TickerProviderStateMixin {
  late FlipCardController _card1Controller;
  bool cardflipchecker = false;
  String imagesite = "https://thetarotguru.com/tarotapi/cards";
  List<dynamic> cardData = [];
  String image1 = '';
  String imagecategory = '';
  bool card1Status = false;
  String buttonText ='Reveal card';

  Future<void> fetchData() async {
    try {
      String data = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      List<Map<String, dynamic>> cardDataList = [];

      List<int> cardIds = widget.selectedCards.map((card) => card.id).toList();

      for (int id in cardIds) {
        Map<String, dynamic>? card = jsonData['en']['cards'].firstWhere(
              (card) => card['id'] == id,
          orElse: () => null,
        );

        if (card != null) {
          cardDataList.add({
            'card_image': card['card_image'],
            'card_category': card['card_category'],
          });
        }
      }


      setState(() {
        if (cardDataList.isNotEmpty) {
          image1 = cardDataList[0]['card_image'];
          imagecategory = cardDataList[0]['card_category'];
        } else {
        }
      });
    } catch (e) {
      print('Error fetching card data: $e');
    }
  }
  void CardDetailsNavigation({required List<SelectedCard> selectedCards, required String tarotType, required String spreadName}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TheSpreadDetailsScreen(selectedCards: selectedCards, tarotType: widget.tarotType, spreadName:widget.spreadName)),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _card1Controller = FlipCardController();
  }


  void flipCard(FlipCardController controller,bool cardnumber) {
    if(cardnumber == false) {
      controller.toggleCard();
      setState(() {
        if (controller == _card1Controller) {
          card1Status = true;
        }
      });
      if (card1Status == true) {
        setState(() {
          buttonText = 'View Details';
        });
      }
    } else {
      print('card is already flipped');
    }
  }

  void revealcard() {
    if (card1Status == false) {
      _card1Controller.toggleCard();
      setState(() {
        card1Status = true;
      });
    }
    if (card1Status == true) {
      setState(() {
        buttonText = 'View Details';
      });
    }
  }

  void NavigateToNext({required List<SelectedCard> selectedCards, required String tarotType, required String spreadName}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TheSpreadDetailsScreen(selectedCards: selectedCards, tarotType: widget.tarotType, spreadName:widget.spreadName)),
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.75;
    double imageAspectRatio = 671 / 457;
    double containerWidth = screenWidth / 2 - 10;
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
                  Color.fromRGBO(19, 14, 42, 1),
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
              // opacity: ,
            ),
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
                '${AppLocalizations.of(context)!.singlecard}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                 
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
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight, // Position below the app bar
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: screenWidth,
                      height: screenHeight,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                              width: containerWidth,
                              height: containerHeightWithAspectRatio,
                              child: Center(
                                child: Text(""),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card1Controller, card1Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card1Controller,
                                  initialPosition: Offset(((screenWidth / 2)-containerWidth/2), (screenHeight/2)-containerHeightWithAspectRatio/2), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 1),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${imagecategory}/${image1}'
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(

                              width: containerWidth,
                              height: containerHeightWithAspectRatio,
                              child: Center(
                                child: Text("1",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 55,fontWeight: FontWeight.w800),),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                RevealCard(
                  text: buttonText,
                  onPressed: () {
                    if (buttonText == 'Reveal card') {
                      revealcard();
                    } else if (buttonText == 'View Details') {
                      NavigateToNext(selectedCards:widget.selectedCards,tarotType: widget.tarotType, spreadName:widget.spreadName);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}