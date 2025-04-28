
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day02/example2.dart';

class ProductView extends StatefulWidget{ // 부모 위젯

  // (1) 하나의 필드를 갖는 생성자.
  /*
  int pno; // - 필드
  ProductView(this.pno); //생성자
  */
  // 오버로딩 지원하지 않는다. : 러개 생성자를 가질 수 없다.

  //(2) 여러개의 필드를 갖는 생성자
  int? pno; // 타입? : null 포함한다 뜻
  String? pname;
  ProductView({this.pno , this.pname});


  @override
  State<StatefulWidget> createState() {
    print(pno);
    return _ProductViewState();
  }
}

class _ProductViewState extends State<ProductView>{ // 자식 위젯

  // 1.
  Map<String , dynamic> product = {}; // 제품 1개를 저장하는 상태 변수.
  final dio = Dio();
  final baseUrl =  "http://192.168.40.25:8080";
  // 2. 생명주기
  void initState(){
    onView();
  }
  // 3. 제품 요청
  void onView() async{
    try{               // * 직계 상위 부모 위젯의 접근 : widget.필드명 , widget.메소드명()
                                                    // widget(상위의 위젯)의 멤버변수 예) super
      final response = await dio.get("$baseUrl/product/view?pno=${widget.pno}");
      if(response.data != null){
        setState(() {
          product = response.data;
          print(product); // print 확인시 --> 웹 :F12 개발자도구 , 에뮬레이터  : 콘솔
        });
      }
    }catch(e){print(e);}
  }

  // 4. 화면 반환
  @override
  Widget build(BuildContext context) {

    //만약에 제품정보가 없으면 로딩위젯(CircularProgressIndicator())
    if(product.isEmpty){return Center(child: CircularProgressIndicator(),);}
    // 2. 이미지 추출
    final List<dynamic> images = product['images']; // null 값이라 서버문제인지 알았는데 image로 해놔서 값이 잘못갔던것
    //3. 이미지 상태에 따라 위젯 만들기
    Widget imageSection;
    if(images.isEmpty){
      imageSection = Container(
        height: 300, //높이
        alignment: Alignment.center, //가운데 정렬
    child: Image.network("$baseUrl/upload/default.jpg" , fit: BoxFit.cover,),
    ); //Container
    }else{// 이미지들이 존재하면
      imageSection = Container(
      height: 300,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,  // 목록 스크롤 방향, 기본값: 세로 , 가로 설정(Axis.horizontal)
      itemCount: images.length,
      itemBuilder: (context , index){
      String imageUrl = "$baseUrl/upload/${images[index]}"; // index번째 이미지
      return Padding(
        padding: EdgeInsets.all(5),
        child: Image.network(imageUrl , fit: BoxFit.cover,),
    );
    },
    ),
    );

    }

    return Scaffold(
      appBar: AppBar( // 뒤로가기 버튼을 지원해줌
        title: Text("제품상세정보"),
      ),
      // 3. 본문
      body: SingleChildScrollView( // 내용이 길어지면 스크롤 제공하는 위젯
        padding: EdgeInsets.all(15), //안쪽여백
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //왼쪽정렬
          children: [
            /* 이미지 위젯*/
            imageSection,
            /* 이미지 위젯*/
            SizedBox(height: 25,),
            Text(product['pname'] , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 18,),
            Text("${product['pprice']}원" , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold , color: Colors.red),),
            SizedBox(height: 10,),
            Divider(), // 구분선
            SizedBox(height: 10,),
            Row(//가로배치
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //양쪽 끝에 배치
              children: [
                Text("카테고리 : ${product['cname']}"),
                Text("조회수 : ${product['pview']}"),
              ],
            ),
            SizedBox(height: 10,),
            Text("작성자 : ${product['memail']}"),
            SizedBox(height: 10,),
            Text("제품설명" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            Text(product['pcontent']),
          ],
        ),

      ),
    );
  }
}