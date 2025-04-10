// detail.dart : 상세 화면 파일

// 상태 있는 위젯


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  @override
  _DetailState createState() {
    return _DetailState();
  }
}


class _DetailState extends State<Detail>{
  // * 1. 이전 화면에서 arguments 값을 가져오기
  // 전제조건 : Navigator.pushNamed(context, "/detail" , arguments: todo['id'])
  // ModalRoute.of( context)!.settings.arguments as 인자값타입

  // (1). void initState() { }//해당 위젯이 최초로 딱 1번 실행하는 함수(생명주기)  , context 위젯트리를 제공 받을 수 없다.
  // (2). didChangDependencies() 이전 위젯이 변경 되었을때 실행 되는 함수(위젯 생명주기) , cpmtext 위젯트리를 사용할 수 있다.

  // *1. 이전 위젯으로 부터 매개변수로 받은 id 를 가져오기
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    int id = ModalRoute.of( context)!.settings.arguments as int;
    todoFindById(id); // 가져온 id를 서버에게 보내서 정보를 요청하기
  }


  // *2. 자바와 통신하여 id에 해당하는 상세 정보 요청
  Dio dio = Dio();
  Map<String , dynamic> todo = {}; // 응답결과를 저장하는 하나의 '일정' 객체 선언
  void todoFindById(id) async{
    try{
      final response = await dio.get("https://legal-lexy-bettercomputeracademy-c3db22da.koyeb.app/day04/todos/view?id=$id");
      final data = response.data;
      setState(() { //응답받은 결과를 상태변수에 대입
        todo = data; //응답받은 결과를 상태 변수에 대입
      });
      print(todo);
    }catch(e){print(e);}
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("상세화면"),),
      body: Center(
        child: Column(
          children: [
            Text("제목 : ${todo['title']}" ,style: TextStyle(fontSize: 18),),
            SizedBox(height: 8,), //여백

            Text("내용 : ${todo['content']}" ,style: TextStyle(fontSize: 18),),
            SizedBox(height: 8,), //여백

            Text("완료여부 : ${todo['done'] == 'true' ? '완료' : '미완료'}" ,style: TextStyle(fontSize: 18),),
            SizedBox(height: 8,), //여백

            Text("할일 등록일 : ${todo['createAt']}" ,style: TextStyle(fontSize: 18),),
            SizedBox(height: 8,), //여백
          ],
        ),
      ),
    );
  }
}