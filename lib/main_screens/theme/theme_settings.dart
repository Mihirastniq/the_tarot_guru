import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  int _themeIndex = 0;

  int get currentThemeIndex => _themeIndex;

  ThemeData getTheme() {
    switch (_themeIndex) {
      case 0:
        return ThemeData(
          primaryColor: const Color(0xFF191970), // Midnight Blue
          scaffoldBackgroundColor: const Color(0xFF000000),

          cardColor: const Color(0xFF000080), // Navy Blue
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF000080),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF000000),
          ),
          dividerColor: const Color(0xFF7F6700), // Red
          highlightColor: const Color(0xFF006EB5), // Gold
          hoverColor: const Color(0xFF000080), // Navy Blue
          indicatorColor: const Color(0xFFFFD700), // Gold
          disabledColor: const Color(0xFF808080), // Gray
          canvasColor: const Color(0xFF000000), // Black
          focusColor: const Color(0xFF7FFFD4), // Aquamarine
          splashColor: const Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: const Color(0xFFFFFFFF), // White
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: const TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),
        );
      case 1:
        return ThemeData(
          primaryColor: const Color(0xFF710020), // Emerald Green
          scaffoldBackgroundColor: const Color(0xFF510002), // Black
          backgroundColor: const Color(0xFF000080), // Navy Blue
          cardColor: const Color(0xFF000080), // Navy Blue
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF7F6700),
          ),
          dividerColor: const Color(0xFF7F6700), // Red
          highlightColor: const Color(0xFFFFD700), // Gold
          hoverColor: const Color(0xFF7F6700), // Navy Blue
          indicatorColor: const Color(0xFFFFD700), // Gold
          disabledColor: const Color(0xFF808080), // Gray
          canvasColor: const Color(0xFF000000), // Black
          focusColor: const Color(0xFF7FFFD4), // Aquamarine
          splashColor: const Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: const Color(0xFFFFFFFF), // White
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),
        );
      case 2:
        return ThemeData(
          primaryColor: const Color(0xFF541370), // #ff94c1
          scaffoldBackgroundColor: const Color(0xFF3A0A50), // #be6079

          cardColor: const Color(0xFF752329), // #752329
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF69191c), // #69191c
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF5e0d0f), // #5e0d0f
          ),
          dividerColor: const Color(0xFF520001), // #520001

          highlightColor: const Color(0xFFc34918), // #c34918
          hoverColor: const Color(0xFFba4416), // #ba4416
          indicatorColor: const Color(0xFFb23f14), // #b23f14
          disabledColor: const Color(0xFF812008), // #812008
          canvasColor: const Color(0xFF892509), // #892509
          focusColor: const Color(0xFF610a02), // #610a02
          splashColor: const Color(0xFF5a0402), // #5a0402
          unselectedWidgetColor: const Color(0xFF992f0d), // #992f0d
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.white),
            displayLarge: TextStyle(color: Color(0xFF912a0b)), // #912a0b
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black),
          ),
        );
      case 3:
        return ThemeData(
          primaryColor: const Color(0xFFFF4500), // Deep Orange
          scaffoldBackgroundColor: const Color(0xFF000000), // Black

          cardColor: const Color(0xFF000080), // Navy Blue
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF000080),
          ),
          dividerColor: const Color(0xFF7FFFD4), // Aquamarine

          highlightColor: const Color(0xFFFFD700), // Gold
          hoverColor: const Color(0xFF000080), // Navy Blue
          indicatorColor: const Color(0xFFFFD700), // Gold
          disabledColor: const Color(0xFF808080), // Gray
          canvasColor: const Color(0xFF000000), // Black
          focusColor: const Color(0xFF7FFFD4), // Aquamarine
          splashColor: const Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: const Color(0xFFFFFFFF), // White
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),

        );
      case 4:
        return ThemeData(
          primaryColor: const Color(0xFFDC143C), // Crimson Red
          scaffoldBackgroundColor: const Color(0xFF000000), // Black

          cardColor: const Color(0xFF000080), // Navy Blue
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF000080),
          ),
          dividerColor: const Color(0xFF7FFFD4), // Aquamarine

          highlightColor: const Color(0xFFFFD700), // Gold
          hoverColor: const Color(0xFF000080), // Navy Blue
          indicatorColor: const Color(0xFFFFD700), // Gold
          disabledColor: const Color(0xFF808080), // Gray
          canvasColor: const Color(0xFF000000), // Black
          focusColor: const Color(0xFF7FFFD4), // Aquamarine
          splashColor: const Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: const Color(0xFFFFFFFF), // White
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),

        );
      default:
        return ThemeData.light();
    }
  }

  Future<void> saveTheme(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', index);
    _themeIndex = index;
  }

  Future<int> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('themeIndex');
    _themeIndex = themeIndex ?? 0;
    return _themeIndex;
  }

  void updateTheme(int index) {
    _themeIndex = (index + 1) % 5;
    saveTheme(_themeIndex);
    notifyListeners();
  }
}
