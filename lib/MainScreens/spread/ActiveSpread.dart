import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/controller/audio/audio_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/MainScreens/controller/functions.dart';
import 'package:flutter/rendering.dart';

import 'package:the_tarot_guru/MainScreens/spread/osho_designs/Flying_bard.dart';
import 'osho_designs/Paradox.dart';
import 'osho_designs/Celtic_cross.dart';
import 'osho_designs/Single_card.dart';
import 'osho_designs/Diamond.dart';
import 'osho_designs/Three_card.dart';
import 'osho_designs/Key.dart';
import 'osho_designs/Mirror.dart';
import 'osho_designs/Relationship.dart';
import 'osho_designs/Unification.dart';

import 'rider_designs/SingleCard.dart';
import 'rider_designs/TwoCard.dart';
import 'rider_designs/ThreeCard.dart';
import 'rider_designs/FourCard.dart';
import 'rider_designs/FiveCard.dart';
import 'rider_designs/SixCard.dart';
import 'rider_designs/SevenCard.dart';
import 'rider_designs/EightCard.dart';
import 'rider_designs/NineCard.dart';
import 'rider_designs/TwelveCard.dart';
import 'rider_designs/CelticCross.dart';
import 'rider_designs/CircularSpread.dart';
import 'rider_designs/HarshShuSpread.dart';
import 'rider_designs/MoneySpread.dart';
import 'rider_designs/TheElcemist.dart';

class ActiveSpread extends StatefulWidget {
  final String spreadName;
  final int numberOfCards;
  final String tarotType;

  ActiveSpread({
    required this.spreadName,
    required this.numberOfCards,
    required this.tarotType,
  });
  @override
  _ActiveSpreadState createState() => _ActiveSpreadState();
}

class _ActiveSpreadState extends State<ActiveSpread> {
  bool _isAnimating = false;
  Random _random = Random();

  late List<CardInfo> cards = [];
  late final List<bool>
  fixedPositions; // Track if a card is in a fixed position

  int countdown = 5;
  bool showText = true;
  late final AudioController _audioController;
  bool countdownStarted = false;
  bool shufflingFinished = false;
  late Timer _timer;
  Set<int> selectedCards = {};
  bool isButtonVisible = false;
  bool _textvisible = true;
  bool _cardvisible = false;
  int animationCount = 0;
  int totalselectedcards = 0;

  @override
  void initState() {
    _audioController = Get.find<AudioController>();
    _audioController.playSelectedAudio();
    super.initState();
    fetchCards();
  }

