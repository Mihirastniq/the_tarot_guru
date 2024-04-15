import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController extends ChangeNotifier {
    Locale? _appLocal;
  Locale? get appLocal => _appLocal;

  Future<void> changelanguage(Locale type) async {
    _appLocal = type;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (type == Locale('en')) {
      await sp.setString('lang', 'en');
    } else if (type == Locale('hi')) {
      await sp.setString('lang', 'hi');
    } else if (type == Locale('gu')) {
      await sp.setString('lang', 'gu');
    } else if (type == Locale('mr')) {
      await sp.setString('lang', 'mr');
    }
    notifyListeners();
  }
}