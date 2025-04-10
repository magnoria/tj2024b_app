// main.dart : 앱 실행의 최초 파일

// 1. main 함수 이용한 앱 실행
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day04/todo/home.dart';
import 'package:tj2024b_app/example/day04/todo/detail.dart';
import 'package:tj2024b_app/example/day04/todo/update.dart';
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
        "/detail" : (context) => Detail(),
        "/update" : (context) => Update()
      },
    );
  }
}

// 안드로이드 : apk 확장자 사용 , 스토어(인증시간필요)
// IOS : ipa 확장자 사용 , 보안상 스토어 등록 필요

//방법1
//1. 현재 프로젝트명 오른쪽 클릭 -> open in -> terminal
//2. flutter build apk --release --target=lib/example/day04/todo/main.dart --target-platform=android-arm64
// * flutter build apk --release --target=lib/example/day04/todo/main.dart 생략시 자동으로 lib에 가까운 main.dart 빌드

//방법2
// 상단메뉴 -> build -> flutter -> build apk

// --> 안드로이드폰에서 apk실행시 https 적용이 안되는 경우
//android[tj2024b_app_android] -> app -> src -> main -> androidManifest.xaml
//<uses-permission android:name="android.permission.INTERNET"/>맨 마지막 사이에 집어넣어야함