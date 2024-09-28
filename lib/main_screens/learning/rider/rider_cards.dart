import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/learning/rider/rider_card_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RiderLearningCardsScreen extends StatefulWidget {
  final String module;

  RiderLearningCardsScreen({required this.module});

  @override
  _RiderLearningCardsScreenState createState() => _RiderLearningCardsScreenState();
}

class _RiderLearningCardsScreenState extends State<RiderLearningCardsScreen> {
  late List<int> cards;
  Set<int> completedCards = {};
  int lastCompletedCard = 0;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    cards = getCardsForModule(widget.module);
    _loadCompletedCards();
  }

  Future<void> _loadCompletedCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      completedCards = prefs.getStringList('rider_completed_cards')?.map((e) => int.parse(e)).toSet() ?? {};
      lastCompletedCard = prefs.getInt('rider_last_completed_card') ?? 0;
    });
  }

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
                  Color(0xFF171625),
                  Color(0xFF171625),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg2.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.1),
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
            child: Container(
              margin: EdgeInsets.only(top: AppBar().preferredSize.height + AppBar().preferredSize.height, left: 20, right: 20),
              child: GridView.builder(
                itemCount: cards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Adjust based on your design preference
                  childAspectRatio: 3, // Adjust based on your design preference
                ),
                itemBuilder: (context, index) {
                  int card = cards[index];
                  bool isCompleted = completedCards.contains(card);
                  bool isAccessible = card == 1 || completedCards.contains(card - 1);

                  return GestureDetector(
                    onTap: isAccessible
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiderLearningContentScreen(card: card),
                        ),
                      ).then((_) => _loadCompletedCards());
                    }
                        : null,
                    child: _buildButton(
                      text: 'Card $card',
                      color1: Color(0xFF171625).withOpacity(0.6),
                      color2: Color(0xFF171625).withOpacity(0.6),
                      opacity: 0.1,
                      imagePath: 'assets/images/other/stars.png',
                      icons: isCompleted ? Icons.check_circle : (isAccessible ? Icons.play_circle_fill : Icons.lock),
                      isCompleted: isCompleted,
                      isAccessible: isAccessible,
                    ),
                  );
                },
              ),
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
    );
  }

  Widget _buildButton({
    required String text,
    required Color color1,
    required Color color2,
    required double opacity,
    required String imagePath,
    required IconData icons,
    bool isCompleted = false,
    bool isAccessible = true,
  }) {
    return Container(
      width: double.infinity,
      height: 120.0,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1.withOpacity(opacity), color2.withOpacity(opacity)],
        ),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: color2.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 0.5,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          icons,
                          color: isCompleted ? Colors.green : (isAccessible ? Color(0xFF141945) : Colors.grey),
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<int> getCardsForModule(String module) {
    switch (module) {
      case 'major_arcana':
        return List.generate(22, (index) => index + 1);
      case 'pentacles':
        return List.generate(14, (index) => index + 23);
      case 'cups':
        return List.generate(14, (index) => index + 37);
      case 'swords':
        return List.generate(14, (index) => index + 51);
      case 'wands':
        return List.generate(14, (index) => index + 65);
      default:
        return [];
    }
  }
}
