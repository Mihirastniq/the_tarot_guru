// Import required libraries
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/services.dart';
import 'package:the_tarot_guru/MainScreens/OtherScreens/settings.dart';
import 'package:the_tarot_guru/MainScreens/reuseable_blocks.dart';
import '../ActiveSpread.dart';
import '../osho_spread_details.dart';
import 'package:the_tarot_guru/MainScreens/spread/animations/card_animation.dart';
import 'package:the_tarot_guru/MainScreens/controller/functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Define the main widget class
class TheFlyingBirdScreen extends StatefulWidget {

  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  TheFlyingBirdScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });

  @override
  _TheFlyingBirdScreenState createState() => _TheFlyingBirdScreenState();
}

class _TheFlyingBirdScreenState extends State<TheFlyingBirdScreen> {
  late FlipCardController _card1Controller;
  late FlipCardController _card2Controller;
  late FlipCardController _card3Controller;
  late FlipCardController _card4Controller;
  late FlipCardController _card5Controller;
  late FlipCardController _card6Controller;
  late FlipCardController _card7Controller;

  bool card1Status = false;
  bool card2Status = false;
  bool card3Status = false;
  bool card4Status = false;
  bool card5Status = false;
  bool card6Status = false;
  bool card7Status = false;

  String imagesite = "https://thetarotguru.com/tarotapi/cards";
  List<dynamic> cardData = [];
  String buttonText ='Reveal card';

  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
  String image5 = '';
  String image6 = '';
  String image7 = '';

  String image1category = '';
  String image2category = '';
  String image3category = '';
  String image4category = '';
  String image5category = '';
  String image6category = '';
  String image7category = '';

