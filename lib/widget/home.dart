import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _selectedIndex = 0;

class HomePage extends StatelessWidget {
 static String tag = 'home-page';
static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
String address;



 Future<String> setUserid() async {
   SharedPreferences pref = await SharedPreferences.getInstance();
   pref.getString("address");

   address = pref.getString('FB_USER');

 }











 @override
  Widget build(BuildContext context) {



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




    final familyHeadNameTextBox = InkWell(

      child: IgnorePointer(
        child: new TextField(




          decoration: new InputDecoration(
            hintText: ("Address"),
            prefixIcon: Icon(Icons.person),

          ),
          maxLength: 10,
          // validator: validateDob,

        ),
      ),
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





  var setRationDistributionDate = TextEditingController();
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
              prefixIcon: Icon(Icons.calendar_today),

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


    final addressTxtBox = InkWell(

      child: IgnorePointer(
        child: new TextField(


          controller:  setRationDistributionDate,

          decoration: new InputDecoration(
            hintText: ("Address"),
            prefixIcon: Icon(Icons.home),

          ),
          maxLength: 10,
          // validator: validateDob,

        ),
      ),
    );




    final saveInfoBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: (){

          Navigator.of(context).pushNamed(HomePage.tag);
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