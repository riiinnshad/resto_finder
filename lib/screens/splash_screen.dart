import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resto_finder/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void keepLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("Username");
    print("username--------------$username");
    if (username != null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Homepage(),
        ));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LogIn(),
        ));
      });
    }
  }

  @override
  void initState() {
    keepLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'Assets/baground2.jfif',
                    ),
                    fit: BoxFit.cover)),
            child: Center(
              child: Container(
                height: h * 0.5,
                width: w * 0.5,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(w * 0.030),
                ),
                child: Image.asset('Assets/RestoFinderLogo-01-01.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
