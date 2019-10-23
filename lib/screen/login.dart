import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/teste.jpg"), fit: BoxFit.cover)
          ,
        ),
        child: SingleChildScrollView(
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
                      fillColor: Colors.black54.withOpacity(0.25),
                      hintText: " Digite seu email",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Container(
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                        color: Colors.black,
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
                      fillColor: Colors.black54.withOpacity(0.25),
                      hintText: " Digite a Senha",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Container(
                        child: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        color: Colors.black,
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
                new Container(
                  margin: EdgeInsets.only(left: 40.0, right: 40.0),
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.transparent)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.https),
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ]),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {},
                    elevation: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
//          onWillPop: () {
//            SystemNavigator.pop();
//          }
      ),
    );
  }
}
