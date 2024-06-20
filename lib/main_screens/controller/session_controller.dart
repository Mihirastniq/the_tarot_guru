import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/intro.dart';
import 'package:the_tarot_guru/main_screens/Register/otp_verify.dart';


class LoginController {
  TextEditingController Username = TextEditingController();
  TextEditingController password = TextEditingController();

  String LOGINKEY = "isLogin";
  bool? isLogin = false;

  void UserLogin(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (Username.text != "" || password.text != "") {
      try {
        String uri = "https://thetarotguru.com/tarotapi/userlogin.php";
        var requestBody = {
          "username": Username.text,
          "password": password.text,
        };
        var res = await http.post(Uri.parse(uri), body: requestBody);
        var response = jsonDecode(res.body);
        String isVerified = response['status'];
        if (isVerified == "verification_pending") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OTPVerifyPageState(response)),
          );
          return;
        } else if (response["status"] == 'success') {
          prefs.setBool(LOGINKEY, true);
          prefs.setString('firstName', response['firstName']);
          prefs.setString('lastName', response['lastName']);
          prefs.setString('email', response['email']);
          prefs.setInt('phone', int.parse(response['phone']));
          // prefs.setInt('appPin', int.parse(response['appPin']));
          prefs.setBool('enablePin', false);
          prefs.setInt('userid', int.parse(response['userid']));
          prefs.setString('created_at', response['created_at']);
          prefs.setInt('subscription_status', int.parse(response['subscription_status']));
          prefs.setInt('free_by_admin', int.parse(response['free_by_admin']));
          prefs.setInt('warning', int.parse(response['warning']));
          prefs.setInt('trial_warning', int.parse(response['trial_warning']));

          Fluttertoast.showToast(
            msg: "login Successs",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          NavigateToHome(context, response['lang']);
        } else {
          Fluttertoast.showToast(
            msg: response["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      Fluttertoast.showToast(
        msg: "fill all the fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 15,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void NavigateToHome(BuildContext context,String language) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppSelect()),
    );
  }

  void NavigateToIntro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SplashView()),
    );
  }

  void logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all data from SharedPreferences
    NavigateToIntro(context);
  }

}
