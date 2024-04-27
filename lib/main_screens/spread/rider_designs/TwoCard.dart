// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_tarot_guru/main_screens/controller/audio/audio_controller.dart';
import 'package:the_tarot_guru/main_screens/spread/rider_spread_details.dart';
import '../ActiveSpread.dart';
import '../osho_spread_details.dart';
import 'package:the_tarot_guru/main_screens/spread/animations/card_animation.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RiderTwoCardScreen extends StatefulWidget {

  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  RiderTwoCardScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });

  @override
  _RiderTwoCardScreenState createState() => _RiderTwoCardScreenState();
}

class _RiderTwoCardScreenState extends State<RiderTwoCardScreen> with TickerProviderStateMixin {
  late FlipCardController _card1Controller;
  late FlipCardController _card2Controller;

  List<bool> _cardFlippedState = [false];
  bool cardflipchecker = false;
  List<dynamic> cardData = [];
  late final AudioController _audioController;

  String image1 = '';
  String image2 = '';

  String image1category = '';
  String image2category = '';

  String imagesite = "https://thetarotguru.com/tarotapi/cards";

  bool card1Status = false;
  bool card2Status = false;

  String buttonText ='Reveal card';

  Future<void> fetchData() async {
    try {
      String data = await rootBundle.loadString('assets/json/rider_images.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      List<Map<String, dynamic>> cardDataList = [];

      List<int> cardIds = widget.selectedCards.map((card) => card.id).toList();
      print('the list of card IDs is: $cardIds');

      // Loop through selected card IDs and match them with the data from the JSON
      for (int id in cardIds) {
        // Find the card with the corresponding ID
        Map<String, dynamic>? card = jsonData['en']['cards'].firstWhere(
              (card) => card['id'] == id,
          orElse: () => null,
        );

       print(card);
        if (card != null) {
          cardDataList.add({
            'card_image': card['card_image'],
            'card_category': card['card_category'],
          });
        }
      }

      // Print the fetched data
      print('Fetched Card Data:');
      cardDataList.forEach((cardData) {
        print('Card Image: ${cardData['card_image']}');
        print('Card Category: ${cardData['card_category']}');
      });
      print('object is : ${cardDataList}');
      // print(cardDataList);
      // Update UI with the fetched data
      setState(() {
        if (cardDataList.length >= 2) {
          image1 = cardDataList[0]['card_image'];
          image2 = cardDataList[1]['card_image'];
          image1category = cardDataList[0]['card_category'];
          image2category = cardDataList[1]['card_category'];
        } else {
          // Handle the case where not enough cards are fetched
          // Maybe set default values or show an error message
        }
      });
    } catch (e) {
      print('the list is : ${widget.selectedCards}');
      print('Error fetching card data: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    _audioController = AudioController();
    _card1Controller = FlipCardController();
    _card2Controller = FlipCardController();
    fetchData();
  }

  void flipCard(FlipCardController controller,bool cardnumber) {
    if(cardnumber == false) {
      controller.toggleCard();
      setState(() {
        if (controller == _card1Controller) {
          card1Status = true;
          if (card1Status == true && card2Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card2Controller) {
          card2Status = true;
          if (card1Status == true && card2Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        }
      });
      print('card status $cardnumber');
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
    if (card2Status == false) {
      _card2Controller.toggleCard();
      setState(() {
        card2Status = true;
      });
    }


    if (card1Status == true && card2Status == true) {
      setState(() {
        buttonText = 'View Details';
      });
    }
  }

  void NavigateToNext({required List<SelectedCard> selectedCards, required String tarotType, required String spreadName}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TheRiderSpreadDetailsScreen(selectedCards: selectedCards, tarotType: widget.tarotType, spreadName:widget.spreadName)),
    );
  }


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.7;
    double containerHeight = screenHeight / 7;
    double imageAspectRatio = 2600 / 1480;

    double containerWidth = screenWidth / 2 -10;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
          Column(
            children: [
              SizedBox(
                height: AppBar(
              leading: IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: Icon(Icons.arrow_circle_left,color: Colors.white,size: 30,),
              ),).preferredSize.height,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(
                          color: Colors.transparent,
                          width: screenWidth,
                          height: screenHeight,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(
                                                  width: 3,
                                                  color: Theme.of(context).primaryColor,
                                                )
                                            ),
                                            child: Center(
                                              child: Text("1"),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                            width: containerWidth ,
                                            height: containerHeightWithAspectRatio,
                                            decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(
                                                  width: 3,
                                                  color: Theme.of(context).primaryColor,
                                                )
                                            ),
                                            child: Center(
                                              child: Text("2"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => flipCard(_card1Controller, card1Status),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: PositionedCardFinal(
                                      flipCardController: _card1Controller,
                                      initialPosition: Offset((screenWidth/2)-(containerWidth+4),(screenHeight/2)-((containerHeightWithAspectRatio/2))),// Align to bottom left
                                      containerChild: Container(
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        color: Colors.transparent,
                                      ),
                                      imageChild: 'assets/images/cards/rider.jpg',
                                      delay: Duration(seconds: 1),
                                      containerWidth: containerWidth, // Same as container width above
                                      containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                      cardWidth: containerWidth, // Adjust card width as needed
                                      cardHeight: containerHeightWithAspectRatio,
                                      backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image1category}/${image1}'
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => flipCard(_card2Controller, card2Status),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: PositionedCardFinal(
                                      flipCardController: _card2Controller,
                                      initialPosition: Offset((screenWidth/2)+3,(screenHeight/2)-((containerHeightWithAspectRatio/2))), // Align to bottom left
                                      containerChild: Container(
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        color: Colors.transparent,
                                      ),
                                      imageChild: 'assets/images/cards/rider.jpg',
                                      delay: Duration(seconds: 2),
                                      containerWidth: containerWidth, // Same as container width above
                                      containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                      cardWidth: containerWidth, // Adjust card width as needed
                                      cardHeight: containerHeightWithAspectRatio,
                                      backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image2category}/${image2}'
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            child: Center(
                                              child: Text("1",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                            width: containerWidth ,
                                            height: containerHeightWithAspectRatio,
                                            child: Center(
                                              child: Text("2",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                '${AppLocalizations.of(context)!.twocard}',
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
        ],
      ),
    );
  }
}