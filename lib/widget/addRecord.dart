import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart';


int _selectedIndex = 0;

class AddRecord extends StatelessWidget {


  bool isProgressBarVisible = false;

  static String tag = 'add-record';
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  var address = TextEditingController();
  var family_head = TextEditingController();
 // var ration_distribution_date = TextEditingController();
  var cnic_number = TextEditingController();


  var setRationDistributionDate = TextEditingController();


  @override
  Widget build(BuildContext context) {



    void retrieveValue() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      cnic_number.text = prefs.get('cnic').toString();


    }



   retrieveValue();





    final alucard = Hero(
      tag: 'hero',
      child: CircleAvatar(
        radius: 40.0,
        backgroundColor: Colors.blueGrey,
        backgroundImage: AssetImage('asserts/kamrul.png'),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28.0,color: Colors.white),
      ),
    );



    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Kamrul Hasan is passanante about software development in web and mobile. He already developed many software for local and frelence client. He continue learning new technologies. This time start about dart language and flutter framework for andorid and ios (cross platform) application. If you have any idea feel free to contact with him via mail. Mail Address: khasancsit@gmail.com',
        style: TextStyle(fontSize: 16.0,color: Colors.white),
      ),
    );




    final cnicNumber = Text(
      'CNIC Number',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    );


    final  cnicNumberUrdu = Padding(
        padding: EdgeInsets.only(
          left:180,
        ),
        child:  Image(
            image: AssetImage('asserts/cnic_num.png'),
            // width: 10,
            height:18
        )
    );




    final cnicNumberTextBox = new TextField(
      controller: cnic_number,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
        hintText: ("J3424F "),
        prefixIcon: Icon(Icons.person),

      ),

      // validator: validateDob,

    );





    final familyHeadName = Text(
      'Name of family Head',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    );


    /*  final familyHeadNameUrdu = Hero(
      tag: 'hero',
      child: Image.asset('asserts/logo.png'),
    );

    */






    final  familyHeadNameUrdu = Padding(
        padding: EdgeInsets.only(
          left:180,
        ),
        child:  Image(
            image: AssetImage('asserts/familyheadname.png'),
            // width: 10,
            height:18
        )
    );




    final familyHeadNameTextBox = new TextField(
      controller: family_head,
      decoration: new InputDecoration(
        hintText: ("Dildar Khan "),
        prefixIcon: Icon(Icons.person),

      ),

      // validator: validateDob,

    );





    final  lastDistributionDate = Padding(
        padding: EdgeInsets.only(
          left:180,
        ),
        child:  Image(
            image: AssetImage('asserts/distributiondate.png'),
            // width: 10,
            height:26
        )
    );






    final rationDistributedDateTxt = Text(
      'Last Ration Distribution Date',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),


    );





    DateTime  _dateTime;

    _selectDate(){
      var _dateTimeNotifier;
      Future<DateTime> selectedDate = showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light(),
            child: child,

          );
        },
      ).then((date){

       // DateTime.now().day.toString()+'-'+DateTime.now().month.toString()+'-' +DateTime.now().year.toString(),

        setRationDistributionDate.text = date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString();

      });
    }





    void setDateTextField (){

    }


    final rationDistributedDate = InkWell(
      onTap: () {
        _selectDate();   // Call Function that has showDatePicker()

      },
      child: IgnorePointer(
        child: new TextField(
          enabled: true,
          controller:  setRationDistributionDate,

          decoration: new InputDecoration(
            hintText: 'YYYY-MM-DD',
            prefixIcon: Icon(Icons.calendar_today),

          ),

          // validator: validateDob,

        ),
      ),
    );


  //  rationDistributionDate.text = DateTime.now().day.toString()+'-'+DateTime.now().month.toString()+'-' +DateTime.now().year.toString();


    final dna = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Date not available.Please make entry using the following link',
        style: TextStyle(fontSize: 16.0,color: Colors.white),
      ),
    );





    final addressTxt = Text(
      'Enter Address',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    );








    final  addressTxtUrdu = Padding(
        padding: EdgeInsets.only(
          left:240,
        ),
        child:  Image(
            image: AssetImage('asserts/houseaddress.png'),
            // width: 10,
            height:18
        )
    );


    final addressTxtBox = new TextField(
      controller: address,

      decoration: new InputDecoration(
        hintText: ('Landhi no. 3'),
        prefixIcon: Icon(Icons.home),

      ),

      // validator: validateDob,

    );





    void saveInfoRequest () async {


      Toast.show("Please wait...", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);




      final uri = 'https://amiraslam.000webhostapp.com/ration_tracker/insert_family_record.php';
      final headers = {'Content-Type': 'application/json'};

      Map<String, dynamic> body = {
        "address": address.text,
        "cnic": cnic_number.text.toString(),
        "family_head": family_head.text,
        "ration_distribution_date": setRationDistributionDate.text.toString(),
        "operation": "insert"

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
     // print(response.body);
      //  Map record = json.decode(response.body);

      if(statusCode == 200){


        Map record = json.decode(response.body);

        if(record['status'].toString() == "success"){
          print(record['message'].toString());

          Toast.show("record saved successfully", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);




          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.pop(context);

          });





        }else{
          Toast.show("Error! Please try later", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);


          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.pop(context);

          });

        }


        print(response.body);

      }else{}

    }



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










    final saveInfoBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: (){


         if(family_head.text.length == 0 || address.text.length == 0 ){
           Toast.show("Please fill all the fields inorder to procreed", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

         }else{
           saveInfoRequest();
         }


          //Navigator.of(context).pushNamed(HomePage.tag);
          // launchWebView();

        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Save',style: TextStyle(color: Colors.white),),
      ),
    );












    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white
        ]),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[

          SizedBox(height: 30.0),
          cnicNumber,
          cnicNumberUrdu,
          cnicNumberTextBox,
          SizedBox(height: 40.0),
          familyHeadName,
          familyHeadNameUrdu,
          familyHeadNameTextBox,
          SizedBox(height: 40.0),
          addressTxt,
          addressTxtUrdu,
          addressTxtBox,
          SizedBox(height: 40.0),
          rationDistributedDateTxt,
          lastDistributionDate,
          rationDistributedDate,
          SizedBox(height: 20.0),

          if(isProgressBarVisible) showProgressBar,
          SizedBox(height: 40.0),

          saveInfoBtn
        ],
      ),
    );



    return Scaffold(
      appBar: AppBar(
        title: const Text('Ration Details'),
      ),
      body: body,

    );


  }











}