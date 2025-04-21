// * mainapp.dart :
import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/member/info.dart';
import 'package:tj2024b_app/app/member/login.dart';
import 'package:tj2024b_app/app/member/signup.dart';

class MainApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}
class _MainAppState extends State<MainApp>{

  //1.페이지 위젯 리스트 : 여러개 위젯들을 갖는 리스트
  // Widget : 여러 위젯들을 상속하는 상위 위젯(클래스)
  List<Widget>page = [
    Text("홈 페이지"),
    Info(), // Text("게시물1 페이지"),
    Login(),// Text("게시물2 페이지),
    Signup(),//Text("내정보 페이지"),
  ];
  // 2. 페이지 상단 제목 리스트
  List<String> pageTitle = [
    '홈' ,
    '내정보' ,
    '로그인' ,
    '내정보(회원가입)'
  ];

  // 3. 현재 클린된 페이지 번호 : 상태 변수
  int selectedIndex = 0; //0 = 홈, 1: 게시물, 2: 내정보





  @override
  Widget build(BuildContext context) {
    return Scaffold( // 레이아웃
      appBar: AppBar( // 상단메뉴
        title: Row(//가로배치
          children: [
            // 로컬이미지(플러터) vs 네트워크이미지(spring서버)
            // 프로젝트 폴더 > assets(폴더생성) > images(폴더생성) > logo.jpg
            // 프로젝트 폴더 > pubspec.uaml > 'flutter:' 작성된곳에서 아래와 같이 코드 추가한다 그리고 상단 [pub get]새로고침
            Image(image: AssetImage('assets/images/logo.jpg'),// 로컬이미지 : Image(image: AssetImage("로컬이미지경로")),
            height: 100, //이미지 세로 크기
            width: 100, // 이미지 가로 크기
            ),
            SizedBox(width: 20,), // 여백
            Text(pageTitle[selectedIndex]), //현재 선택된 위젯의 제목 반환
        ]
      ),
        backgroundColor: Colors.blueAccent, //배경색
      ),
        body: page[selectedIndex], //본문 : 현제 선택된 위젯들을 보여주기*

      bottomNavigationBar: BottomNavigationBar(
        // onTap : BottomNavigationBar 에서 해당 버튼 위젯들을 클릭했을때 발생하는 이벤트 속성
          // (index) => 함수명(index) : items 에서 선택된 index 인덱스 번호가 반환된다.
        // onTap: (index) => setState(() => { 화살표함수 가능
        //   selectedIndex = index
        // }) ,

        onTap: (index) => setState(() {selectedIndex = index; }) ,
        currentIndex: selectedIndex, // 현재 선택된 버튼 번호
        type: BottomNavigationBarType.fixed, //4개이상일때 아이콘을 고정 크기 설정, 아이콘이 많아지면 자동으로 확대되기 때문
        items: [ // 여러개 버튼 위젯들
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: "로그인정보"),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: "로그인"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "내정보"),
        ],
      )
    );
  }
}