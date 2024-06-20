import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;

  const OrderDetails({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Map<String, dynamic> _orderDetails = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userid') ?? 0;

    String apiUrl = 'https://thetarotguru.com/tarotapi/order_details.php';

    var response = await http.post(Uri.parse(apiUrl), body: {
      'type': 'fetchOrderDetails',
      'user_id': userId.toString(),
      'order_id': widget.orderId,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        setState(() {
          _orderDetails = responseData['orderDetails'];
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
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _orderDetails.isNotEmpty
              ? ListView(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height+20,
              ),

              ..._orderDetails['items'].map<Widget>((item) => Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  title: Text('Product Name: ${item['product_name']}',style: TextStyle(color: Colors.black),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${item['quantity']}',style: TextStyle(color: Colors.black),),
                      Text('Price: ${item['price']}',style: TextStyle(color: Colors.black),),
                      Text('Total Value: ${item['total_value']}',style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              )
              ).toList(),
              ListTile(
                title: Text('Order Status: ${_orderDetails['order_status']}',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('Order Date: ${_orderDetails['order_date']}',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('Billing Name: ${_orderDetails['billing_name']}',style: TextStyle(color: Colors.white),),
              ),

              ListTile(
                title: Text('Address:',style: TextStyle(color: Colors.white),),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_orderDetails['address_line1']}, ${_orderDetails['address_line2']}',style: TextStyle(color: Colors.white,fontSize: 16)),
                    Text('${_orderDetails['city']}, ${_orderDetails['state']}, ${_orderDetails['postal_code']}',style: TextStyle(color: Colors.white,fontSize: 16))
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price:',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                    Text('₹${_orderDetails['total_price']}/-',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              SizedBox(height: 20),

            ],
          )
              : Center(child: Text('No order details found')),
        ],
      )
    );
  }
}