  Future<void> _changePosition() async {
    setState(() {
      _textvisible = !_textvisible;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() async {
          _cardvisible = !_cardvisible;
          _isAnimating = !_isAnimating;
          if (_isAnimating) {
            for (int i = 0; i < 4; i++) {
              _updateCardPositions();
              print('method call of time $i');
              await Future.delayed(Duration(milliseconds: 2200)); // Delay between updates
            }
            setState(() {
              _isAnimating = false; // Stop the animation after updating positions
            });
          }
        });
      });
    });
  }

  void _updateCardPositions() {
    setState(() {
      for (int i = 0; i < cards.length; i++) {
        if (!fixedPositions[i]) { // Only update positions if the card is not in a fixed position
          double newLeft = Random().nextDouble() * (MediaQuery.of(context).size.width * 0.9 - 90);
          double newTop = Random().nextDouble() * (MediaQuery.of(context).size.height * 0.7 - 120);
          cards[i].position = '$newLeft,$newTop'; // Store the new position
        }
      }
    });
  }

  void _animateCardRemoval(int cardId) {
    // Find the index of the selected card in the list
    int index = cards.indexWhere((card) => card.id == cardId);
    if (index != -1) {
      // Set the new position outside the screen
      setState(() {
        cards[index].position = '${MediaQuery.of(context).size.width}, ${MediaQuery.of(context).size.height}';
      });
    }
  }

  List<Widget> _buildCards() {
    return cards.map((card) {
      List<String> positionValues = card.position.split(',');
      double left = double.parse(positionValues[0]);
      double top = double.parse(positionValues[1]);

      return CardWidget(
        cardInfo: card,
        tarotType: widget.tarotType,
        onCardTap: _onCardTap,
        selectedCards: selectedCards,
        left: left,
        top: top,
      );
    }).toList();
  }

  void _onCardTap(CardInfo card) {
    if (selectedCards.length < widget.numberOfCards) {
      setState(() {
        totalselectedcards = totalselectedcards+1;
      });
      _animateCardRemoval(card.id);
      selectedCards.add(card.id);
      if (selectedCards.length == widget.numberOfCards) {
        List<SelectedCard> selectedCardsList = selectedCards.map((id) {
          CardInfo card = cards.firstWhere((card) => card.id == id);
          return SelectedCard(id: card.id, name: card.name);
        }).toList();
        NavigateToRevealCard(
            selectedCards: selectedCardsList,
            tarotType: widget.tarotType,
            spreadName: widget.spreadName);
      }
    } else {
      List<SelectedCard> selectedCardsList = selectedCards.map((id) {
        CardInfo card = cards.firstWhere((card) => card.id == id);
        return SelectedCard(id: card.id, name: card.name);
      }).toList();
      NavigateToRevealCard(
          selectedCards: selectedCardsList,
          tarotType: widget.tarotType,
          spreadName: widget.spreadName);
    }
  }

  void NavigateToRevealCard({required List<SelectedCard> selectedCards,required String tarotType, required String spreadName}) {
    if (widget.tarotType == "Osho Zen" && widget.spreadName == "Single Card") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "Three Card") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheThreeCardSpread(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "The Diamond") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheDiamondScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "The Flying Bird") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheFlyingBirdScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "The Key") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheKeyScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "The Paradox") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheParadoxScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "The Mirror") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheMirrorScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "Celtic Cross") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheCelticCrossScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "Relationship") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheRelationSpread(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "Unification") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheUnificationScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Single Card") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderSingleCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Two Card") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderTwoCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Three Card") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderThreeCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Four Card Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderFourCardScreen(
              selectedCards: selectedCards,
              tarotType: widget.tarotType,
              spreadName: widget.spreadName,
            )),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Five Card Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderFiveCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Money Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderMoneySpreadScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Six Card Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderSixCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Seven Card Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderSevenCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "The Horseshoe Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderHarshuShuCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Eight Card Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderEightCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Nine Card Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderNineCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Celtic Cross") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderCelticCrossCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Twelve card spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderTwelveCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "Circular Spread") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderCircularCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "The Elcemist") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderElcemistCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    }
  }

  Future<void> fetchCards() async {
    try {
      int numberOfCards = 79; // Assuming 78 cards for example
      setState(() {
        cards = List<CardInfo>.generate(
          numberOfCards,
              (index) => CardInfo(
            id: index + 1, // Assuming IDs start from 1
            position: '0,0',
            name: '', // You can remove the name parameter since it's not needed
          ),
        );
        fixedPositions = List<bool>.filled(numberOfCards, false);
      });
    } catch (e) {
      print('Error fetching cards: $e');
    }
  }


  // Future<void> fetchCards() async {
  //   try {
  //     String uri = "https://thetarotguru.com/tarotapi/cardlist.php";
  //     var requestBody = {
  //       "tarotType": widget.tarotType,
  //     };
  //     print("req body = ${requestBody}");
  //     var response = await http.post(Uri.parse(uri), body: requestBody);
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       print("Status code : ${response.statusCode}");
  //       if (data['status'] == 'success') {
  //         final List<dynamic> cardList = data['cardList'];
  //         print(cardList);
  //         setState(() {
  //           cards = List<CardInfo>.generate(
  //             cardList.length,
  //                 (index) => CardInfo(
  //               id: int.parse(cardList[index]['id']),
  //               position: '0,0',
  //               name: cardList[index]['name']
  //               as String,
  //             ),
  //           );
  //           fixedPositions = List<bool>.filled(cardList.length, false);
  //         });
  //       } else {
  //         throw Exception('Failed to fetch cards');
  //       }
  //     } else {
  //       throw Exception('Failed to fetch cards');
  //     }
  //   } catch (e) {
  //     print('Error fetching cards: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
              'assets/images/Screen_Backgrounds/bg3.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '${widget.spreadName}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.music_note),
                  color: Colors.white,
                  onPressed: () {
                    _audioController.toggleAudio();
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
          Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
            ],
          ),
          Center(
            child: Visibility(
              visible: _textvisible,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'A single card - for insight into any situtation or as your meditation for the day',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: _changePosition,
                        child: Text(_isAnimating
                            ? 'Stop Animation'
                            : 'Start Animation'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: !_textvisible,
              child: Container(
                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width *0.1, AppBar().preferredSize.height + (AppBar().preferredSize.height + (AppBar().preferredSize.height/2)), 0, 0),
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Stack(
                  children: _buildCards(),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: AppBar().preferredSize.height,
            left: MediaQuery.of(context).size.width * 0.8/2,
            child: Text('Selected $totalselectedcards / ${widget.numberOfCards}',style: TextStyle(color: Colors.white,fontSize: 20),),
          )
          // if(showText == false)
        ],
      ),
    );
  }
}

