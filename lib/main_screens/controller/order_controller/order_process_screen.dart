import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/main_screens/other_screens/add_address.dart';
import 'package:the_tarot_guru/main_screens/subscription/success.dart';
import '../../Products/cart_functions.dart';

class OrderProcess extends StatefulWidget {
  const OrderProcess({super.key});

  @override
  State<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {

  late SharedPreferences _prefs;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  int? userid = 0;

  @override
  void initState() {
    super.initState();
    _retrieveUserData();
  }

  Future<void> _retrieveUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = _prefs.getString('firstName') ?? '';
      _lastName = _prefs.getString('lastName') ?? '';
      _email = _prefs.getString('email') ?? '';
      _phoneNumber = _phoneNumber = (_prefs.getInt('phone') ?? 0).toString();
      userid = _prefs.getInt('userid') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xFF100E0E),
        title: Text('Order Process - user Details'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Details',
                    style: TextStyle(fontSize: 20,color: Colors.white ,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'First Name',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      style: TextStyle(fontSize: 16.0),
                      controller: TextEditingController(text: _firstName),
                      onChanged: (value) => _firstName = value,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Last Name',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      style: TextStyle(fontSize: 16.0),
                      controller: TextEditingController(text: _lastName),
                      onChanged: (value) => _lastName = value,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'E-mail',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      style: TextStyle(fontSize: 16.0),
                      controller: TextEditingController(text: _email),
                      onChanged: (value) => _email = value,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      style: TextStyle(fontSize: 16.0),
                      controller: TextEditingController(text: _phoneNumber),
                      onChanged: (value) => _phoneNumber = value,
                    ),
                  ),

                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BillingInformation()
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Set button color to black
                        minimumSize: Size(double.infinity, 50), // Set full width
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, // Increase font size
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}

class BillingInformation extends StatefulWidget {
  const BillingInformation({super.key});

  @override
  State<BillingInformation> createState() => _BillingInformationState();
}

class _BillingInformationState extends State<BillingInformation> {
  late SharedPreferences _prefs;
  List<Map<String, dynamic>> _addresses = [];
  int _selectedAddressIndex = 0; // Add this line

