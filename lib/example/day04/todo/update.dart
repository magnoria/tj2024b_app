// update.dart : 수정 화면 파일

//상태 있는 위젯
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class Update extends StatefulWidget{
  @override
  _UpdateState createState() {// 변경안해도 되지만 _UpdateState로 변경하기는 함 
    return _UpdateState();
  }
}

class _UpdateState extends State<Update> {// 클래스명 앞에 _언더바는 dart에서 private 를 뜻함

  // 1. 이전 위젯으로 부터 전달받은 인수(arguments)를 가져오기.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //(1)
    int id = ModalRoute.of(context)!.settings.arguments as int;
    print(id);
    // (2) 전달받은 인수 (id)를 자바에게 보내고 응답객체 받기
    todoFindById(id);// 함수 호출
  }
  // 2.
  Dio dio = Dio();
  Map<String, dynamic> todo = {}; // JSON 타입은 key은 무조건 문자열 그래서 String, value은 다양한 자료 타입 이므로 dynamic(동적타입)
  void todoFindById(id) async {
    try{
      final response = await dio.get("https://legal-lexy-bettercomputeracademy-c3db22da.koyeb.app/day04/todos/view?id=$id");
      final data = response.data;
      setState(() {
        todo = data;
        // 입력 컨트롤러에 초기값 대입하기
        titleController.text = data['title'];
        contentController.text = data['content'];
        done = data['done'];
      });
      print(todo);
    }catch(e){print(e);}
  }
  // 3. 입력컨트롤러 상태 변수
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  // 완료 여부를 저장하는 상태변수 , 컨트롤러 없이 직접 렌더링
  bool done = true;

  // 4. 현재 수정된 값으로 자바에게 수정처리 요청하기.
  void todoUpdate() async{
    try{
      final sendData ={
        "id" : todo['id'], // 기존의 id를 가져온다.
        "title" : titleController.text, // 수정된 입력받은 값을 가져온다.
        "content" : contentController.text,
        "done" : done // 수정된 할일 상태
      }; //수정에 필요한 데이터
      final response = await dio.put("https://legal-lexy-bettercomputeracademy-c3db22da.koyeb.app/day04/todos", data: sendData );
      final data = response.data;
      if(data != null){//만약에 응답결과가 null이 아니면 수정 성공
        //Navigator.pop(context); 뒤로가기
        Navigator.pushNamed(context, "/"); //home으로 가기
      }
    }catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("수정화면"),),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextField(controller: titleController,decoration: InputDecoration(labelText: "제목"),
              maxLength: 30,
              ),


              SizedBox(height: 20,),
              Text("내용"),
              TextField(controller: contentController,),

              SizedBox(height: 20,),
              Text("완료 여부"),
              Switch(// 스위치 위젯, om/off 역할
                  value: done, // 현재 스위치값 , true 또는 false
                  onChanged: (value){ // 스위치값이 변경 되었을때
                setState(() {done = value;});
                //onChanged: (변경된값){setState(() {상태변수 = 변경된값;});
              }),
              OutlinedButton(onPressed: todoUpdate, child: Text("수정하기"))
            ],
          ),
      ),
    );
  }
}