  Future<void> fetchData() async {
    try {
      String data = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      List<Map<String, dynamic>> cardDataList = [];

      List<int> cardIds = widget.selectedCards.map((card) => card.id).toList();
      print('the list of card IDs is: $cardIds');

      // Loop through selected card IDs and match them with the data from the JSON
      for (int id in cardIds) {
        // Find the card with the corresponding ID
        Map<String, dynamic>? card = jsonData['en']['cards'].firstWhere(
              (card) => card['id'] == id.toString(),
          orElse: () => null,
        );

        // If the card is found, add it to the list
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

      // Update UI with the fetched data
      setState(() {
        if (cardDataList.length >= 7) {
          image1 = cardDataList[0]['card_image'];
          image2 = cardDataList[1]['card_image'];
          image3 = cardDataList[2]['card_image'];
          image4 = cardDataList[3]['card_image'];
          image5 = cardDataList[4]['card_image'];
          image6 = cardDataList[5]['card_image'];
          image7 = cardDataList[6]['card_image'];

          image1category = cardDataList[0]['card_category'];
          image2category = cardDataList[1]['card_category'];
          image3category = cardDataList[2]['card_category'];
          image4category = cardDataList[3]['card_category'];
          image5category = cardDataList[4]['card_category'];
          image6category = cardDataList[5]['card_category'];
          image7category = cardDataList[6]['card_category'];
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
    fetchData();
    // Initialize flip card controllers
    _card1Controller = FlipCardController();
    _card2Controller = FlipCardController();
    _card3Controller = FlipCardController();
    _card4Controller = FlipCardController();
    _card5Controller = FlipCardController();
    _card6Controller = FlipCardController();
    _card7Controller = FlipCardController();
  }

  void flipCard(FlipCardController controller,bool cardnumber) {
    if(cardnumber == false) {
      controller.toggleCard();
      setState(() {
        if (controller == _card1Controller) {
          card1Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card2Controller) {
          card2Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card3Controller) {
          card3Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card4Controller) {
          card4Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card5Controller) {
          card5Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card6Controller) {
          card6Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true) {
            setState(() {
              buttonText = 'View Details';
            });
          }
        } else if (controller == _card7Controller) {
          card7Status = true;
          if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true) {
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
    if (card1Status == true && card2Status == true && card3Status == true && card4Status == true && card5Status == true && card6Status == true && card7Status == true) {
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
    // Define screen dimensions and container height
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.7;
    double containerHeight = screenHeight / 7;
    double imageAspectRatio = 671 / 457;

    double containerWidth = screenWidth / 7 - 5;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;

    // Build the UI
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient container
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Flying bird',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.palette),
                  color: Colors.white,
                  onPressed: () {
                    // Implement your change theme functionality here
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                                  child: Center(
                                    child: Text("Container 6"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                                  child: Center(
                                    child: Text("Container 4"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                                  child: Center(
                                    child: Text("Container 2"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                                  child: Center(
                                    child: Text("Container 1"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0,25),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                                  child: Center(
                                    child: Text("Container 3"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0,0, 0, 50),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                                  child: Center(
                                    child: Text("Container 5"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0,75),
                                 width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                                  child: Center(
                                    child: Text("Container 7"),
                                  ),
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
                                  initialPosition: Offset((screenWidth/2)-((screenWidth / 7 - 5)/2), ((screenHeight/2)-(containerHeightWithAspectRatio/2))), // Align to bottom left
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
                          ), //1st
                          GestureDetector(
                            onTap: () => flipCard(_card2Controller, card2Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card2Controller,
                                  initialPosition: Offset((screenWidth/2)-(((screenWidth / 7 - 5)/2)+(screenWidth / 7 - 5)+4), ((screenHeight/2)-(containerHeightWithAspectRatio/2)-12.5)), // Align to bottom left
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
                          ), //2nd
                          GestureDetector(
                            onTap: () => flipCard(_card5Controller, card5Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card5Controller,
                                  initialPosition: Offset((screenWidth/2)+(((screenWidth / 7 + 5)/2)), ((screenHeight/2)-(containerHeightWithAspectRatio/2)-12.5)), // Align to bottom left
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
                          ), //3rd

                          GestureDetector(
                            onTap: () => flipCard(_card3Controller, card3Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card3Controller,
                                  initialPosition: Offset((screenWidth/2)-(((screenWidth / 7 - 5)/2)+(screenWidth / 7 - 5)+5)-((screenWidth / 7 - 5)+4), ((screenHeight/2)-(containerHeightWithAspectRatio/2)-25)), // Align to bottom left
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
                          ), //4th
                          GestureDetector(
                            onTap: () => flipCard(_card4Controller, card4Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card4Controller,
                                  initialPosition: Offset((screenWidth/2)-(((screenWidth / 7 - 5)/2)+(screenWidth / 7 - 5)+5)-((screenWidth / 7 - 5)+4)-((screenWidth / 7 - 5)+4), ((screenHeight/2)-(containerHeightWithAspectRatio/2)-37.5)), // Align to bottom left
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
                          ), //6th

                          GestureDetector(
                            onTap: () => flipCard(_card6Controller, card6Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card6Controller,
                                  initialPosition: Offset((screenWidth/2)+(((screenWidth / 7 + 5)/2)+(screenWidth / 7 -1)), ((screenHeight/2)-(containerHeightWithAspectRatio/2)-25)), // Align to bottom left
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
                          ), //5th
                          GestureDetector(
                            onTap: () => flipCard(_card7Controller, card7Status),
                            child: Align(
                              alignment: Alignment.center,
                              child: PositionedCardFinal(
                                  flipCardController: _card7Controller,
                                  initialPosition: Offset((screenWidth/2)+(((screenWidth / 7 +5)/2)+(screenWidth / 7 - 1))+((screenWidth / 7 - 5)+4), ((screenHeight/2)-(containerHeightWithAspectRatio/2)-37.5)), // Align to bottom left
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
                          ), //7th

                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  child: Center(
                                    child: Text("6",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  child: Center(
                                    child: Text("4",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  child: Center(
                                    child: Text("2",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  child: Center(
                                    child: Text("1",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0,25),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  child: Center(
                                    child: Text("3",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0,0, 0, 50),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  child: Center(
                                    child: Text("5",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0,75),
                                  width: screenWidth / 7 - 5,
                                  height: containerHeightWithAspectRatio,
                                  child: Center(
                                    child: Text("7",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                  ),
                                ),
                              ],
                            ),
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
