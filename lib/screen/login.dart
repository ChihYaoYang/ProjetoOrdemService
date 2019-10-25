import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/tabbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/login_image.jpg",
            fit: BoxFit.cover,
            height: 1000,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 10.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/user.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.red.withOpacity(0.25),
                        hintText: " Digite seu email",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Container(
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                          color: Colors.redAccent,
                        ),
                      ),
                      controller: _emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatório !";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.red.withOpacity(0.25),
                        hintText: " Digite a Senha",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Container(
                          child: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          color: Colors.redAccent,
                        ),
                        suffixIcon: Container(
                          child: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      controller: _senhaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatório !";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.all(10),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.transparent)),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBarMenu()));
                        },
                        elevation: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
