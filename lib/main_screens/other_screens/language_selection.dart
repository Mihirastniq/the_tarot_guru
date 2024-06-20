import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/controller/language_controller/language_change_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_tarot_guru/main_screens/other_screens/fontselections.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late SharedPreferences _prefs;
  String? _selectedLanguageCode;
  late LanguageChangeController _languageChangeController;

  @override
  void initState() {
    super.initState();
    _initLanguage();
    _languageChangeController = Provider.of<LanguageChangeController>(context, listen: false);
  }

  Future<void> _initLanguage() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguageCode = _prefs.getString('lang') ?? 'en';
    });
  }


  final List<Map<String, String>> languageOptions = [
    {'en': 'English'},
    {'hi': 'Hindi'},
    {'gu': 'Gujarati'},
  ];

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    Future<void> _setSelectedLanguage(String languageCode) async {
      Locale locale = Locale(languageCode);
      await _languageChangeController.changelanguage(locale);
      Navigator.of(context).pop();
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1C1C2D),
                    Color(0xFF1C1C2D),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/Screen_Backgrounds/product.png',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.3),
              ),
            ),
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_circle_left,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  '${AppLocalizations.of(context)!.languageslabel}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [

                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: languageOptions.length,
                    itemBuilder: (context, index) {
                      final language = languageOptions[index];
                      final languageCode = language.keys.first;
                      final languageName = language.values.first;

                      return RadioListTile(
                        title: Text(
                          languageName!,
                          style: TextStyle(color: Colors.white),
                        ),
                        activeColor: Colors.white,
                        value: languageCode,
                        groupValue: _selectedLanguageCode,
                        onChanged: (value) {
                          _setSelectedLanguage(value as String);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    child: ProfileButton(
                        text: '${AppLocalizations.of(context)!.selectfontsizelabel}',
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FontSizeSelection()),
                          );
                        },
                        icon: Icons.format_size),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
