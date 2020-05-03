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

   /* final uri = 'http://d1ecfd1f.ngrok.io/findRecord.php';
    final headers = {'Content-Type': 'application/json'};


    body: jsonEncode(<String, String>{
      'cnic': '4230193097419',
    });
*/

    final http.Response response = await http.post(
      'http://346587b4.ngrok.io/findRecord.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cnic': '4230193097419',
      }),
    );


    print(response.body);

   // Map record = json.decode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print(response.body);

      Map record = json.decode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('address', record['details']['address'].toString());
      prefs.setString('cnic', record['details']['cnic'].toString());
      prefs.setString('family_head', record['details']['family_head'].toString());
      prefs.setString('ration_distribution_date', record['details']['ration_distribution_date'].toString());









      Navigator.of(context).pushNamed(HomePage.tag);

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
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