import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import '../main.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isChecked = false;

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: h * 0.29,
                width: w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.03),
                    image: DecorationImage(
                        image: AssetImage('Assets/dish1.jfif'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Log\nYour account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: w * 0.07)),
                ],
              ),
              SizedBox(
                height: h * 0.03,
              ),
              TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                    labelText: 'User name',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.08),
                    )),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Enter password',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.08),
                    )),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                  Text(
                    'Remember me',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: w * 0.22,
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Colors.black38, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: h * 0.03,
              ),
              InkWell(
                onTap: () async {
                  if (namecontroller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter Your UserName")));
                  } else if (passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter Your Password")));
                  } else {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString("Username", namecontroller.text.trim());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homepage(),
                        ));
                  }
                },
                child: Container(
                  width: w,
                  height: h * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.05),
                    color: Colors.black.withOpacity(0.8),
                  ),
                  child: Center(
                      child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
