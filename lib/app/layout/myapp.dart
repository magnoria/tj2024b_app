
//* myapp.dart : 앱 전체 구성 파일
import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';

class MyApp extends StatelessWidget{ // 상태 없는 위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //위젯명(key : value , key : value);
      // key : 위젯 마다의 정해진 key 존재
      // value : 다양한 하위 위젯들이 들어간다.
      title: "앱", // 앱 탭 이름
      home: MainApp(), // 앱 본문
      theme: ThemeData( //앱 테마
        scaffoldBackgroundColor: Colors.white //scaffold 위젯의 색상 구성
      ),
    );
  }
}