import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final formatter=DateFormat.yMd();

class Task{

Task(
{ required this.taskname,
required this.description,
 required this.date,
required this .hour,
required this.min,
required this.id,
required this.hourcheck,

}


);

 String taskname;
 String description;
 DateTime date;
 int?  hour;
 int ?min;
 int ?hourcheck;
 String id;


String get Formatteddate{
  return formatter.format(date!);
}

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      taskname: json['taskname'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      hour: json['hour'],
      min: json['min'],
      hourcheck: json['hourcheck'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskname': taskname,
      'description': description,
      'date': date!.toIso8601String(),
      'hour': hour,
      'min': min,
      'hourcheck': hourcheck,
    };
  }

        
}