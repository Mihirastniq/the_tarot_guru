import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/other_screens/rider_saved_spred_details.dart';

class RiderSavedSpreadList extends StatefulWidget {
  const RiderSavedSpreadList({super.key});

  @override
  State<RiderSavedSpreadList> createState() => _RiderSavedSpreadListState();
}

class _RiderSavedSpreadListState extends State<RiderSavedSpreadList> {

  List<Map<String, dynamic>> savedSpreads = [];

  @override
  void initState() {
    super.initState();
    fetchSavedSpreads();
  }

  Future<void> fetchSavedSpreads() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedSpreadStrings = prefs.getStringList('savedSpreads');
    if (savedSpreadStrings != null) {
      setState(() {
        savedSpreads = savedSpreadStrings
            .map<Map<String, dynamic>>((spreadString) => jsonDecode(spreadString))
            .where((spread) => spread['tarotType'] == 'Rider Waite')
            .toList();
      });
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
                  Color(0xFF171625),
                  Color(0xFF171625),
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
                '${AppLocalizations.of(context)!.apptitle}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    AppBar().preferredSize.height,
                child: savedSpreads.isEmpty
                    ? Center(
                  child: Text(
                    'No spreads saved',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
                    : ListView.builder(
                  itemCount: savedSpreads.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Text(
                          savedSpreads[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(savedSpreads[index]['spreadName']),
                        // Add onTap handler to navigate to spread details
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RiderSavedSpreadDetails(
                                    selectedCards: savedSpreads[index]
                                    ['selectedCardIds'],
                                    tarotType: savedSpreads[index]
                                    ['tarotType'],
                                    spreadName: savedSpreads[index]
                                    ['spreadName'],
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
