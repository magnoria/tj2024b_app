// ! 위젯명 : 화면을 그려내는 최소 단위
// 위젯명( 속성명 : 위젯명, 속성명 : 위젯명 );         == 객체
// vs new 클래스명( 매개변수, 매개변수, 매개변수 );        == 객체

//1. 플러터 시작 , 시작점 에서 runApp()에서 최초로 실행할 위젯의 객체 대입
import 'package:flutter/material.dart';

void main(){
  //runApp( 최초실행할 위젯);
  runApp(
      MaterialApp(
        initialRoute: "/" , // 최초로 실행 했을때 열리는 경로 , http://localhost:54565/
        //routes: {"경로정의" : (context) => 위젯명() , "경로정의" : 위젯 }
         routes: {
            "/" : (context) => Home(), //http://localhost:54565/
           "/page1" : (context) => Page1(),//http://localhost:54565/#/page1
           //"/page2" : (context) => Page2()
        }
  )); // 다트는 new라는 연산자를 쓰지않는다.
}// main end

//2. 앱 화면 만들기 2가지 선택사항 : 1. 상태가없는 StatelessWidget 2. 상태가있는 StatefulWidget
class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인페이지"),),
      body: Center(
        child: Column(
          children: [
            Text("메인페이지 본문"),
            TextButton(
                onPressed: ()=>{Navigator.pushNamed(context, "/page1")},
                child: Text("page1로 이동 버튼"))
          ],
        ),
      ),
      
    );
  }
}// class end


// 2-2/앱화면 만들기 2가지 선택사항 : 1. 상태가없는 StatelessWidget 2. 상태가있는 StatefulWidget
class Page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("page1 헤더"),),
      body: Center( child: Text("page1 본문"),),
    );
  }
}


