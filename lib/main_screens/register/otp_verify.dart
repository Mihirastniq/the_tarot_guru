import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_tarot_guru/main_screens/register/language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/main_screens/warnings/please_wait_popup.dart';

class OTPVerifyPageState extends StatefulWidget {
  final Map<String, dynamic> response;
  OTPVerifyPageState(this.response);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OTPVerifyPageState> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  bool otpflag = false;

  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  late FocusNode _focusNode3;
  late FocusNode _focusNode4;
  String LOGINKEY = "isLogin";
  bool? isLogin = false;

  @override
  void initState() {
    super.initState();
    print(widget.response['otp']);
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
  }

  Future<void> _showPleaseWaitDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PleaseWaitDialog();
      },
    );
  }

  void _hidePleaseWaitDialog() {
    Navigator.of(context).pop();
  }

  void _onContinuePress() async {
    String pin = _controller1.text + _controller2.text + _controller3.text + _controller4.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int otpFromResponse = widget.response['otp']; // Get the OTP from the response object
    String otpFromResponseString = otpFromResponse.toString(); // Convert it to a string

    if (pin == otpFromResponseString) { // Compare the entered OTP with the OTP from the response
      widget.response['otp_status'] = 'match';
      _showPleaseWaitDialog();
      try {
        String uri = "https://thetarotguru.com/tarotapi/testing/userverifaction.php";
        var requestBody = jsonEncode(widget.response);
        var res = await http.post(Uri.parse(uri), body: requestBody);
        var response = jsonDecode(res.body);
        print('Response is : ${response}');
        if (response["status"] == 'success') {
          // Handle the response data correctly
          var user = response['user'];
          prefs.setString('firstName', user['firstname']);
          prefs.setString('lastName', user['lastname']);
          prefs.setString('email', user['email']);
          prefs.setInt('userid', int.parse(user['id']));
          prefs.setInt('phone', int.parse(user['phone'])); // Store phone as a string
          prefs.setBool(LOGINKEY, true);
          prefs.setInt('subscription_status', int.parse(user['subscription_status'] ?? '0'));
          prefs.setInt('free_by_admin', int.parse(user['free_by_admin'] ?? '0'));
          prefs.setInt('warning', int.parse(user['warning'] ?? '0'));
          prefs.setInt('trial_warning', int.parse(user['trial_warning'] ?? '1'));

          Fluttertoast.showToast(
            msg: "Verification Successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          _hidePleaseWaitDialog(); // Hide the dialog before navigating
          _navigateToLanguageSelect();
        } else {
          Fluttertoast.showToast(
            msg: "${response['message']}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          _hidePleaseWaitDialog();
        }
      } catch (e) {
        print('Error: $e');
        Fluttertoast.showToast(
          msg: "Try again after some time",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _hidePleaseWaitDialog();
      }
    } else {
      Fluttertoast.showToast(
        msg: "Incorrect OTP",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        otpflag = true;
        pin = '';
      });
      _hidePleaseWaitDialog();
    }
  }

  void _navigateToLanguageSelect() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LanguageSelection()),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(4, 2, 12, 1.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Screen_Backgrounds/bg1.png'),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/intro/logo.png',
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.otpscreenlabel}',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.otpscreensubtitle}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _textFieldOTP(first: true, last: false, controller: _controller1, focusNode: _focusNode1)),
                            SizedBox(width: 10), // Add space between boxes
                            Expanded(child: _textFieldOTP(first: false, last: false, controller: _controller2, focusNode: _focusNode2)),
                            SizedBox(width: 10), // Add space between boxes
                            Expanded(child: _textFieldOTP(first: false, last: false, controller: _controller3, focusNode: _focusNode3)),
                            SizedBox(width: 10), // Add space between boxes
                            Expanded(child: _textFieldOTP(first: false, last: true, controller: _controller4, focusNode: _focusNode4)),
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        otpflag == true ? Text('Wrong OTP', style: TextStyle(color: Colors.red, fontSize: 16),) : SizedBox(height: 1,),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _onContinuePress,
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Continue',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last, required TextEditingController controller, required FocusNode focusNode}) {
    return SizedBox(
      height: 80,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller,
          autofocus: true,
          focusNode: focusNode,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.purple),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
