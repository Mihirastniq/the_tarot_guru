import 'package:flutter/material.dart';
import 'rider_cards.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiderDeckScreen extends StatefulWidget {
  final String tarotType;
  const RiderDeckScreen({super.key, required this.tarotType});

  @override
  State<RiderDeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<RiderDeckScreen> {

  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize =16 ;
  late double ButtonFontsSize =25;
  @override
  void initState() {
    super.initState();
    _loadLocalData();
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

  @override
  Widget build(BuildContext context) {
    late Map<String, String> deckOptions;

    if (widget.tarotType == 'Osho Zen') {
      deckOptions = {
        "Major Arcana": "${AppLocalizations.of(context)!.oshomajorarcana}",
        "Fire": "${AppLocalizations.of(context)!.oshofire}",
        "Water": "${AppLocalizations.of(context)!.oshowater}",
        "Earth": "${AppLocalizations.of(context)!.oshoearth}",
        "Clouds": "${AppLocalizations.of(context)!.oshoclouds}",
      };
    } else if (widget.tarotType == 'Rider Waite') {
      deckOptions = {
        "Major Arcana": "${AppLocalizations.of(context)!.ridermajorarcana}",
        "Pentacles": "${AppLocalizations.of(context)!.riderpentacles}",
        "Cups": "${AppLocalizations.of(context)!.ridercups}",
        "Swords": "${AppLocalizations.of(context)!.riderswords}",
        "Wands": "${AppLocalizations.of(context)!.riderwands}",
      };
    }

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
                  // Color.fromRGBO(19, 14, 42, 1),
                  // Colors.deepPurple.shade900.withOpacity(0.9),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: deckOptions.entries.map((entry) {
                              return _buildButton(context, entry.key, entry.value);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
    onPressed: () {
    Navigator.pop(context);
    },
    icon: Icon(
    Icons.arrow_circle_left,
    color: Colors.white,
    size: 35,
    )),
              title: Text(
                '${widget.tarotType} Tarot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildButton(BuildContext context, String key, String deckOption) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RiderCardsScreen(
              tarotType: widget.tarotType,
              deckOption: key,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
        color: Color(0xFF171625).withOpacity(0.6),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                deckOption,
                style: TextStyle(color: Colors.white, fontSize: ButtonFontsSize, fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      ),
    );
  }
}