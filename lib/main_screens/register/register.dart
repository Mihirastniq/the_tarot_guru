import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_tarot_guru/main_screens/controller/registration_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_tarot_guru/main_screens/login/login.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../warnings/please_wait_popup.dart';

class RegisterNew extends StatefulWidget {
  const RegisterNew({Key? key}) : super(key: key);

  @override
  _RegisterNewState createState() => _RegisterNewState();
}

class _RegisterNewState extends State<RegisterNew> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  String countryCode = '';
  String countryFrom = '';
  String? phoneNumber;

  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF02051F),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.asset(
                    'assets/images/intro/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  '${AppLocalizations.of(context)!.registernowlabel}',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "${AppLocalizations.of(context)!.registermessage}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: IntlPhoneField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set focus border to white
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set border color to white
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.white), // Set country code color to white
                        ),
                      ),
                    ),
                    dropdownTextStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.bold,
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      setState(() {
                        countryFrom = phone.countryISOCode;
                        countryCode = phone.countryCode;
                        phoneNumber = phone.number;
                      });
                    },
                  ),
                ),

                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: phoneNumber != null ? () {


                        String? phone = phoneNumber;

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterUserDetails(countryCode: countryCode, phoneNumber: phone, country: countryFrom)),
                        );
                      } : null,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.white)
                            )
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: Text('Sign up'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterUserDetails extends StatefulWidget {
  final phoneNumber;
  final String countryCode;
  final String country;
  const RegisterUserDetails({Key? key, required this.countryCode, required this.phoneNumber, required this.country}) : super(key: key);

  @override
  State<RegisterUserDetails> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUserDetails> {
  String _selectedGender = '';
  final GlobalKey fieldKey = GlobalKey();
  Color fieldbbackground = Color(0xFF272B34);
  final RegistrationController _registrationController = RegistrationController();
  // bool _submitButtonPressed = false;
  bool _fnameflag = false;
  bool _lnameflag = false;

  bool _genderflag = false;
  bool _dobflag = false;
  bool _emailflag = false;
  bool _passwordflag = false;
  bool _confirmpasswordflag = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF081F42),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(4, 2, 12, 1.0),
                        Color.fromRGBO(4, 2, 12, 1.0),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.1),
                  ),
                ),
                Positioned(
                  left: -34,
                  top: 181.0,
                  child: SvgPicture.string(
                    // Group 3178
                    '<svg viewBox="-34.0 181.0 99.0 99.0" ><path transform="translate(-34.0, 181.0)" d="M 74.25 0 L 99 49.5 L 74.25 99 L 24.74999618530273 99 L 0 49.49999618530273 L 24.7500057220459 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-26.57, 206.25)" d="M 0 0 L 42.07500076293945 16.82999992370605 L 84.15000152587891 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.5, 223.07)" d="M 0 56.42999649047852 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: 99.0,
                    height: 99.0,
                  ),
                ),
                Positioned(
                  right: -52,
                  top: 45.0,
                  child: SvgPicture.string(
                    // Group 3177
                    '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: 139.0,
                    height: 139.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,bottom: 65,top: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //logo section
                        Column(
                          children: [
                            logo(size.height / 8, size.height / 8),
                            const SizedBox(
                              height: 16,
                            ),
                            richText(23.12),
                          ],
                        ),

                        Text(
                          '${AppLocalizations.of(context)!.registermessage}',
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FirstName(size),
                            customTextWidget('${AppLocalizations.of(context)!.regiurefirstname}', flag: _fnameflag),
                            const SizedBox(
                              height: 16,
                            ),
                            LastName(size),
                            customTextWidget('${AppLocalizations.of(context)!.regiurelastname}', flag: _lnameflag),
                            const SizedBox(
                              height: 16,
                            ),
                            emailTextField(size),
                            customTextWidget('${AppLocalizations.of(context)!.regiureemail}', flag: _emailflag),
                            const SizedBox(
                              height: 16,
                            ),
                            Gender(size),
                            customTextWidget('${AppLocalizations.of(context)!.regiuregender}', flag: _genderflag),
                            const SizedBox(
                              height: 16,
                            ),
                            DateOfBirth(size),
                            customTextWidget('${AppLocalizations.of(context)!.regiuredob}', flag: _dobflag),
                            const SizedBox(
                              height: 16,
                            ),
                            passwordTextField(size),
                            customTextWidget('${AppLocalizations.of(context)!.regiurepassword}', flag: _passwordflag),
                            const SizedBox(
                              height: 16,
                            ),
                            ConfirmPassword(size),
                            customTextWidget('${AppLocalizations.of(context)!.regiureconfirmpassword}', flag: _confirmpasswordflag),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            signInButton(size),
                            const SizedBox(
                              height: 16,
                            ),
                            buildContinueText(),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignIn(),
                                  ),
                                );
                              },
                              child: buildFooter(size),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/intro/logo.png',
      height: height_,
      width: width_,
    );
  }
  Widget richText(double fontSize) {
    return Text(
      '${AppLocalizations.of(context)!.registernowlabel}',
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
      ),
    );
  }
  Widget FirstName(Size size) {

    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: fieldbbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            const Icon(
              Icons.person_2_rounded,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: _registrationController.first_name,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.firstnamelabel}',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget LastName(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: fieldbbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            const Icon(
              Icons.person_2_rounded,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: _registrationController.last_name,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: '${AppLocalizations.of(context)!.lastnamelabel}',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: fieldbbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            const Icon(
              Icons.mail_rounded,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: _registrationController.email,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: '${AppLocalizations.of(context)!.emaillabel}',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget DateOfBirth(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: fieldbbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Calendar icon
            const Icon(
              Icons.calendar_today,
              color: Colors.white70,
            ),
            const SizedBox(width: 16),
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text(
                textAlign: TextAlign.start,
                _registrationController.dobController.text.isEmpty
                    ? 'Date of Birth'
                    : _registrationController.dobController.text,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  // textAlign: TextAlign.start, // Here's the change
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _registrationController.dobController.text =
        "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
  Widget Gender(Size size) {
    return GestureDetector(
      onTap: () {
        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final RenderBox field = fieldKey.currentContext!.findRenderObject() as RenderBox;
        final Offset target = field.localToGlobal(Offset.zero, ancestor: overlay);

        showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            target.dx,
            target.dy + field.size.height, // Adjusted to position below the field
            target.dx + field.size.width,
            target.dy + field.size.height + 10, // Adjusted for better spacing
          ),
          items: <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Male',
              child: Text('Male', style: TextStyle(color: Colors.black)),
            ),
            const PopupMenuItem<String>(
              value: 'Female',
              child: Text('Female', style: TextStyle(color: Colors.black)),
            ),
            const PopupMenuItem<String>(
              value: 'Other',
              child: Text('Other', style: TextStyle(color: Colors.black)),
            ),
          ],
        ).then((value) {
          if (value != null) {
            setState(() {
              _selectedGender = value;
              _registrationController.gender.text = value; // Update text value directly
            });
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: fieldbbackground,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.transgender_rounded,
                color: Colors.white70,
              ),
              const SizedBox(width: 16),
              SvgPicture.string(
                '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                width: 1.0,
                height: 15.5,
              ),
              const SizedBox(width: 16),
              Text(
                _selectedGender.isNotEmpty ? _selectedGender : 'Gender',
                style: TextStyle(color: Colors.white70),
                key: fieldKey, // Key for accessing the field's RenderBox
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget passwordTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: fieldbbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // lock logo here
            const Icon(
              Icons.lock,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            // divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            // password textField
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: _registrationController.password,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible, // Toggle the obscureText property
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.passwordlabel}',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible; // Toggle visibility
                      });
                    },
                    child: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget ConfirmPassword(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: fieldbbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // lock logo here
            const Icon(
              Icons.lock,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            // divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            // password textField
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: _registrationController.confirm_password,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_confirmPasswordVisible, // Toggle the obscureText property
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.confirmpassword}',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible; // Toggle visibility
                      });
                    },
                    child: Icon(
                      _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget customTextWidget(String text, {bool flag = true}) {
    return flag
        ? Text(
      text,
      style: TextStyle(
        fontSize: 19,
        color: Colors.white,
      ),
      textAlign: TextAlign.left,
    )
        : SizedBox.shrink(); // If flag is false, return an empty SizedBox
  }
  Widget signInButton(Size size) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if (_registrationController.first_name.text.isEmpty) {
            setState(() {
              _fnameflag = true; // Set flag to true for first name
            });
          } else {
            setState(() {
              _fnameflag = false; // Set flag to true for first name
            });
          }
          if (_registrationController.last_name.text.isEmpty) {
            setState(() {
              _lnameflag = true; // Set flag to true for last name
            });
          } else {
            setState(() {
              _lnameflag = false; // Set flag to true for first name
            });
          }
          if (_registrationController.email.text.isEmpty) {
            setState(() {
              _emailflag = true; // Set flag to true for email
            });
          } else {
            setState(() {
              _emailflag = false; // Set flag to true for first name
            });
          }
          if (_selectedGender.isEmpty) {
            setState(() {
              _genderflag = true; // Set flag to true for gender
            });
          } else {
            setState(() {
              _genderflag = false; // Set flag to true for first name
            });
          }
          if (_registrationController.dobController.text.isEmpty) {
            setState(() {
              _dobflag = true; // Set flag to true for date of birth
            });
          } else {
            setState(() {
              _dobflag = false; // Set flag to true for first name
            });
          }
          if (_registrationController.password.text.isEmpty) {
            setState(() {
              _passwordflag = true; // Set flag to true for password
            });
          } else {
            setState(() {
              _passwordflag = false; // Set flag to true for first name
            });
          }
          if (_registrationController.confirm_password.text.isEmpty) {
            setState(() {
              _confirmpasswordflag = true; // Set flag to true for confirm password
            });
          } else {
            setState(() {
              _confirmpasswordflag = false; // Set flag to true for first name
            });
          }

          // Proceed with registration only if all fields are filled
          if (!_fnameflag && !_lnameflag && !_emailflag && !_genderflag && !_dobflag && !_passwordflag && !_confirmpasswordflag) {
            _registrationController.phone_number.text = widget.phoneNumber;
            _registrationController.country_code.text = widget.countryCode;
            _registrationController.country.text = widget.country;
            setState(() {
              isLoading = true;
            });

            _showPleaseWaitDialog();

            _registrationController.registerFunction(context);
          }
        });
        // Register();
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFFFFFFF),
        ),
        child: Text(
          '${AppLocalizations.of(context)!.signup}',
          style: GoogleFonts.inter(
            fontSize: 22.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  Widget buildContinueText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Expanded(
            child: Divider(
              color: Colors.white,
            )),
        Expanded(
          child: Text(
            '${AppLocalizations.of(context)!.orcontinuewith}',
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(
            child: Divider(
              color: Colors.white,
            )),
      ],
    );
  }
  Widget buildFooter(Size size) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.nunito(
            fontSize: 16.0,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: '${AppLocalizations.of(context)!.donthaveaccountlabel}',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '${AppLocalizations.of(context)!.singinlabel}',
              style: GoogleFonts.nunito(
                color: const Color(0xFFF9CA58),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

