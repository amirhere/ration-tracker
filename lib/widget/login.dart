import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:login_app_flutter/widget/home.dart';
import 'package:http/http.dart' as http;






class LoginPage extends StatefulWidget{


  static String tag ='login-page';
   //
  bool status = true;

  @override
  _LoginPageState createState()=> new _LoginPageState();





}





class _LoginPageState extends State<LoginPage> {


  // String address = "lima chuchu";

  void loginRequest () async {

    final uri = 'http://eb549d96.ngrok.io/findRecord.php';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "cnic": "4230193097619"

    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );



    int statusCode = response.statusCode;
    print(response.body);
    Map record = json.decode(response.body);
   // Map status = json.decode(response.body);
  //  print(status[status]);

     //this.address = record['record']['address'].toString();
     String family_head = record['details']['family_head'].toString();
     String address = record['details']['address'].toString();
     String cnic = record['details']['cnic'].toString();
    // print(response.body.status);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
    prefs.setString('cnic', address);


    prefs.setString('family_head', address).then((bool status){
      print("Data saved successfully into sharedpreference");

    });



    if(statusCode == 200){
      Navigator.of(context).pushNamed(HomePage.tag);
    }

  }










  @override
  Widget build(BuildContext context) {

    bool status = true;


    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.lightBlue,
        radius: 48.0,
        child: Image.asset('asserts/logo.png'),
      ),
    );



    final familyNumber = Image(image: AssetImage('graphics/background.png'));
  //  ProgressDialog pr;

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
     // initialValue: 'khasancsit@gmail.com',
      decoration: InputDecoration(
        hintText: 'Enter family number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      obscureText: true,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );





    final showProgressBar =  Offstage(
      offstage: true,
      child: Image(
          image: AssetImage('asserts/tenor.gif'),
          width: 50,
          height: 50
      ),
    );


    final hideProgressBar =  Offstage(
      offstage: false,
      child: Image(
          image: AssetImage('asserts/tenor.gif'),
          width: 50,
          height: 50
      ),
    );








    void _showDialog(){
          showDialog(
           context: context,
            builder: (BuildContext context){
              return AlertDialog(

                title: new Text ("Record not found"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Add family record"),
                    onPressed: () {


                      Navigator.of(context).pop();
                      //Navigator.of(context).pushNamed(HomePage.tag);
                     // Navigator.of(context).pushNamed();
                    },
                  ),
                ],

              );
            },
          );

      }





    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: (){


          //tatus = false;
         // showProgressBar = true;



         // Navigator.of(context).pushNamed(HomePage.tag);
         loginRequest();

        //  _showDialog();

        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Proceed',style: TextStyle(color: Colors.white),),
      ),
      );



      final forgotLabel = FlatButton(
        child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: (){},
      );




    final  poweredBy = Padding(
        padding: EdgeInsets.only(
          left:0,
        ),
        child:  Image(
            image: AssetImage('asserts/poweredby.png'),
            // width: 10,
            height:18
        )
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
            SizedBox(height: 24.0),
            loginButton,
            if(status)
              showProgressBar
             else
               hideProgressBar,
            SizedBox(height: 40.0),
            poweredBy
          ],
        ),
      ),
    );
  }
}