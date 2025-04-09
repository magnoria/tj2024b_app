// main.dart : 앱 실행의 최초 파일

// 1. main 함수 이용한 앱 실행
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day04/todo/Home.dart';
import 'package:tj2024b_app/example/day04/todo/write.dart';

void main(){
  runApp(MyApp()); // 라우터를 갖는 위젯이 최초 화면
}

//2. 라우터를 갖는 클래스
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/", // 앱이 실행했을때 초기 경로 설정
      routes: {
        "/" : (context) => Home(), //만약에 "/" 해당 경로를 호출하면 Home 위젯이 열린다.
        "/write" : (context) => Write() ,
        // "/update" : (context) => Update(),
      },
    );
  }
}