import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String url;
  String flag;
  bool isDaytime;

  WorldTime(
      {required this.location, required this.flag, required this.url, this.time = '',this.isDaytime=true});

  Future<void> getTime() async {
    try {
      http.Response response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);
      String? datetime = data['datetime'] as String?;
      String? offset = data['utc_offset'].substring(1, 3) as String?;
      //print(datetime);
      print(offset);
      if (datetime != null && offset != null) {
        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset)));
        isDaytime= now.hour>6 && now.hour<20? true:false;
        time = DateFormat.jm().format(now);
      }
      else {
        print('Error:datetime is null');
      }
    }
    catch(e){
      print('catch the error:$e');
      time='could not get time date';
    }
    }
  }

