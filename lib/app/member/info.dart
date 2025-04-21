
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/example/day02/example2.dart';

class Info extends StatefulWidget{
  @override
  _InfoState createState() {
    return _InfoState();
  }
}
class _InfoState extends State<Info>{
  // 1. 상태 변수
  int mno = 0;
  String memail = "";
  String mname = "";
  // 2. 해당 페이지(위젯) 열렸을때 실행되는 함수
  @override
  void initState() {
    loginCheck();
  }
  // 3. 로그인 상태를 확인 하는 함수
  bool? isLoggin; // Dart문법 중에 타입? 은 null 포함할수 있다라는 뜻
  void loginCheck() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if(token != null && token.isNotEmpty){ //전역변수에 (로그인)토큰이 존재하면
      setState(() {
        isLoggin= true; print("로그인 중");
        onInfo(token); // 로그인 중일때 로그인 정보 요청 함수 실행
      });
    }else{
      setState(() {
        isLoggin = false; print("비로그인 중");
      });
    }
  }

  //4. 로그인된(회원) 정보 요청 , 로그인 중일때 실행
  void onInfo(token) async{
    try{
      Dio dio = Dio();
      //* Dio 에서 header 정보를 보내는 방법 , options
      //방법1 : dio.options.headers['속성명'] = 값;
      // 방법2 : dio.get(options : {headers : {'속성명' : 값 }})
      dio.options.headers['Authorization'] = token;
      final response = await dio.get("http://localhost:8080/member/info");
      final data = response.data; print(data);
      if(data != ''){ // (로그인) 회원정보가 존재하면
        setState(() {
          memail = data['memail'];
          mname = data['mname'];
          mno = data['mno'];
        });

      }

    }catch(e){print(e);}
  }


  //5. 로그아웃 요청
  void logout() async{
    try{
      //1. 토큰을 꺼낸다.
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if(token == null )return; // 없으면 함수 종료
      //2 서버에게 로그아웃요청
      Dio dio = Dio();
      dio.options.headers['Authorization'] = token;
      dio.get("http://localhost:8080/member/logout");
      // 3. 전역변수(클라이언트) 에도 토큰 삭제
      await prefs.remove('token');
    }catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원번호 : $mno "),
            SizedBox(height: 20,),
            Text("아이디(이메일) : $memail "),
            SizedBox(height: 20,),
            Text("이름(닉네임) : $mname"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: logout, child: Text("로그아웃"))
          ],
        ),
      ),
    );
  }
}