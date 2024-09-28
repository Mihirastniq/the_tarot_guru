import 'package:flutter/material.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/services.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import '../ActiveSpread.dart';
import '../osho_spread_details.dart';
import 'package:the_tarot_guru/main_screens/spread/animations/card_animation.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TheKeyScreen extends StatefulWidget {

  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  TheKeyScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });

  @override
  _TheKeyScreenState createState() => _TheKeyScreenState();
}

class _TheKeyScreenState extends State<TheKeyScreen> {
  late FlipCardController _card1Controller;
  late FlipCardController _card2Controller;
  late FlipCardController _card3Controller;
  late FlipCardController _card4Controller;
  late FlipCardController _card5Controller;
  late FlipCardController _card6Controller;
  late FlipCardController _card7Controller;
  late FlipCardController _card8Controller;

  String buttonText ='Reveal card';
  List<dynamic> cardData = [];

  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
  String image5 = '';
  String image6 = '';
  String image7 = '';
  String image8 = '';

  String image1category = '';
  String image2category = '';
  String image3category = '';
  String image4category = '';
  String image5category = '';
  String image6category = '';
  String image7category = '';
  String image8category = '';

  bool card1Status = false;
  bool card2Status = false;
  bool card3Status = false;
  bool card4Status = false;
  bool card5Status = false;
  bool card6Status = false;
  bool card7Status = false;
  bool card8Status = false;


  String imagesite = "https://thetarotguru.com/tarotapi/cards";

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
        if (cardDataList.length >= 8) {
          image1 = cardDataList[0]['card_image'];
          image2 = cardDataList[1]['card_image'];
          image3 = cardDataList[2]['card_image'];
          image4 = cardDataList[3]['card_image'];
          image5 = cardDataList[4]['card_image'];
          image6 = cardDataList[5]['card_image'];
          image7 = cardDataList[6]['card_image'];
          image8 = cardDataList[7]['card_image'];

          image1category = cardDataList[0]['card_category'];
          image2category = cardDataList[1]['card_category'];
          image3category = cardDataList[2]['card_category'];
          image4category = cardDataList[3]['card_category'];
          image5category = cardDataList[4]['card_category'];
          image6category = cardDataList[5]['card_category'];
          image7category = cardDataList[6]['card_category'];
          image8category = cardDataList[7]['card_category'];
        } else {
        }
      });
    } catch (e) {
      print('Error fetching card data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _card1Controller = FlipCardController();
    _card2Controller = FlipCardController();
    _card3Controller = FlipCardController();
    _card4Controller = FlipCardController();
    _card5Controller = FlipCardController();
    _card6Controller = FlipCardController();
    _card7Controller = FlipCardController();
    _card8Controller = FlipCardController();
  }

  void flipCard(FlipCardController controller,bool cardnumber) {
    if(cardnumber == false) {
      controller.toggleCard();
      setState(() {
        if (controller == _card1Controller) {
          card1Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card2Controller) {
          card2Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card3Controller) {
          card3Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card4Controller) {
          card4Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card5Controller) {
          card5Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card6Controller) {
          card6Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card7Controller) {
          card7Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card8Controller) {
          card8Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        }

      });
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
    if (card3Status == false) {
      _card3Controller.toggleCard();
      setState(() {
        card3Status = true;
      });
    }
    if (card4Status == false) {
      _card4Controller.toggleCard();
      setState(() {
        card4Status = true;
      });
    }
    if (card5Status == false) {
      _card5Controller.toggleCard();
      setState(() {
        card5Status = true;
      });
    }
    if (card6Status == false) {
      _card6Controller.toggleCard();
      setState(() {
        card6Status = true;
      });
    }
    if (card7Status == false) {
      _card7Controller.toggleCard();
      setState(() {
        card7Status = true;
      });
    }
    if (card8Status == false) {
      _card8Controller.toggleCard();
      setState(() {
        card8Status = true;
      });
    }
    if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true && card8Status == true) {
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
    double screenHeight = MediaQuery.of(context).size.height * 0.7;
    double containerHeight = screenHeight / 7;
    double imageAspectRatio = 671 / 457;

    double containerWidth = screenWidth / 4 - 15;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;

    // Build the UI
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
          // App bar
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
                '${AppLocalizations.of(context)!.thekey}',
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
          // Main content area
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Expanded(
                  child: Center(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                          child: Text("1",style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800
                                          ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card1Controller, card1Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card1Controller,
                                  initialPosition: Offset((screenWidth/2)-(containerWidth/2), (screenHeight/2)+10-((containerHeight/2)+(containerHeight*3))), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 8),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image8category}/${image8}'
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card2Controller, card2Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card2Controller,
                                  initialPosition: Offset((screenWidth/2)-((containerWidth/2)+containerWidth+10), (screenHeight/2)-(containerHeightWithAspectRatio+(containerHeightWithAspectRatio/2)+10)), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 5),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image5category}/${image5}'
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card3Controller, card3Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card3Controller,
                                  initialPosition: Offset((screenWidth/2)-(containerWidth/2), (screenHeight/2)-(containerHeightWithAspectRatio+(containerHeightWithAspectRatio/2)+10)), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 6),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image6category}/${image6}'
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card4Controller, card4Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card4Controller,
                                  initialPosition: Offset((screenWidth/2)+((containerWidth/2)+10), (screenHeight/2)-(containerHeightWithAspectRatio+(containerHeightWithAspectRatio/2)+10)), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 7),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image7category}/${image7}'
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card5Controller, card5Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card5Controller,
                                  initialPosition: Offset((screenWidth/2)-(containerWidth/2), (screenHeight/2)-(containerHeightWithAspectRatio/2)), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 4),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image4category}/${image4}'
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card6Controller, card6Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card6Controller,
                                  initialPosition:  Offset((screenWidth/2)-(containerWidth/2), (screenHeight/2)+((containerHeightWithAspectRatio/2)+10)), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 2),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image2category}/${image2}'
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card7Controller, card7Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card7Controller,
                                  initialPosition:Offset((screenWidth/2)+((containerWidth/2)+10), (screenHeight/2)+((containerHeightWithAspectRatio/2)+10)), // Align to bottom left
                                  containerChild: Container(
                                    width: containerWidth,
                                    height: containerHeightWithAspectRatio,
                                    color: Colors.transparent,
                                  ),
                                  imageChild: 'assets/images/cards/osho.jpg',
                                  delay: Duration(seconds: 3),
                                  containerWidth: containerWidth, // Same as container width above
                                  containerHeight: containerHeightWithAspectRatio, // Same as container height above
                                  cardWidth: containerWidth, // Adjust card width as needed
                                  cardHeight: containerHeightWithAspectRatio,
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image3category}/${image3}'
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => flipCard(_card8Controller, card8Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card8Controller,
                                  initialPosition: Offset((screenWidth/2)-(containerWidth/2), (screenHeight/2)+(containerHeightWithAspectRatio+(containerHeightWithAspectRatio/2)+20)), // Align to bottom left
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
                                  backImageChild: 'assets/images/tarot_cards/${widget.tarotType}/${image1category}/${image1}'
                              ),
                            ),
                          ),

                          Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        child: Center(
                                          child: Text("8",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        child: Center(
                                          child: Text("5",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        child: Center(
                                          child: Text("6",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,

                                        child: Center(
                                          child: Text("7",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,

                                        child: Center(
                                          child: Text("4",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,

                                        child: Center(
                                          child: Text("2",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        child: Center(
                                          child: Text("3",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: containerWidth,
                                        height: containerHeightWithAspectRatio,
                                        child: Center(
                                          child: Text("1",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Full width button for flipping unflipped cards
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
