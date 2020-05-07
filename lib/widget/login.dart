import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:login_app_flutter/widget/home.dart';
import 'package:http/http.dart' as http;

import 'addRecord.dart';
import 'package:toast/toast.dart';






class LoginPage extends StatefulWidget{


  static String tag ='login-page';
   //



  @override
  _LoginPageState createState()=> new _LoginPageState();





}





class _LoginPageState extends State<LoginPage> {

   bool isProgressBarVisible = false;


  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));


  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(

          title: new Text (message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Add family record"),
              onPressed: () async {


                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('cnic', family_num.text.toString());

                Navigator.pop(context); // dismiss hte alert dialog
                Navigator.of(context).pushNamed(AddRecord.tag);
                // Navigator.of(context).pushNamed();
              },
            ),
          ],

        );
      },
    );

  }








  // String address = "lima chuchu";

  var family_num = TextEditingController();

  void loginRequest () async {





    setState(() {
      isProgressBarVisible = true;
    });





    final http.Response response = await http.post(
      'https://amiraslam.000webhostapp.com/ration_tracker/findRecord.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cnic': family_num.text.toString(),
      }),
    );


    setState(() {
      isProgressBarVisible = false;
    });

    print(response.body);



    if (response.statusCode == 200 || response.statusCode == 201) {


      Map record = json.decode(response.body);

      if(record['status'].toString() == "true"){

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('address', record['details']['address'].toString());
        prefs.setString('cnic', record['details']['cnic'].toString());
        prefs.setString('family_head', record['details']['family_head'].toString());
        prefs.setString('ration_distribution_date', record['details']['ration_distribution_date'].toString());

        Navigator.of(context).pushNamed(HomePage.tag);


      }else{


        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('address', "");
        prefs.setString('cnic', "");
        prefs.setString('family_head', "");
        prefs.setString('ration_distribution_date', "");



        _showDialog("No record found");
      }




    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

     // print();

      _showDialog("Please check your internet connection");

      throw Exception('Please check your internet connection');
    }





  }










  @override
  Widget build(BuildContext context) {

    bool status = true;
   // bool isProgressBarVisible = false;


    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
     //  backgroundColor: Colors.lightBlue,
        radius: 48.0,
        child: Image.asset('asserts/logo.png'),
      ),
    );



    final familyNumber = Image(image: AssetImage('graphics/background.png'));
  //  ProgressDialog pr;

    final email = TextFormField(
      controller: family_num,
      maxLength: 6,
      keyboardType: TextInputType.text,
      autofocus: false,
    //  keyboardType: TextInputType.number,
     // initialValue: 'khasancsit@gmail.com',
      decoration: InputDecoration(
        hintText: 'Enter family number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 6,
      autofocus: false,
      obscureText: true,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );








    var showProgressBar  = Visibility(


      child: Image(
          image: AssetImage('asserts/tenor.gif'),
          width: 50,
          height: 50
      ),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: true,
    );











    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: (){


          //tatus = false;
         // showProgressBar = true;


          if(family_num.text.length == 0){


            Toast.show("Please enter your Family Number", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);



          }else{

            loginRequest();
          }
         // Navigator.of(context).pushNamed(HomePage.tag);


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
            //showProgressBar,
              if(isProgressBarVisible) showProgressBar,
            SizedBox(height: 40.0),
            poweredBy
          ],
        ),
      ),
    );
  }
}