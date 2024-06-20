import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/subscription/subscribe.dart';
import 'ActiveSpread.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RiderNewSpread extends StatefulWidget {
  final String tarotType;

  const RiderNewSpread({Key? key, required this.tarotType}) : super(key: key);

  @override
  _NewSpreadState createState() => _NewSpreadState();
}

class _NewSpreadState extends State<RiderNewSpread> {
  Map<String, Map<String, dynamic>> optionCardCounts = {};
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize =16 ;
  late double ButtonFontsSize =25;
  @override
  void initState() {
    super.initState();
    _loadLocalData();
    Future.delayed(Duration.zero, () { fetchOptions(); });
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
  void fetchOptions() {
    setState(() {
      if (widget.tarotType == 'Osho Zen') {
        optionCardCounts = {
          "${AppLocalizations.of(context)!.singlecard}": {
            "count": 1,
            "color1": Color(0xFFF09819),
            "color2": Color(0xFFEDDE5D),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/1.png',
            "iconBoxColor": Color(0xFF84663A),
            'spreadEnglishName':'Osho Single Card',
          },
          "${AppLocalizations.of(context)!.threecard}": {
            "count": 3,
            "color1": Color(0xFFEE0979),
            "color2": Color(0xFFFF6A00),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/2.png',
            "iconBoxColor": Color(0xFF74234B),
            'spreadEnglishName':'Osho Three Card',
          },
          "${AppLocalizations.of(context)!.thediamond}": {
            "count": 5,
            "color1": Color(0xFFE52D27),
            "color2": Color(0xFFB31217),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/3.png',
            "iconBoxColor": Color(0xFF521E1F),
            'spreadEnglishName':'Osho The Diamond',
          },
          "${AppLocalizations.of(context)!.theflyingbird}": {
            "count": 7,
            "color1": Color(0xFFDA22FF),
            "color2": Color(0xFF9733EE),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/4.png',
            "iconBoxColor": Color(0xFF5F3A80),
            'spreadEnglishName':'Osho The Flying Bird',
          },
          "${AppLocalizations.of(context)!.thekey}": {
            "count": 8,
            "color1": Color(0xFF348F50),
            "color2": Color(0xFF56B4D3),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/5.png',
            "iconBoxColor": Color(0xFF487A8B),
            'spreadEnglishName':'Osho The Key',
          },
          "${AppLocalizations.of(context)!.theparadox}": {
            "count": 3,
            "color1": Color(0xFF61045F),
            "color2": Color(0xFFAA076B),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/6.png',
            "iconBoxColor": Color(0xFF40253F),
            'spreadEnglishName':'Osho The Paradox',
          },
          "${AppLocalizations.of(context)!.themirror}": {
            "count": 12,
            "color1": Color(0xFFC21500),
            "color2": Color(0xFFFFC500),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/7.png',
            "iconBoxColor": Color(0xFF796B3B),
            'spreadEnglishName':'Osho The Mirror',
          },
          "${AppLocalizations.of(context)!.celticcross}": {
            "count": 10,
            "color1": Color(0xFF56AB2F),
            "color2": Color(0xFFA8E063),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/8.png',
            "iconBoxColor": Color(0xFF3D622C),
            'spreadEnglishName':'Osho Celtic Cross',
          },
          "${AppLocalizations.of(context)!.relationship}": {
            "count": 4,
            "color1": Color(0xFFFF4E50),
            "color2": Color(0xFFF9D423),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/9.png',
            "iconBoxColor": Color(0xFF524C2F),
            'spreadEnglishName':'Osho Relationship',
          },
          "${AppLocalizations.of(context)!.unification}": {
            "count": 10,
            "color1": Color(0xFF834D9B),
            "color2": Color(0xFFD04ED6),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/10.png',
            "iconBoxColor": Color(0xFF3B2A42),
            'spreadEnglishName':'Osho Unification',
          },
        };
      } else if (widget.tarotType == 'Rider Waite') {
        optionCardCounts = {
          "${AppLocalizations.of(context)!.singlecard}": {
            "count": 1,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/1.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Single Card',
          },
          "${AppLocalizations.of(context)!.twocard}": {
            "count": 2,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/2.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Two Card',
          },
          "${AppLocalizations.of(context)!.threecard}": {
            "count": 3,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/3.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Three Card',
          },
          "${AppLocalizations.of(context)!.fourcardspread}": {
            "count": 4,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/4.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Four Card Spread',
          },
          "${AppLocalizations.of(context)!.fivecardspread}": {
            "count": 5,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/5.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Five Card Spread',
          },
          "${AppLocalizations.of(context)!.moneyspread}": {
            "count": 5,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/6.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Money Spread',
          },
          "${AppLocalizations.of(context)!.sixcardspread}": {
            "count": 6,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/7.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Six Card Spread',
          },
          "${AppLocalizations.of(context)!.sevencardspread}": {
            "count": 7,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/8.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Seven Card Spread',
          },
          "${AppLocalizations.of(context)!.thehorseshoespread}": {
            "count": 7,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/9.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'The Horseshoe Spread',
          },
          "${AppLocalizations.of(context)!.eightcardspread}": {
            "count": 8,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/10.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Eight Card Spread',
          },
          "${AppLocalizations.of(context)!.ninecardspread}": {
            "count": 9,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/11.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Nine Card Spread',
          },
          "${AppLocalizations.of(context)!.celticcross}": {
            "count": 10,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/12.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Celtic Cross',
          },
          "${AppLocalizations.of(context)!.twelvecardspread}": {
            "count": 12,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/13.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Twelve card',
          },
          "${AppLocalizations.of(context)!.circularspread}": {
            "count": 13,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/14.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'Circular Spread',
          },
          "${AppLocalizations.of(context)!.theelcemist}": {
            "count": 6,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/rider/15.png',
            "iconBoxColor": Color(0xFF00796B),
            'spreadEnglishName':'The Elcemist',
          },
        };
      }

    });
  }

  void navigateToActiveSpread(String spreadName, int numberOfCards, Color color1, Color color2, String imagePath,String spreadEnglishName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? subscriptionStatus = prefs.getInt('subscription_status');
    int? freebyadmin = prefs.getInt('free_by_admin');

    if (subscriptionStatus == 1 || freebyadmin == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActiveSpread(
            tarotType: widget.tarotType,
            spreadName: spreadName,
            spreadEnglishName:spreadEnglishName,
            numberOfCards: numberOfCards,
          ),
        ),
      );
    } else {
      if ( spreadEnglishName == "Single Card" || spreadEnglishName == "Two Card" || spreadEnglishName == "Three Card") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActiveSpread(
              tarotType: widget.tarotType,
              spreadName: spreadName,
              spreadEnglishName:spreadEnglishName,
              numberOfCards: numberOfCards,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubscribeApp()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Color(0xFF171625),
                  Color(0xFF171625),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg2.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 25, 0,0),
                  padding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${AppLocalizations.of(context)!.newspreadtitle}",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800
                      ),),
                      Text('${AppLocalizations.of(context)!.tarotsubtitle} : ${widget.tarotType}',style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      ),),
                    ],
                  )
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: optionCardCounts.length,
                  itemBuilder: (context, index) {
                    String option = optionCardCounts.keys.elementAt(index);
                    int cardCount = optionCardCounts[option]!['count'];
                    Color color1 = optionCardCounts[option]!['color1'];
                    Color color2 = optionCardCounts[option]!['color2'];
                    double opacity = optionCardCounts[option]!['opacity'];
                    String imagePath = optionCardCounts[option]!['imagePath'];
                    String spreadEnglishName = optionCardCounts[option]! ['spreadEnglishName'];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 150, // Fixed height for each button
                      child: _buildButton(
                        context,
                        option,
                        cardCount,
                        color1,
                        color2,
                        opacity,
                        imagePath,
                        optionCardCounts[option]!['iconBoxColor'], spreadEnglishName,
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_circle_left,size: 40,),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context,true);
                },
              ),

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      String option,
      int cardCount,
      Color color1,
      Color color2,
      double opacity,
      String imagePath,
      Color iconBoxColor,
      String spreadEnglishName,
      ) {
    return GestureDetector(
      onTap: () {
        navigateToActiveSpread(option, cardCount, color1, color2, imagePath,spreadEnglishName);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
        color: Color(0xFF171625).withOpacity(0.6),
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/other/button.png'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
              border: Border.all(
                width: 2,
                color: Colors.grey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: 75,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Color(0xFF171625).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      height: 150.0
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.7 - 15 -45,
                child: Text(option,style: TextStyle(color: Colors.white,fontSize: ButtonFontsSize,fontWeight: FontWeight.w800),),
              )
            ],
          ),
        ),
      )
    );
  }
}