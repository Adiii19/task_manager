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
required this.id,
required this.hourcheck,

}


);

 String taskname;
 String description;
 DateTime? date;
 int?  hour;
 int ?min;
 int ?hourcheck;
 String id;


String get Formatteddate{
  return formatter.format(date!);
}


        
}