class SelectedCard {
  final int id;
  final String name;
  SelectedCard({required this.id, required this.name});
}

class CardInfo {
  final int id;
  String position;
  final String name;
  // bool isVisible; // Add isVisible property

  CardInfo({
    required this.id,
    required this.name,
    required this.position,
    // this.isVisible = true, // Default isVisible to true
  });
}

class CardWidget extends StatefulWidget {
  final CardInfo cardInfo;
  final String tarotType;
  final Function(CardInfo) onCardTap;
  final Set<int> selectedCards;
  final double left;
  final double top;

  const CardWidget({
    required this.cardInfo,
    required this.tarotType,
    required this.onCardTap,
    required this.selectedCards,
    required this.left,
    required this.top,
  });

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  bool isVisible = true;
  bool isDragging = false;
  bool isDragged = false;
  Offset position = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.left, widget.top),
      end: Offset(widget.left, widget.top),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  void _animateToNewPosition() {
    _controller.reset();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.left, widget.top),
      end: Offset(widget.left, widget.top),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    double oshoimageAspectRatio = 671 / 457;
    double riderimageAspectRatio = 2600 / 1480;
    double imagewidth = 0;
    double imageheight = 0;
    Color bordercolor = Colors.white;

    late double newtop = widget.top;
    late double newleft = widget.left;

    if (widget.tarotType == 'Osho Zen') {
      imageUrl = 'assets/images/cards/osho.jpg';
      imagewidth = 45;
      imageheight = imagewidth * oshoimageAspectRatio;
      bordercolor = Colors.white;
    } else if (widget.tarotType == 'Rider Waite') {
      imageUrl = 'assets/images/cards/rider.jpg';
      imagewidth = 50;
      imageheight = imagewidth * riderimageAspectRatio;
      bordercolor = Colors.black;
    }

    return Visibility(
      visible: isVisible,
      child: AnimatedPositioned(
        duration: Duration(seconds: 2),
        curve: Curves.easeInOut,
        top: newtop,
        left:newleft,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque, // Ensure that the GestureDetector receives taps even during dragging
          onPanStart: (details) {
            print('animation start');
            print('top and left before update is : $newtop & $newleft');
            setState(() {
              isDragging = true; // Set dragging flag to true when dragging starts
            });
          },
          onPanUpdate: (details) {
            if (isDragging) {
              setState(() {
                print('top and left before update is : $newtop & $newleft');
                position = position + details.delta;
                print('detail is  : ${details.delta.dx} & ${details.delta.dy}');
                print('position is  : ${position.dx} & ${position.dy}');
                print('top and left is  : ${position.dx} & ${position.dy}');
              });
            }
          },
          onPanEnd: (details) {
            setState(() {
              print('hit');
              print('top and left after update is : $newtop & $newleft');
              print('and position is $position');
              isDragged = true;
              isDragging = false;
            });
          },
          onTap:(){
            widget.onCardTap(widget.cardInfo);
          },
          child: SlideTransition(
            position: _offsetAnimation,
            child: Transform.translate(
              offset: Offset(position.dx,position.dy),
              child: GestureDetector(
                onTap:(){
                  widget.onCardTap(widget.cardInfo);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      width: 1,
                      color: bordercolor,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: Image.asset(
                      imageUrl,
                      width: imagewidth,
                      height: imageheight,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
