import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:the_tarot_guru/main_screens/special_prediction/osho/osho_prediction.dart';

class OshoSpecialPredictionDetailFormScreen extends StatefulWidget {
  const OshoSpecialPredictionDetailFormScreen({super.key});

  @override
  State<OshoSpecialPredictionDetailFormScreen> createState() => _OshoSpecialPredictionDetailFormScreenState();
}

class _OshoSpecialPredictionDetailFormScreenState extends State<OshoSpecialPredictionDetailFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime? _dateOfBirth;
  TimeOfDay? _birthTime;
  bool _isLoading = false;
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize = 16;
  late double ButtonFontsSize = 10;
  int? _userId;
  bool _isScrolled = false;
  List<int> _randomNumbers = [];

  @override
  void initState() {
    super.initState();
    _loadLocalData();
    _generateRandomNumbers();
  }

  _loadLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      TitleFontsSize = prefs.getDouble('TitleFontSize') ?? 23;
      SubTitleFontsSize = prefs.getDouble('SubtitleFontSize') ?? 18;
      ContentFontsSize = prefs.getDouble('ContentFontSize') ?? 16;
      ButtonFontsSize = prefs.getDouble('ButtonFontSize') ?? 18;
      _userId = prefs.getInt('userid');
    });
  }

  void _generateRandomNumbers() {
    final random = Random();
    _randomNumbers = List.generate(4, (_) => random.nextInt(79) + 1);
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime(2099),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  Future<void> _selectBirthTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _birthTime) {
      setState(() {
        _birthTime = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse('https://thetarotguru.com/tarotapi/specialfeatures/specialprediction.php'); // API endpoint
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'type': "osho",
          'userId': _userId,
          'name': _name,
          'dateOfBirth': _dateOfBirth?.toIso8601String(),
          'birthTime': _birthTime != null ? '${_birthTime!.hour}:${_birthTime!.minute}' : null,
          'randomNumbers': _randomNumbers,
        }),
      );


      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Navigate to the next screen with the random numbers
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecialPredictionOshoPrediction(randomNumbers: _randomNumbers),
          ),
        );
        print('Body is : ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sucess.'),
        ));
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to submit details.'),
        ));
      }
    }
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
                  Color.fromRGBO(19, 14, 42, 1),
                  Color.fromRGBO(19, 14, 42, 1),
                  Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/other/bluebg.jpg', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels > 0) {
                if (!_isScrolled) {
                  setState(() {
                    _isScrolled = true;
                  });
                }
              } else {
                if (_isScrolled) {
                  setState(() {
                    _isScrolled = false;
                  });
                }
              }
              return true;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 25),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.05,
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.oshodetailformtitle}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.oshodetailformsubtitle}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TitleFontsSize,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    labelText: 'Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _name = value!;
                                  },
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () => _selectDateOfBirth(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: 'Date of Birth',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (_dateOfBirth == null) {
                                          return 'Please select your date of birth';
                                        }
                                        return null;
                                      },
                                      controller: TextEditingController(
                                        text: _dateOfBirth == null
                                            ? ''
                                            : DateFormat('dd/MM/yyyy').format(_dateOfBirth!), // Updated line
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () => _selectBirthTime(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: 'Birth Time',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      // validator: (value) {
                                      //   if (_birthTime == null) {
                                      //     return 'Please select your birth time';
                                      //   }
                                      //   return null;
                                      // },
                                      controller: TextEditingController(
                                        text: _birthTime == null
                                            ? ''
                                            : '${_birthTime!.hourOfPeriod}:${_birthTime!.minute} ${_birthTime!.period == DayPeriod.am ? 'AM' : 'PM'}',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22),
                                _isLoading
                                    ? CircularProgressIndicator()
                                    : ElevatedButton(
                                  onPressed: _submitForm,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ButtonFontsSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple.shade900, // Background color
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              scrolledUnderElevation: 1,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_circle_left,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              leadingWidth: 35,
              backgroundColor: _isScrolled ? Colors.deepPurple.shade900.withOpacity(1) : Colors.transparent,
              elevation: 0,
              title: Text(
                '${AppLocalizations.of(context)!.apptitle}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}