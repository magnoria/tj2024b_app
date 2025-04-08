/*
// 상태(state/데이터변화)가 없는 위젯 : StateLessWidget
      1. 한번 출련된 화면은 불변(고정)이다. 재렌더링이 안된다. 정적 UI
      2. 관리 클래스가 별도로 없다.
        -> 한번 그려낸 화면은 고정이다.
      3. 사용법
          class 새로운 위젯명 extends StatelessWidget{

            @Overrid
            Widget Build(BuildContext context) {
              return 위젯명();
            }
          }


// 상태(state/데이터변화)가 있는 위젯 : StateFulWidget , 재 렌더링 (새로고침) , 동적 UI
      1. 한번 출력된 화면은 불변(고정) 이다. 다만, setState() 이용하여 재렌더링이 가능하다.
      2. 반드시 상태를 관리하는 별도의 클래스가 필요하다. ** : 상태저장소
        -> 한번 그려낸 화면을 상태변화에 따라 다시 그려낼 수 있다.
      3. 사용법 예시)
        class 상태관리위젯명 extends StateFulWidget{
          상태를사용할위젯명1 createState() => 상태를 사용할위젯명1();
          상태를사용할위젯명2 createState() => 상태를 사용할위젯명2();
          상태를사용할위젯명3 createState() => 상태를 사용할위젯명3();
        }
        class 상태를사용할위젯명1 extends State<상태관리위젯명>{
            @Overrid
            Widget Build(BuildContext context) {
              return 위젯명();
            }
        }

          class 상태를사용할위젯명2 extends State<상태관리위젯명>{
            @Overrid
            Widget Build(BuildContext context) {
              return 위젯명();
            }
        }

       4. 대표적인 주요 함수
        initState() : 위젯이 처음에 생성될때 실행되는 초기화 함수 [ 위젯탄생 ]
        setState() : 상태를 변경하고 화면을 다시 렌더링(build) 하는 함수. [ 위젯 업데이트 ]
        dispose() : 위젯이 제거될때 실행되는 함수                [ 위젯 사망 ]


*/
import 'package:flutter/material.dart';

void main(){
  // 3. 상태를 관리하는 위젯 실행
  runApp(MyApp1());
}
// 1. 상태를 관리하는 클래스 선언 , StatefulWidget 클래스를 상속받아서 상태관리 클래스를 만든다.
class MyApp1 extends StatefulWidget{
  // * 상태사용할 위젯과 연결 , createState()
  MyApp1Sate createState() => MyApp1Sate();
}
// 2. 상태를 사용하는 클래스(위젯) , State 클래스로부터 상속받아서 설정한 상태를 사용
class MyApp1Sate extends State<MyApp1>{
  int count = 0; // 값변수
  void increament(){ //값증가 함수
    //count++; print(count);
    // 상태 변화에 따른 재 랜더링 ,setState(() {});
    setState(() {
      count++;
    });
  }
  // 상태위젯이 최초로 실행될떄 딱 1번 실행되는 함수 , initState
  @override
  void initState(){
    print("상태위젯이 최초 1번 실행하는 함수입니다.");
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("상단바"),),
        body: Center(
          child: Column(
            children: [
              Text("count : $count"),
              TextButton(onPressed: increament, child: Text("클리하면count증가"))
            ],
          ),
        ),
      ),
    );
  }
}