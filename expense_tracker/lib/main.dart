import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kcolorscheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 12, 168, 33));

var kdarkcolorscheme=
    ColorScheme.fromSeed(brightness: Brightness.dark
    ,seedColor: Color.fromARGB(255, 14, 10, 127)); 

void main() {
// // WidgetsFlutterBinding.ensureInitialized();
// // SystemChrome.setPreferredOrientations([
// //   DeviceOrientation.portraitUp
// ]).then((fn){

runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkcolorscheme,
         cardTheme: CardTheme().copyWith(
          color: kdarkcolorscheme.secondary,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        ),
         elevatedButtonTheme:ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kdarkcolorscheme.primaryContainer,
            foregroundColor: kdarkcolorscheme.onPrimaryContainer
          )
        ),
        
        
      textTheme: ThemeData().textTheme.copyWith(
       titleLarge: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 17,
        color: Color.fromARGB(255, 114, 1, 1)
       )

      )
      

      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorscheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.onPrimaryContainer,
            foregroundColor: kcolorscheme.primaryContainer),
        cardTheme: CardTheme().copyWith(
          color: kcolorscheme.secondary,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        ),
        elevatedButtonTheme:ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorscheme.primaryContainer
          )
        ),

      textTheme: ThemeData().textTheme.copyWith(
       titleLarge: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 17,
        color: Color.fromARGB(255, 231, 245, 36)
       )

      )

      ),
      home: Expenses(),
    ),
  );




// });

  
}
