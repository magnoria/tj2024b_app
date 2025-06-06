// signup.dart : 회원가입 페이지

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tj2024b_app/app/member/login.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  
 

  // * 입력 컨트롤러 , 각입력창에서 입력받은 값을 제어(반환, 호출 등등)
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // * 등록 버튼 클릭시
  void onSignup() async {
    // 1. 자바에게 보낼 데이터 준비
    final sendData = {
      'memail' : emailController.text, //입력 컨트롤러에 입력된 값 가져오기
      'mpwd' : pwdController.text,
      "mname" : nameController.text,
    };
    print(sendData); //확인

    // * Rest API 통신 간의 로딩 화면 표시 , showDialog() : 팝업 창 띄우기 위한 위젯
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator() ,),
      barrierDismissible: false, // 팝업창(로딩화면)외 바깥 클릭 차단
    );



    //2.
    try {
      Dio dio = Dio();
      final reponse = await dio.post(
          "http://192.168.40.25:8080/member/signup", data: sendData);
      final data = reponse.data;

      Navigator.pop(context); // 가장 앞(가장 최근에 열린)에 있는 위젯 닫기 (showDialog() : 팝업창)

      if (data) {
        print("회원가입 성공");

        Fluttertoast.showToast(msg: "회원가입 성공하셨습니다.", // 출력할내용
          toastLength: Toast.LENGTH_LONG , // 메시지 유지 시간
          gravity: ToastGravity.BOTTOM, // 메시지 위치 : 앱 적용
          timeInSecForIosWeb: 3, //자세한 유지시간(sec)
          backgroundColor: Colors.teal, // 배경색
          textColor: Colors.deepPurpleAccent, // 글자색상
          fontSize: 16, // 글자크기
        );

        // * 페이지 전환
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      }
      else {
        print("회원가입 실패");
      }
    }catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //Container( padding : margin :); 안쪽/바깥여백 위젯
        padding: EdgeInsets.all(50),
        // EdgeInsets.all() : 상하좌우 모두 적용되는 안쪽 여백
        margin: EdgeInsets.all(50),
        //EdgeInsets.all() : 상하좌우 모두 적용되는 바깥 여백
        child: Column(
          // 세로 배치
          children: [
            // 하위 위젯
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "이메일",
                border: OutlineInputBorder(),
              ),
            ), // 입력 위젯 , 이메일(id)
            SizedBox(height: 20),

            TextField(
              controller: pwdController,
              obscureText: true, // 입력한 텍스트 가리기 가능
              decoration: InputDecoration(
                labelText: "비밀번호",
                border: OutlineInputBorder(),
              ),
            ), // 입력 위젯 , 패스워드

            SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "닉네임",
                border: OutlineInputBorder(),
              ),
            ), // 입력 위젯 , 닉네임

            SizedBox(height: 20),

            ElevatedButton(onPressed: onSignup, child: Text("회원가입")),
            TextButton(
              onPressed: () => {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()))},
              child: Text("이미 가입된 사용자 이면 _로그인 하기"),
            ),
          ],
        ),
      ),
    );
  }
}
