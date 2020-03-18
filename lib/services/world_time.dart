import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // location name for the UI
  String time;  // time in that location
  String flag;  // url to an asset of the flag icon
  String url; // location url for api endpoint
  bool isDaytime; // true if day time, else false

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try{
      // make request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offsetH = data['utc_offset'].substring(0, 3);
      String offsetM = data['utc_offset'].substring(4, 6);
      // print(datetime);
      // print(offsetH);
      // print(offsetM);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetH)));
      now = now.add(Duration(minutes: int.parse(offsetM)));
      // print(now);

      // set time property
      // time = now.toString();
      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Caught error $e');
      time = 'Could not get time data';
    }

  }

}