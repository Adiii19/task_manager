import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final formatter=DateFormat.yMd();

class Task{

Task(
{ required this.taskname,
required this.description,
 this.date,
required this .hour,
required this.min,

required this.hourcheck,

}


);

 String taskname;
 String description;
 DateTime? date;
 int  hour;
 int min;
 int hourcheck;


String get Formatteddate{
  return formatter.format(date!);
}

Task.fromJson(Map<String, dynamic> json)
      : taskname = json['taskname'] ?? '',
        description = json['description'] ?? '',
        date = json['date'] == null ? null : DateTime.parse(json['date']),
        hour = json['hour'] ?? 0,
        min = json['min'] ?? 0,
     
        hourcheck = json['hourcheck'] ?? false;
}