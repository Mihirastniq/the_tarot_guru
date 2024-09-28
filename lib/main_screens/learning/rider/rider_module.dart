import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/learning/rider/rider_cards.dart';

class RiderLearningModuleScreen extends StatefulWidget {
  const RiderLearningModuleScreen({Key? key}) : super(key: key);

  @override
  State<RiderLearningModuleScreen> createState() =>
      _RiderLearningModuleScreenState();
}

class _RiderLearningModuleScreenState extends State<RiderLearningModuleScreen> {
  bool _isScrolled = false;
  late int _lastCompletedCard;

  Map<String, List<int>> moduleCardRanges = {
    'major_arcana': [1, 22],
    'pentacles': [23, 36],
    'cups': [37, 50],
    'swords': [51, 64],
    'wands': [65, 78],
  };

  @override
  void initState() {
    super.initState();
    _loadLastCompletedCard();
  }

  Future<void> _loadLastCompletedCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastCompletedCard = prefs.getInt('rider_last_completed_card') ?? 0;
    setState(() {}); // Update the state after loading the last completed card
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height +
                          AppBar().preferredSize.height,
                    ),
                    buildModuleButton(context, 'Module 1', 'major_arcana',
                        isFirstModule: true),
                    buildModuleButton(context, 'Module 2', 'pentacles',
                        isFirstModule: false),
                    buildModuleButton(context, 'Module 3', 'cups',
                        isFirstModule: false),
                    buildModuleButton(context, 'Module 4', 'swords',
                        isFirstModule: false),
                    buildModuleButton(context, 'Module 5', 'wands',
                        isFirstModule: false),
                  ],
                ),
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
              backgroundColor: _isScrolled
                  ? Color(0xFF171625)
                  : Colors.transparent,
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
    required Function()? onPressed,
    required String text,
    required Color color1,
    required Color color2,
    required double opacity,
    required String imagePath,
    required IconData icons,
    bool isCompleted = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 120.0,
        margin: EdgeInsets.symmetric(vertical: 5.0),
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
                            isCompleted ? Icons.check_circle : icons,
                            color: isCompleted ? Colors.green : Color(0xFF141945),
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
      ),
    );
  }

  Widget buildModuleButton(BuildContext context, String title, String module,
      {required bool isFirstModule}) {
    return FutureBuilder<bool>(
      future: isFirstModule
          ? Future.value(true)
          : isModuleCompleted(getPreviousModule(module)),
      builder: (context, snapshot) {
        bool isUnlocked = snapshot.data ?? false;

        return _buildButton(
          onPressed: () async {
            if (isUnlocked || await isModuleCompleted(getPreviousModule(module))) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RiderLearningCardsScreen(module: module),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                  Text('Complete the previous module to unlock this one.'),
                ),
              );
            }
          },
          text: title,
          color1: Color(0xFF171625).withOpacity(0.6),
          color2: Color(0xFF171625).withOpacity(0.6),
          opacity: 0.1,
          imagePath: 'assets/images/other/stars.png',
          icons: isUnlocked ? Icons.play_arrow : Icons.lock,
          isCompleted: isUnlocked,
        );
      },
    );
  }

  String getPreviousModule(String module) {
    List<String> modules = moduleCardRanges.keys.toList();
    int index = modules.indexOf(module);
    if (index > 0) {
      return modules[index - 1];
    }
    return modules.first; // fallback to the first module if no previous found
  }

  Future<bool> isCardCompleted(int cardNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('card_$cardNumber') ?? false;
  }

  Future<bool> isModuleCompleted(String module) async {
    List<int> range = moduleCardRanges[module]!;
    return _lastCompletedCard >= range[1];
  }
}

enum ModuleStatus {
  Locked,
  Running,
  Completed,
}
