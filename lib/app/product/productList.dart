
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/member/signup.dart';
import 'package:tj2024b_app/app/product/productView.dart';
import 'package:tj2024b_app/example/day04/example1.dart';

class ProductList extends StatefulWidget{
    @override
  _ProductListState createState() {
    return  _ProductListState();
  }
}

class _ProductListState extends State<ProductList>{
  // 1.
  int cno = 0; // 카테고리 번호 갖는 상태 변수 , 초기값 0
  int page = 1; // 현재 조회 중인 페이지 번호를 갖는 상태변수, 초기값 1
  List<dynamic> productList = []; // 자바 서버로 부터 조회한 제품(DTO) 목록 상태
  final Dio dio = Dio(); // 자바서버 와 통신 객체
  String baseUrl = "http://192.168.40.25:8080"; // 기본 자바서버의 URL 정의 // 환경에 따라 IP변경
  // * 현재 스크롤의 상태(위치/크기 등)를 감지하는 컴트롤러
  // *무한스크롤(스크롤이 거의 바닥에 위치했을때 새로운 자료 요청 해서 추가한다.)
  // .position : 현재 스크롤의 위치 반환 , .position.pixels : 위치를 픽셀로 반환
  // .position.maxScrollExtent : 현재 화면의 스크롤 최대 크기
  final ScrollController scrollController = ScrollController();

  // 2. 현재 위젯 생명주기 : 위젯이 처음으로 열렸을때  1번 실행
  @override // (1) 자바서버에게 자료 요청 (2) 스크롤의 리스너(이벤트) 추가.
  void initState() {
    onProductAll(page); // 현재 페이지 전달
    scrollController.addListener(onScroll); //.addListener : 스크롤의 이벤트(함수) 리스너 추가
  }

  // 3. 자바서버에게 자료 요청
  void onProductAll( int currentPage) async{
    try{
      final response = await dio.get("${baseUrl}/product/all?page=${currentPage}"); // 현재페이지(page) 매개변수로 보낸다.
      setState(() {
        page = currentPage; // 증가된 현재 페이지지를 상태변수에 반영
        if(page == 1){//만약에 첫페이지 이면
          productList = response.data['content'];
        }else if(page >= response.data['totalPages']){ // 만약에 현재페이지수가 전체 페이지수 보다 이상이면
          page = response.data['totalPages']; // 현재페이지수를 전체페이지수로 변경
        }else { // 다음 페이지수가 존재하면 추가 .addAll()
          productList.addAll(response.data['content']);
        }
        print(productList);
        print(response.data);
      });
    }catch(e){print(e);}
  }

  // 4. 스크롤의 리스너(이벤트) 추가 메소드
  void onScroll(){
    // - 만약에 현재 스크롤의 위치가 거의( 적당하게 100 ~ 200 사이) 끝에 도달 했을때
    if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 150){
      onProductAll(page + 1); // 스크롤이 거의 바닥에 도달했을때 page 를 1 증가하여 다음 페이지 자료를 요청한다.
    }
  }

  // 5. 위젯이 반환하는 화면들
  @override
  Widget build(BuildContext context) {
    if(productList.isEmpty){// 만약에 제품목록이 비어 있으면
      return Center(child: Text("조회된 제품이 없습니다."),);
    }
    // 제품목록이 있으면
      // - ListView.builder : 여러개 아이템/항목/위젯 들을 리스트형식으로 출력하는 위젯
    return ListView.builder(
        controller: scrollController , // <--- ListView 에 스크롤 컨트롤러 연결
        itemCount: productList.length ,  // 목록의 항목 개수 <---> 제품목록의 개수 , page 1일때 5, page 2일때 10
        itemBuilder: (context , index){ // 목록의 항목 개수 만큼 반복문
          // (1) 각 index번째  하나의 제품 꺼내기
          final product = productList[index];
          // (2) 이미지 리스트 추출
          final List<dynamic> images = product['images'];
          // (3) 만약에 이미지가 존재하면 대표이미지(1개) 추출 없으면 기본 이미지 추출
          String? imageUrl;
          if(images.isEmpty){ // 리스트(이미지들)가 비어있으면
            imageUrl = "${baseUrl}/upload/default.jpg";
          }else{ // 비어있지 않으면 첫번째 이미지만 추출
            imageUrl = "${baseUrl}/upload/${images[0]}";
          }
          // (4) 위젯
          return InkWell( // 해당하는 위젯의 하우위젯을 클릭(탭) 하면 상세페이지로 이동 구현
            onTap: ()=>{ //만약에 하위 위젯(Card)을 클릭했을때 이벤트 발생
              Navigator.push(context,    // 위젯명( 인수 1, 인수2);
                  MaterialPageRoute(builder: (context)=> ProductView( pno: product['pno'],))
              )
            },
            child: Card(
              margin: EdgeInsets.all(15), // 바깥여백
              child : Padding(
                padding: EdgeInsets.all(10),//안쪽여백
              child: Row( // 가로배치 , div.flex{div.flex}
                children: [ // 가로 배치할 위젯들

                  Container( // 하위요소를 담을 박스(div)
                    width: 100, height: 100, //가로세로 사이즈
                    child: Image.network(imageUrl , // 이미지 경로
                    fit: BoxFit.cover, // 만약에 이미지가 구역보다 크면 비율유지
                    ),), // 웹 이미지 출력 (이미지 위젯)

                  SizedBox(width: 20,), //여백

                  Expanded(child: Column( // 그외 구역
                    crossAxisAlignment: CrossAxisAlignment.start, //왼쪽 정렬
                    children: [
                      Text(product['pname'], style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),), // 여기는 문자화 안해도 타입 에러가 안뜨는데
                      SizedBox( height: 8,),
                      Text("가격: ${product['pprice']}" , style: TextStyle(fontSize: 16 , color: Colors.red),), // 여기는 문자화를 해야 에러가 뜸 String으로 되어야하는데 int값을 넣어서 에러 뜸
                      SizedBox( height: 4,),
                      Text("카테고리: ${product['cname']}"),
                      SizedBox( height: 4,),
                      Text("조회수: ${product['pview']}"),

                    ],
                  ))
                ],
              ),
              ),
            ),
          );
    });

  }
}