import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeSelection extends StatefulWidget {
  const FontSizeSelection({super.key});

  @override
  State<FontSizeSelection> createState() => _FontSizeSelectionScreenState();
}

class _FontSizeSelectionScreenState extends State<FontSizeSelection> {
  final List<String> categories = ['Title', 'Subtitle', 'Content', 'Button'];
  final Map<String, double> selectedFontSizes = {
    'Title': 20.0,
    'Subtitle': 18.0,
    'Content': 16.0,
    'Button': 14.0,
  };

  @override
  void initState() {
    super.initState();
    _loadFontSizes();
  }

  Future<void> _loadFontSizes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedFontSizes['Title'] = prefs.getDouble('TitleFontSize') ?? 20.0;
      selectedFontSizes['Subtitle'] = prefs.getDouble('SubtitleFontSize') ?? 18.0;
      selectedFontSizes['Content'] = prefs.getDouble('ContentFontSize') ?? 16.0;
      selectedFontSizes['Button'] = prefs.getDouble('ButtonFontSize') ?? 14.0;
    });
  }

  Future<void> _saveFontSize(String category, double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${category}FontSize', size);
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
                  Color(0xFF1C1C2D),
                  Color(0xFF1C1C2D),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
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
                    )),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '${AppLocalizations.of(context)!.selectfontsizelabel}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    // Generate list of categories with dropdowns
                    for (String category in categories)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            DropdownButton<double>(
                              value: selectedFontSizes[category],
                              dropdownColor: Color(0xFF1C1C2D),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              items: List.generate(21, (index) => 10.0 + index).map((double value) {
                                return DropdownMenuItem<double>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                              onChanged: (double? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedFontSizes[category] = newValue;
                                  });
                                  _saveFontSize(category, newValue);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Title Example',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Sample',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: selectedFontSizes['Title'],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtitle Example',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Sample',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: selectedFontSizes['Subtitle'],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Content Example',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Sample',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: selectedFontSizes['Content'],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Button Example',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Sample',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: selectedFontSizes['Button'],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}