import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Loader extends StatelessWidget{
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_j0xeoest.json",width: 100),
      ),
    );
  }
}