  @override
  void initState() {
    super.initState();
    _retrieveBillingDetails();
  }
  Future<void> _retrieveBillingDetails() async {
    _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userid') ?? 0;
    if (userId != 0) {
      try {
        String uri = "https://thetarotguru.com/tarotapi/addresses.php";
        var requestBody = {
          "user_id": (userId).toString(),
          "type":'fetchAddress',
        };
        var response = await http.post(Uri.parse(uri), body: requestBody);

        // Parse the response and update _addresses list
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          List<Map<String, dynamic>> addresses = [];
          for (var addressData in jsonResponse['addresses']) {
            addresses.add(Map<String, dynamic>.from(addressData));
          }
          setState(() {
            _addresses = addresses;
          });
        } else {
        }
      } catch (e) {
        print('Error fetching addresses: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order Process - billing details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25,right: 25,top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Billing Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddAddressScreen(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add,color: Colors.black,)
                      ),
                      IconButton(
                          onPressed: (){
                            _retrieveBillingDetails();
                          },
                          icon: Icon(Icons.refresh,color: Colors.black,)
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 16),
              _addresses.isEmpty
                  ? Text(
                'No address found',
                style: TextStyle(fontSize: 16),
              )
                  : Column(
                children: List.generate(
                  _addresses.length,
                      (index) {
                    Map<String, dynamic> address = _addresses[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(address['billing_name']),
                          subtitle: Text(
                              '${address['address_line1']}, ${address['address_line2']}, ${address['city']}, ${address['state']}, ${address['country']} - ${address['postal_code']}'),
                          tileColor: _selectedAddressIndex == index
                              ? Colors.lightGreen.withOpacity(0.2)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: _selectedAddressIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                              width: _selectedAddressIndex == index ? 2 : 1,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedAddressIndex = index;
                            });
                          },
                        ),
                        SizedBox(height: 8), // Add space between each address
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: _selectedAddressIndex != -1 ? () {
                        print(_addresses[_selectedAddressIndex]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOutScreen(
                              billingname: _addresses[_selectedAddressIndex]['billing_name'],
                              selectedaddress: _addresses[_selectedAddressIndex]['address_id'],
                              addressline1: _addresses[_selectedAddressIndex]['address_line1'],
                              addressline2: _addresses[_selectedAddressIndex]['address_line2'],
                              addresscity: _addresses[_selectedAddressIndex]['city'],
                              addressstate: _addresses[_selectedAddressIndex]['state'],
                              addresscountry: _addresses[_selectedAddressIndex]['country'],
                              addresspincode: _addresses[_selectedAddressIndex]['postal_code'],
                            ),
                          ),
                        );
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedAddressIndex != -1 ? Colors.black : Colors.grey, // Set button color to black
                        minimumSize: Size(double.infinity, 50), // Set full width
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, // Increase font size
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckOutScreen extends StatefulWidget {
  final String selectedaddress;
  final String billingname;
  final String addressline1;
  final String addressline2;
  final String addresscity;
  final String addressstate;
  final String addresscountry;
  final String addresspincode;


  const CheckOutScreen({
    super.key,
    required this.selectedaddress,
    required this.billingname,
    required this.addressline1,
    required this.addressline2,
    required this.addresscity,
    required this.addressstate,
    required this.addresscountry,
    required this.addresspincode});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  late SharedPreferences _prefs;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  List<Map<String, dynamic>> _addresses = [];
  List<Map<String, dynamic>> _cartItems = [];
  late Razorpay _razorpay;
  int? userid = 0;

  @override
  void initState() {
    _retrieveUserData();
    _retrieveBillingDetails();
    _fetchCartItems();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    var url = 'https://thetarotguru.com/tarotapi/orderHandler.php';

    // Create a list to store the products
    List<Map<String, dynamic>> products = [];

    // Populate the products list from the cart items
    for (var item in _cartItems) {
      products.add({
        'product_id': item['productId'].toString(),
        'quantity': item['quantity'].toString(),
      });
    }

    // Construct the body
    var body = {
      "type": "order",
      'user_id': userid.toString(),
      'payment_amount': _totalCartValue.toString(),
      'payment_mode': 'razorpay',
      'payment_id': response.paymentId,
      'payment_date': DateTime.now().toIso8601String(),
      'payment_status': 'Success',
      'payment_type': 'order',
      'user_name': _firstName + _lastName,
      'billing_name': '${widget.billingname}',
      'address_id': widget.selectedaddress,
      'order_date': DateTime.now().toString(),
      'total_price': _totalCartValue.toString(),
      'products': json.encode(products), // Convert products list to JSON string
    };

    try {
      await _cartService.clearCart();

      var webresponse = await http.post(Uri.parse(url), body: body);
      var responseData = json.decode(webresponse.body);
      if (responseData['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubscriptionSuccessPage(title: 'Thank you for subscribe',)),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Navigator.pop(context);
  }

  void _startPayment() {
    var userDetails = {
      'userId': userid,
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
    };
    var options = {
      'key': 'rzp_live_BOSf3y7tudC48z',
      'amount': _totalCartValue * 100,
      'name': 'The Tarot Guru',
      'description': 'order_controller',
      'prefill': {'contact': '$_phoneNumber', 'email': '$_email'},
      'external': {
        'wallets': ['paytm']
      },
      'notes': userDetails,
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _retrieveUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = _prefs.getString('firstName') ?? '';
      _lastName = _prefs.getString('lastName') ?? '';
      _email = _prefs.getString('email') ?? '';
      _phoneNumber = _phoneNumber = (_prefs.getInt('phone') ?? 0).toString();
      userid = _prefs.getInt('userid') ?? 0;
    });

  }

  Future<void> _retrieveBillingDetails() async {
    _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userid') ?? 0;
    if (userId != 0) {
      try {
        String uri = "https://thetarotguru.com/tarotapi/addresses.php";
        var requestBody = {
          "user_id": (userId).toString(),
          "type":'fetchAddress',
        };
        var response = await http.post(Uri.parse(uri), body: requestBody);
        
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          List<Map<String, dynamic>> addresses = [];
          for (int i = 0; jsonResponse[i.toString()] != null; i++) {
            addresses.add(Map<String, dynamic>.from(jsonResponse[i.toString()]));
          }
          setState(() {
            _addresses = addresses;
          });
        } else {
        }
      } catch (e) {
        print('Error fetching addresses: $e');
      }
    }
  }

  CartService _cartService = CartService();
  double _totalCartValue = 0.0;

  Future<void> _fetchCartItems() async {
    try {
      List<Map<String, dynamic>> cart = await _cartService.getCart();
      setState(() {
        _cartItems = cart;
        _updateTotalCartValue();
      });
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  void _updateTotalCartValue() {
    double totalValue = 0.0;
    for (var item in _cartItems) {
      totalValue += (item['productPrice'] * item['quantity']);
    }
    setState(() {
      _totalCartValue = totalValue;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: 25,right: 25,
              top: 35
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display Cart Items
                Text(
                  'Cart Items',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = _cartItems[index];
                    return ListTile(
                      title: Text(item['productName']),
                      subtitle: Text('Quantity: ${item['quantity']}'),
                      trailing: Text('\₹${item['productPrice']}'),
                    );
                  },
                ),
                SizedBox(height: 16),

                // Display User's Billing Details
                Text(
                  'Billing Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('${widget.billingname}'),
                SizedBox(height: 16),
                Text('${widget.addressline1}, ${widget.addressline2}, ${widget.addresscity}, ${widget.addressstate} ${widget.addresspincode}'),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {_startPayment();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Set button color to black
                      minimumSize: Size(double.infinity, 50), // Set full width
                    ),
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

