import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kantin_moklet/AdminPage.dart';
import 'package:kantin_moklet/dashboard.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = new MaterialApp(
      title: 'Login Page',
      home: new LoginPage(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) => new AdminPage(),
        '/MemberPage': (BuildContext context) => new HotelHomePage(),
      },
    );
    return materialApp;
  }
}

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response = await http.post("http://10.0.2.2/kamo/login/php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Failed";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.red[50],
        radius: 60.0,
        child: Image.asset('images/kamoilustrasi.png'),
      ),
    );

    final email = TextFormField(
      // keyboardType: TextInputType.emailAddress,
      autofocus: false,
      // initialValue: 'krisna',
      controller: user,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      // initialValue: 'krisna',
      obscureText: true,
      controller: pass,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.red,
        elevation: 5.0,
        child: RaisedButton(
          onPressed: () {
            _login();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HotelHomePage()));
          },
          color: Colors.redAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    Text(
      msg,
      style: TextStyle(fontSize: 20.0, color: Colors.red),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
