// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sample_vlc_player/splash_screen.dart';

/// TODO: Add examples using [Environment] and [MediaStore] API
void main() => runApp(const Root());

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}
