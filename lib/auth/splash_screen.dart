import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Image.asset('assets/images/aiims.webp'),
                // Image.network(
                //     "https://www.milesweb.com/img-assets/client-logo/aiims.png"),
              ),
    );
  }
}