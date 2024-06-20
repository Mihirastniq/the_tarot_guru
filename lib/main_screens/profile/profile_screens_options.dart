import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/controller/session_controller.dart';
import 'package:the_tarot_guru/main_screens/other_screens/add_address.dart';
import 'package:the_tarot_guru/main_screens/profile/orders.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late String _firstName = '';
  late String _lastName = '';
  late String _email = '';
  late int _phone = 0;
  late String _language = '';
  late String _createdAt = '';
  final LoginController loginController = LoginController();
  bool pinEnabled = false;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
    fetchEnablePin();
  }

  // Update enablePin value in SharedPreferences
  Future<void> updateEnablePin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enablePin', value);
  }

  Future<void> fetchEnablePin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pinEnabled = prefs.getBool('enablePin') ?? false;
    });
  }

  Future<void> _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = prefs.getString('firstName') ?? '';
    _lastName = prefs.getString('lastName') ?? '';
    _email = prefs.getString('email') ?? '';
    _phone = prefs.getInt('phone') ?? 0;
    // _appPin = prefs.getInt('appPin') ?? 0;
    _language = prefs.getString('lang') ?? '';
    _createdAt = prefs.getString('created_at') ?? '';
    // _subscriptionStatus = prefs.getInt('subscription_status') ?? 0;
    setState(() {});
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
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                margin:
                    EdgeInsets.only(top: AppBar().preferredSize.height + 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User Name:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_firstName $_lastName',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'E-mail:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone Number:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_phone',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),

                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Join Date:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_createdAt',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected language:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_language',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),

                    ProfileButton(
                        text: '${AppLocalizations.of(context)!.logoutlabel}',
                        onPressed: (){
                          loginController.logout(context);
                        },
                        icon: Icons.language),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class UserAddresses extends StatefulWidget {
  const UserAddresses({Key? key}) : super(key: key);

  @override
  State<UserAddresses> createState() => _UserAddressesState();
}

class _UserAddressesState extends State<UserAddresses> {
  late int _userId;
  List<Map<String, dynamic>> _addresses = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserAddress();
  }

  Future<void> _fetchUserAddress() async {
    setState(() {
      _isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('userid') ?? 0;
    });

    String apiUrl = 'https://thetarotguru.com/tarotapi/addresses.php';

    var response = await http.post(Uri.parse(apiUrl), body: {
      'type': 'fetchAddress',
      'user_id': _userId.toString(),
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        setState(() {
          _addresses =
              List<Map<String, dynamic>>.from(responseData['addresses']);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _removeaddress(String address_id) async {
      try {
        String uri = "https://thetarotguru.com/tarotapi/addresses.php";
        var requestBody = {
          "type": "removeAddress",
          "address_id": address_id,
        };

        var response = await http.post(Uri.parse(uri), body: requestBody);

        if (response.statusCode == 200) {
          Navigator.of(context).pop(); // Close the screen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to remove address. Please try again later.'),
            ),
          );
        }
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error removing address. Please try again later.'),
          ),
        );
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
                'Addresses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : _addresses.isNotEmpty
                    ? ListView.builder(
                        itemCount: _addresses.length,
                        itemBuilder: (context, index) {
                          // Extract the address details from the response
                          Map<String, dynamic> address = _addresses[index];

                          // Create a container for each address
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: 10,
                                left: 20,
                                right: 20,
                                top: AppBar().preferredSize.height + 50),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Address ${index + 1}:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text('${address['address_line1']}, ${address['address_line2']}'),
                                Text('City: ${address['city']}'),
                                Text('State: ${address['state']}'),
                                Text('Country: ${address['country']}'),
                                Text('Postal Code: ${address['postal_code']}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){
                                      _removeaddress(address['address_id']);
                                    }, icon: Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No addresses found',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAddressScreen()),
                              );
                            },
                            child: Text('Add Address'),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late int _userId;
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserOrders();
  }

  Future<void> _fetchUserOrders() async {
    setState(() {
      _isLoading = true;
    });

    // Fetch user ID from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userid') ?? 0;

    // API endpoint URL
    String apiUrl = 'https://thetarotguru.com/tarotapi/fetchorders.php';

    var response = await http.post(Uri.parse(apiUrl), body: {
      'type': 'fetchOrders',
      'user_id': _userId.toString(),
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        setState(() {
          _orders = List<Map<String, dynamic>>.from(responseData['orders']);
          _isLoading = false;
        });
      } else {
        // No orders found
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Error in API request
      setState(() {
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Success':
        return Colors.green.shade900;
      case 'Reject':
        return Colors.red.shade900;
      case 'Processing':
        return Colors.grey.shade900;
      case 'Approved':
        return Colors.yellow.shade900;
      case 'Shipped':
        return Colors.orange.shade900;
      default:
        return Colors.grey;
    }
  }
  Color _getbackgriundColor(String status) {
    switch (status) {
      case 'Success':
        return Colors.green.shade100;
      case 'Reject':
        return Colors.red.shade100;
      case 'Processing':
        return Colors.grey.shade400;
      case 'Approved':
        return Colors.yellow.shade100;
      case 'Shipped':
        return Colors.orange.shade200;
      default:
        return Colors.grey;
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
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AppBar().preferredSize.height+20),
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : _orders.isNotEmpty
                  ? ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  print(_orders.length);
                  // Extract order details from the list
                  Map<String, dynamic> order = _orders[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderDetails(orderId: order['id'])),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order ${index + 1}:',
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color:_getStatusColor(order['order_status']),
                                    width: 1
                                  ),
                                  color: _getbackgriundColor(order['order_status']),
                              ),
                                child: Text('${order['order_status']}',
                                  style: TextStyle(color: _getStatusColor(order['order_status']), fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 8),
                          Text('Order ID: ${order['order_id']}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text('Billing Name: ${order['billing_name']}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text('Order Date: ${order['order_date']}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text('Total Price: ${order['total_price']}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : Text(
                'No orders found',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

