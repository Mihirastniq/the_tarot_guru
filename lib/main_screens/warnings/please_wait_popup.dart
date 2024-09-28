import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PleaseWaitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Dialog(
        backgroundColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitRipple(color: Colors.white),
              SizedBox(height: 20.0),
              const Text('Please Wait...', style: TextStyle(fontSize: 16.0,color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
