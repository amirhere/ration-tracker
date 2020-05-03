import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart';


int _selectedIndex = 0;

class HomePage extends StatelessWidget {
  static String tag = 'home-page';
static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);



 @override
  Widget build(BuildContext context) {

  // String family_head;
  // String cnic;

   var address = TextEditingController();
   var family_head = TextEditingController();
   var ration_distribution_date = TextEditingController();

   var setRationDistributionDate;

   String _cnic;
   String _address;
   String _family_head;
   String _ration_distribution_date;


   void loginRequest () async {

     SharedPreferences prefs = await SharedPreferences.getInstance();


     address.text = prefs.getString('address').toString();
     family_head.text = prefs.getString('family_head').toString();
     setRationDistributionDate.text = prefs.getString('ration_distribution_date').toString();



     _cnic = prefs.getString('cnic').toString();
     _address = prefs.getString('address').toString();
     _family_head = prefs.getString('family_head').toString();
     _ration_distribution_date = prefs.getString('ration_distribution_date').toString();




    }


   loginRequest();




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




    /*
    final familyHeadNameUrdu = Text(
      'Name of family member',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    );

*/

    final rationDistributedDateTxt = Text(
      'Last Ration Distribution Date',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),


    );





  setRationDistributionDate = TextEditingController();
  DateTime  _dateTime;

  _selectDate(){
    var _dateTimeNotifier;
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,

        );
      },
    ).then((date){

      setRationDistributionDate.text = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();

    });
  }



    final rationDistributedDate = InkWell(
      onTap: () {
        _selectDate();   // Call Function that has showDatePicker()

      },
      child: IgnorePointer(
        child: new TextField(


          controller:  setRationDistributionDate,

          decoration: new InputDecoration(
              hintText: 'No chance',
             // prefixIcon: Icon(Icons.calendar_today),

          ),
          maxLength: 10,
          // validator: validateDob,

        ),
      ),
    );



    final dna = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Date not available.Please make entry using the following link',
        style: TextStyle(fontSize: 16.0,color: Colors.white),
      ),
    );




    final addressTxt = Text(
      'House Address',
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


     final uri = 'http://346587b4.ngrok.io/insert_family_record.php';
     final headers = {'Content-Type': 'application/json'};
     Map<String, dynamic> body = {
       "address": address.text,
       "cnic": _cnic,
       "family_head": family_head.text,
       "ration_distribution_date": ration_distribution_date.text

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
    //  Map record = json.decode(response.body);

     if(statusCode == 200){

       print(response.body);

     }else{}

   }









   final saveInfoBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: (){
          saveInfoRequest();
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