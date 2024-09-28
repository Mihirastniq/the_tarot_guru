import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/main_screens/Register/otp_verify.dart';
import 'package:the_tarot_guru/main_screens/Register/register.dart';

class RegistrationController {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController country_code = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  TextEditingController dobController = TextEditingController();

  DateTime? _dob;
  DateTime? get dob => _dob;

  void setDob(DateTime? dob) {
    _dob = dob;
  }

  Future<void> registerFunction(BuildContext context) async {
    final String dobString = dobController.text.isNotEmpty ? dobController.text : '';
    if (first_name.text.isNotEmpty &&
        last_name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phone_number.text.isNotEmpty &&
        dobString.isNotEmpty &&
        gender.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirm_password.text.isNotEmpty) {
      try {
        final String uri = "https://thetarotguru.com/tarotapi/testing/userregistration.php";
        final Map<String, String> requestBody = {
          "fname": first_name.text,
          "lname": last_name.text,
          "email": email.text,
          "phone": phone_number.text,
          "country_code":country_code.text,
          "dob": dobString,
          "gender": gender.text,
          "password": password.text,
          "confirm_password": confirm_password.text,
          "country":country.text,
        };
        final http.Response res = await http.post(Uri.parse(uri), body: requestBody);

        final dynamic response = jsonDecode(res.body);
        print('Response is : ${res.body}');
        if (response["status"] == 'success') {
          _navigateToOTPVerifyPage(response, context);
          Fluttertoast.showToast(
            msg: response["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: response["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterNew()),
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Try again after some time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 15,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please Fill all details.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 15,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _navigateToOTPVerifyPage(Map<String, dynamic> response, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTPVerifyPageState(response)),
    );
  }
}
