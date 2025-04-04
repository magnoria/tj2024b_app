
  // Dart 언어는 단일 스레드 기반

  //1. dio 객체 생성 , new 연산자 안씀 , java : new 클래스명() vs dart : 클래스명()
  //2. 파일 상단에 import 'package:dio/dio.dart';
  import 'package:dio/dio.dart';

final dio = Dio();// final : 상수 키워드


  void main(){ // main 함수가
    print('dart start');

    getHttp(); // (3) 해당 함수 호출

   } // main end

  //3. (1) 비동기 통신
  // dio.HTTP메소드명( "URL") vs axios.HTTP메소드명("URL")
  // 테스트 :day 03에서 과제 3의 TAskCon troller 에게 통신
  void getHttp() async{
    try {
      // (1) 통신 이용한 자바와 통신
      final response = await dio.get(
          "http://localhost:8080/day03/school/course");
      //(2) 응답확인
      print(response.data);
    }catch(e){print(e);}
  }

  // 4. dio.get ("URL" , data : {body})
  void postHttp() async{
    try {
      //(1) 보내고자 하는 내용물 JSON(dart map)
      final sendData = { "cname": "수학"};
      //(2) dio 통신 이용한 자바와 통신
      final reponse = await dio.post(
          "http://localhost:8080/day03/school/course", data: sendData);
      //(3) 응답 확인
      print(reponse.data);
    }catch(e){print(e);}
  }
