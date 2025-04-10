
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day04/equip/equipHome.dart';
import 'package:tj2024b_app/example/day04/equip/equipWrite.dart';
import 'package:tj2024b_app/example/day04/equip/update.dart';

void main(){
  runApp(PlayApp());
}

class PlayApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/" :  (context) => EquipHome(),
        "/write" : (context) => EquipWrite(),
        "/update" : (context) => EquipUpdate(),

      },
    );
  }
}