import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:the_tarot_guru/main_screens/spread/animations/card_animation.dart';
import 'package:the_tarot_guru/main_screens/spread/rider_spread_details.dart';
import '../ActiveSpread.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RiderTwelveCardScreen extends StatefulWidget {

  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  RiderTwelveCardScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });

  @override
_RiderTwelveCardScreenState createState() => _RiderTwelveCardScreenState();
}

class _RiderTwelveCardScreenState extends State<RiderTwelveCardScreen> with TickerProviderStateMixin {
bool cardflipchecker = false;
List<dynamic> cardData = [];

late FlipCardController _card1Controller;
late FlipCardController _card2Controller;
late FlipCardController _card3Controller;
late FlipCardController _card4Controller;
late FlipCardController _card5Controller;
late FlipCardController _card6Controller;
late FlipCardController _card7Controller;
late FlipCardController _card8Controller;
late FlipCardController _card9Controller;
late FlipCardController _card10Controller;
late FlipCardController _card11Controller;
late FlipCardController _card12Controller;

String image1 = '';
String image2 = '';
String image3 = '';
String image4 = '';
String image5 = '';
String image6 = '';
String image7 = '';
String image8 = '';
String image9 = '';
String image10 = '';
String image11 = '';
String image12 = '';

String image1category = '';
String image2category = '';
String image3category = '';
String image4category = '';
String image5category = '';
String image6category = '';
String image7category = '';
String image8category = '';
String image9category = '';
String image10category = '';
String image11category = '';
String image12category = '';

bool card1Status = false;
bool card2Status = false;
bool card3Status = false;
bool card4Status = false;
bool card5Status = false;
bool card6Status = false;
bool card7Status = false;
bool card8Status = false;
bool card9Status = false;
bool card10Status = false;
bool card11Status = false;
bool card12Status = false;
String buttonText = 'Reveal card';
String imagesite = "https://thetarotguru.com/tarotapi/cards";

Future<void> fetchData() async {
  try {
    String data = await rootBundle.loadString('assets/json/rider_images.json');
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
      if (cardDataList.length >= 0) {
        setState(() {
          image1 = cardDataList[0]['card_image'];
          image2 = cardDataList[1]['card_image'];
          image3 = cardDataList[2]['card_image'];
          image4 = cardDataList[3]['card_image'];
          image5 = cardDataList[4]['card_image'];
          image6 = cardDataList[5]['card_image'];
          image7 = cardDataList[6]['card_image'];
          image8 = cardDataList[7]['card_image'];
          image9 = cardDataList[8]['card_image'];
          image10 = cardDataList[9]['card_image'];
          image11 = cardDataList[10]['card_image'];
          image12 = cardDataList[11]['card_image'];

          image1category = cardDataList[0]['card_category'];
          image2category = cardDataList[1]['card_category'];
          image3category = cardDataList[2]['card_category'];
          image4category = cardDataList[3]['card_category'];
          image5category = cardDataList[4]['card_category'];
          image6category = cardDataList[5]['card_category'];
          image7category = cardDataList[6]['card_category'];
          image8category = cardDataList[7]['card_category'];
          image9category = cardDataList[8]['card_category'];
          image10category = cardDataList[9]['card_category'];
          image11category = cardDataList[10]['card_category'];
          image12category = cardDataList[11]['card_category'];
        });
      } else {
        // Handle the case where not enough cards are fetched
        // Maybe set default values or show an error message
      }
    });
  } catch (e) {
    
    print('Error fetching card data: $e');
  }
}


@override
void initState() {
  super.initState();

  _card1Controller = FlipCardController();
  _card2Controller = FlipCardController();
  _card3Controller = FlipCardController();
  _card4Controller = FlipCardController();
  _card5Controller = FlipCardController();
  _card6Controller = FlipCardController();
  _card7Controller = FlipCardController();
  _card8Controller = FlipCardController();
  _card9Controller = FlipCardController();
  _card10Controller = FlipCardController();
  _card11Controller = FlipCardController();
  _card12Controller = FlipCardController();
  fetchData();
}

