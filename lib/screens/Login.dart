import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnafish/Components/Loading.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';

class login extends StatefulWidget {
  final Function redirect;
  login({this.redirect});

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final services _authentication = services();
  //for validations
  final _key = GlobalKey<FormState>();
  String error = '';
  bool load = false;

    //text fields for  login
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {

    return load ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                widget.redirect();
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ))),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/login-icon.png'),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ),
                Container(
                    child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? 'Enter email' : null,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: newTextInputDecoration.copyWith(
                                  labelText: "E-Mail",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: (val) => val.length < 5
                                  ? 'Enter a password more than 5 characters'
                                  : null,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: newTextInputDecoration.copyWith(
                                labelText: "Pasword",
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.white,
                                ),
                              ),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 50.0,
                              width: 250.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment(0.9, 0.0),
                                  colors: [Colors.blueAccent, Colors.indigo],
                                ),
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  textColor: Colors.white,
                                  color: Colors.transparent,
                                  child: Text('Sign In',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onPressed: () async {
                                    if (_key.currentState.validate()) {
                                      setState(()=> load = true);
                                      dynamic output = await _authentication
                                          .login(email, password);
                                      if (output == null) {
                                        setState(() => error =
                                            'incorret password or email !');
                                            load = false;
                                      }
                                    }
                                  }),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style:
                                  TextStyle(fontSize: 15.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
