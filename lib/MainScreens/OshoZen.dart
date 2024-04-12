import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/Deck/OshoOptionDeck.dart';
import 'package:the_tarot_guru/MainScreens/Drawer/drawer.dart';
import 'package:the_tarot_guru/MainScreens/spread/osho_new_spread.dart';
import 'package:the_tarot_guru/MainScreens/subscription/subscribe.dart';

class OshoZenTarot extends StatefulWidget {
  @override
  _AppSelectState createState() => _AppSelectState();
}

class _AppSelectState extends State<OshoZenTarot> with TickerProviderStateMixin{
  int _selectedIndex = 0;
  late TabController _tabController = TabController(length: 2, vsync: this);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  // ignore: unused_field
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
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
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.segment_rounded,
                      color: Colors.white,
                      size: 35,
                    )),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubscribeApp(),
                    ),
                  );
                }, icon: Icon(
                  Icons.money,
                  size: 30,
                  color: Colors.white,
                ))
              ],
              title: Text(
                'The Tarot Guru',
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
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height- AppBar().preferredSize.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 25),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome To,',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              'Osho Zen Tarot',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewSpread(tarotType: "Osho Zen"),
                                      ),
                                    );
                                  },
                                  text: "New Spread",
                                  color1: Color(0xFF8826FE),
                                  color2: Color(0xFF9443F6),
                                  icons: Icons.add,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DeckScreen(tarotType: "Osho Zen"),
                                      ),
                                    );
                                  },
                                  text: "Deck",
                                  color1: Color(0xFFD7735C),
                                  color2: Color(0xFFD87D68),
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png',
                                icons: Icons.apps,
                              ),
                              _buildButton(
                                  onPressed: () {

                                  },
                                  text: "Saved Spread",
                                  color1: Color(0xFF00B493),
                                  color2: Color(0xFF1BB89C),
                                  icons: Icons.folder,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              _buildButton(
                                  onPressed: () {},
                                  text: "About Osho Zen",
                                  color1: Color(0xFF32C0D4),
                                  color2: Color(0xFF00A7BE),
                                  icons: Icons.question_mark,
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton({
    required Function()? onPressed,
    required String text,
    required Color color1,
    required Color color2,
    required double opacity,
    required String imagePath, required IconData icons,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity, // Full width
        height: 120.0, // Set desired height
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141945).withOpacity(0.1),Colors.deepPurple.shade900.withOpacity(0.1)],
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.shade900.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/other/stars.png'),
              fit: BoxFit.cover
            )
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 0.5,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(
                            icons,
                            color: Color(0xFF141945),
                            size: 35,
                          )
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

}