void flipCard(FlipCardController controller, bool cardnumber) {
  if (cardnumber == false) {
    controller.toggleCard();
    setState(() {
      if (controller == _card1Controller) {
        card1Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card2Controller) {
        card2Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card3Controller) {
        card3Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card4Controller) {
        card4Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card5Controller) {
        card5Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card6Controller) {
        card6Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card7Controller) {
        card7Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card8Controller) {
        card8Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card9Controller) {
        card9Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card10Controller) {
        card10Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card11Controller) {
        card11Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
          setState(() {
            buttonText = 'View Details';
          });
        }
      } else if (controller == _card12Controller) {
        card12Status = true;
        if (card1Status == true &&
            card2Status == true &&
            card3Status == true &&
            card4Status == true &&
            card5Status == true &&
            card6Status == true &&
            card7Status == true &&
            card8Status == true &&
            card9Status == true &&
            card10Status == true &&
            card11Status == true &&
            card12Status == true) {
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
  if (card9Status == false) {
    _card9Controller.toggleCard();
    setState(() {
      card9Status = true;
    });
  }
  if (card10Status == false) {
    _card10Controller.toggleCard();
    setState(() {
      card10Status = true;
    });
  }
  if (card11Status == false) {
    _card11Controller.toggleCard();
    setState(() {
      card11Status = true;
    });
  }
  if (card12Status == false) {
    _card12Controller.toggleCard();
    setState(() {
      card12Status = true;
    });
  }
  if (card1Status == true &&
      card2Status == true &&
      card3Status == true &&
      card4Status == true &&
      card5Status == true &&
      card6Status == true &&
      card7Status == true &&
      card8Status == true &&
      card9Status == true &&
      card10Status == true &&
      card11Status == true &&
      card12Status == true) {
    setState(() {
      buttonText = 'View Details';
    });
  }
}

void NavigateToNext(
    {required List<SelectedCard> selectedCards,
      required String tarotType,
      required String spreadName}) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => TheRiderSpreadDetailsScreen(
            selectedCards: selectedCards,
            tarotType: widget.tarotType,
            spreadName: widget.spreadName)),
  );
}

@override
Widget build(BuildContext context) {

  double screenWidth = MediaQuery.of(context).size.width * 0.9;
  double screenHeight = MediaQuery.of(context).size.height * 0.7;
  double containerHeight = screenHeight / 7;
  double imageAspectRatio = 2600 / 1480;

  double containerWidth = screenWidth / 7;
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
              '${AppLocalizations.of(context)!.twelvecardspread}',
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
              Expanded(
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: screenWidth,
                      height: screenHeight,
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
                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*5)-containerWidth/2-12,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //1st
                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*3)-containerWidth/2-6,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //2nd
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2-containerWidth/2-3,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //3rd
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2+containerWidth/2+3,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //4th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)-containerWidth/2-18,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //5th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)+containerWidth/2-12,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //6th

                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*5)-containerWidth/2-12,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //7th
                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*3)-containerWidth/2-6,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //8th
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2-containerWidth/2-3,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //9th
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2+containerWidth/2+3,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //10th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)-containerWidth/2-18,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //11th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)+containerWidth/2-12,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
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
                                  ), //12th

                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card1Controller, card1Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card1Controller,
                                          initialPosition: Offset(screenWidth/2-((containerWidth/2)*5)-containerWidth/2-12,screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 1),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image1category}/${image1}'),
                                    ),
                                  ), //1st
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card2Controller, card2Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card2Controller,
                                          initialPosition: Offset(screenWidth/2-((containerWidth/2)*3)-containerWidth/2-6,screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 2),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image2category}/${image2}'),
                                    ),
                                  ), //2nd
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card3Controller, card3Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card3Controller,
                                          initialPosition: Offset(screenWidth/2-containerWidth/2-containerWidth/2-3,screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 3),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image3category}/${image3}'),
                                    ),
                                  ), //3rd
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card4Controller, card4Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card4Controller,
                                          initialPosition: Offset(screenWidth/2-containerWidth/2+containerWidth/2+3,screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 4),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image4category}/${image4}'),
                                    ),
                                  ), //4th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card5Controller, card5Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card5Controller,
                                          initialPosition: Offset(screenWidth/2+((containerWidth/2)*4)-containerWidth/2-18,screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 5),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image5category}/${image5}'),
                                    ),
                                  ), //5th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card6Controller, card6Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card6Controller,
                                          initialPosition: Offset(screenWidth/2+((containerWidth/2)*4)+containerWidth/2-12,screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 6),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image6category}/${image6}'),
                                    ),
                                  ), //6th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card7Controller, card7Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card7Controller,
                                          initialPosition: Offset(screenWidth/2-((containerWidth/2)*5)-containerWidth/2-12,screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 7),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image7category}/${image7}'),
                                    ),
                                  ), //7th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card8Controller, card8Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card8Controller,
                                          initialPosition: Offset(screenWidth/2-((containerWidth/2)*3)-containerWidth/2-6,screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 8),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image8category}/${image8}'),
                                    ),
                                  ), //8th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card9Controller, card9Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card9Controller,
                                          initialPosition: Offset(screenWidth/2-containerWidth/2-containerWidth/2-3,screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 9),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image9category}/${image9}'),
                                    ),
                                  ), //9th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card10Controller, card10Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card10Controller,
                                          initialPosition: Offset(screenWidth/2-containerWidth/2+containerWidth/2+3,screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 10),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image10category}/${image10}'),
                                    ),
                                  ), //10th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card11Controller, card11Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card11Controller,
                                          initialPosition: Offset(screenWidth/2+((containerWidth/2)*4)-containerWidth/2-18,screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 11),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image11category}/${image11}'),
                                    ),
                                  ), //11th
                                  GestureDetector(
                                    onTap: () =>
                                        flipCard(_card12Controller, card12Status),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PositionedCardFinal(
                                          flipCardController: _card12Controller,
                                          initialPosition: Offset(screenWidth/2+((containerWidth/2)*4)+containerWidth/2-12,screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio), // Align to bottom left
                                          containerChild: Container(
                                            width: containerWidth,
                                            height: containerHeightWithAspectRatio,
                                            color: Colors.transparent,
                                          ),
                                          imageChild: 'assets/images/cards/rider.jpg',
                                          delay: Duration(seconds: 12),
                                          containerWidth:
                                          containerWidth, // Same as container width above
                                          containerHeight:
                                          containerHeightWithAspectRatio, // Same as container height above
                                          cardWidth:
                                          containerWidth, // Adjust card width as needed
                                          cardHeight: containerHeightWithAspectRatio,
                                          backImageChild:
                                          'assets/images/tarot_cards/${widget.tarotType}/${image12category}/${image12}'),
                                    ),
                                  ), //12th

                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*5)-containerWidth/2-12,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(
                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("1",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //1st
                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*3)-containerWidth/2-6,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("2",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //2nd
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2-containerWidth/2-3,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("3",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //3rd
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2+containerWidth/2+3,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("4",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //4th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)-containerWidth/2-18,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("5",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //5th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)+containerWidth/2-12,
                                    top: screenHeight/2-5-containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("6",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //6th

                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*5)-containerWidth/2-12,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("7",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //7th
                                  Positioned(
                                    left: screenWidth/2-((containerWidth/2)*3)-containerWidth/2-6,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("8",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //8th
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2-containerWidth/2-3,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("9",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //9th
                                  Positioned(
                                    left: screenWidth/2-containerWidth/2+containerWidth/2+3,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("10",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //10th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)-containerWidth/2-18,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("11",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //11th
                                  Positioned(
                                    left: screenWidth/2+((containerWidth/2)*4)+containerWidth/2-12,
                                    top: screenHeight/2+containerHeightWithAspectRatio/2-containerHeightWithAspectRatio,
                                    child: Container(

                                      width: containerWidth,
                                      height: containerHeightWithAspectRatio,
                                      child: Center(
                                        child: Text("12",style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 35,fontWeight: FontWeight.w800),),
                                      ),
                                    ),
                                  ), //12th
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),

              RevealCard(
                text: buttonText,
                onPressed: () {
                  if (buttonText == 'Reveal card') {
                    revealcard();
                  } else if (buttonText == 'View Details') {
                    NavigateToNext(
                        selectedCards: widget.selectedCards,
                        tarotType: widget.tarotType,
                        spreadName: widget.spreadName);
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