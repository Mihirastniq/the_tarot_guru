import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cart.dart';
import 'designtheme.dart';
import 'cart_functions.dart';

class ProductInfoScreen extends StatefulWidget {
  final int productid;

  ProductInfoScreen({
    required this.productid,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  int quantity = 1;

  String ProductName = "";
  double ProductPrice = 895;
  String ProductFirstImage = '';
  String ProductSecondImage = '';
  String ProductDiscription = "";
  int TotalSold = 0;
  int OrderValue = 0;


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    fetchProductDetails();
    super.initState();
  }

  Future<void> fetchProductDetails() async {
    String uri = "https://thetarotguru.com/tarotapi/productsapi.php";
    var requestBody = {
      'request_type': 'ProductsData',
      'productId': '${widget.productid}',
    };

    var res = await http.post(Uri.parse(uri), body: requestBody);

    if (res.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(res.body);
      if (jsonResponse.isNotEmpty) {
        Map<String, dynamic> productData = jsonResponse[0];
        ProductName = productData['title'];
        ProductDiscription = productData['description'];
        ProductPrice = double.parse(productData['price']);
        ProductFirstImage = productData['images'][0]['image_url'];
        if (productData['images'].length > 1 &&
            productData['images'][1] != null) {
          ProductSecondImage = productData['images'][1]['image_url'];
        } else {
          ProductSecondImage = ProductFirstImage;
        }
      } else {
      }
    } else {
    }
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void addToCart() {
    OrderValue = (ProductPrice * quantity).toInt();

    CartService().addToCart(widget.productid, ProductName, ProductPrice,
        quantity, OrderValue, ProductFirstImage);

  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
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
                'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.3),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      items: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                  imageUrl: ProductFirstImage,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(ProductFirstImage),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                  imageUrl: ProductSecondImage,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(ProductSecondImage),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.width *
                            0.8, // Set to square size
                        enlargeCenterPage: true,
                        autoPlay: false,
                        aspectRatio: 1.0, // Set aspect ratio to 1:1 for square
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF3D2E53),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: DesignCourseAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SingleChildScrollView(
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: infoHeight,
                                    maxHeight: tempHeight > infoHeight
                                        ? tempHeight
                                        : infoHeight),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 32.0, left: 18, right: 16),
                                      child: Text(
                                        ProductName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 8,
                                          top: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '₹${ProductPrice}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 22,
                                              letterSpacing: 0.27,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity: opacity2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              top: 8,
                                              bottom: 8),
                                          child: Text(
                                            ProductDiscription,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 14,
                                              letterSpacing: 0.27,
                                              color: Colors.white,
                                            ),
                                            maxLines: 500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: opacity3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, bottom: 16, right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: decrementQuantity,
                                              child: Container(
                                                height: 48,
                                                width: 48,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(16.0),
                                                  ),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.deepPurple
                                                          .withOpacity(0.5),
                                                      offset: const Offset(
                                                          1.1, 1.1),
                                                      blurRadius: 10.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Text(
                                              '$quantity',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            GestureDetector(
                                              onTap: incrementQuantity,
                                              child: Container(
                                                height: 48,
                                                width: 48,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(16.0),
                                                  ),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.deepPurple
                                                          .withOpacity(0.5),
                                                      offset: const Offset(
                                                          1.1, 1.1),
                                                      blurRadius: 10.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: addToCart,
                                                child: Container(
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(16.0),
                                                    ),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.deepPurple
                                                            .withOpacity(0.5),
                                                        offset: const Offset(
                                                            1.1, 1.1),
                                                        blurRadius: 10.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Add to Cart',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        letterSpacing: 0.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).padding.bottom,
                                    ),
                                    AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: opacity3,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CartPage(),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 16, right: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(16.0),
                                                    ),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          color: Colors
                                                              .deepPurple
                                                              .withOpacity(0.5),
                                                          offset: const Offset(
                                                              1.1, 1.1),
                                                          blurRadius: 10.0),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Go to cart',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        letterSpacing: 0.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).padding.bottom,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/Screen_Backgrounds/bg1.png',
            fit: BoxFit.cover,
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(19, 14, 42, 0.5), // Adjust opacity as needed
                    Color.fromRGBO(19, 14, 42, 0.5), // Adjust opacity as needed
                    Colors.deepPurple.shade900.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          // Full-screen image with photo_view
          Center(
            child: Container(
              color: Colors.transparent,
              child: PhotoView(
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
                imageProvider: NetworkImage(imageUrl),
              ),
            ),
          ),
          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.0,
            left: 8.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
