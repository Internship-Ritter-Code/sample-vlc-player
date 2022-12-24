// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample_vlc_player/home_screen.dart';
import 'package:sample_vlc_player/request_permission_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5), () async {
      if (!await Permission.storage.isGranted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => RequestPermissionPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 100,
          curve: Curves.bounceInOut,
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}
