
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';
import 'package:tj2024b_app/app/product/productList.dart';
import 'package:tj2024b_app/app/product/productView.dart';
import 'package:tj2024b_app/example/day02/example2.dart';

class ProductRegister extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return  _ProductRegister();
  }
}



class _ProductRegister extends State<ProductRegister>{

  // 1.
  final TextEditingController pnameController= TextEditingController(); // 제품명
  final TextEditingController pcontentController = TextEditingController(); // 제품설명
  final TextEditingController ppriceController = TextEditingController(); // 제품가격
  int? cno = 1; // 카테고리 번호 // 드롭다운
  final Dio dio = Dio();
  final baseUrl = "http://192.168.40.25:8080"; // 환경에 따라 변경
  List<dynamic> categoryList = []; // 카테고리 목록 [{ cno : 1, cname :" 전자~"} , {cno :2 ~~~}]

  @override // 위젯이 로드될때 딱 1번실행 함수
  void initState() {
    onCategory();
  }

  // 4. 이미지 피커 // 사용자의 파일을 플러터로 가져오기
    // 1. pubspec.yamal 파일의 dependencies 추가 : image_picker: ^1.1.2
  List<XFile> selectedImage = []; // 현재 선택된 이미지들을 저장하는 리스트
  void onSelectImage() async{// 이미지 선택 이벤트 함수
    try{
      ImagePicker picker = ImagePicker(); //이미지 피커 객체 생성 , .pickMultiImage(); 이미지 여러개, .pickImage(); 이미지 한개
      List<XFile> pickeFile = await picker.pickMultiImage(); //사용자가 선택한 이미지들을 XFILE 파일로 반환한다.
        // XFile 인터페이스는 이미지들을 조작할 수 있는 메소드를 제공한다.
      if(pickeFile.isNotEmpty){// 선택된 이미지가 존재하면 상태변수에 저장한다. 이부분을 isEmpty로 하는 비어있으면 으로 되어 이미지 선택시 수량이 안올라감
        setState(() {
          selectedImage = pickeFile;
        });
      }
    } catch(e){print(e);}
  }


  // 3. 카테고리 조회 요청 함수 (+ 위젯이 로드될때 실행)
  void onCategory()async{
    try{
      final reponse = await dio.get("$baseUrl/product/category");
      setState(() {
        categoryList = reponse.data; print(categoryList);
      });
    }catch(e){print(e);}
  }


  // 2. 제품 등록 요청 함수 ( + FormData )
  void onResiter() async{
    try{
      // 1. (현재 로그인된) 토큰 확인
      final prefs = await SharedPreferences.getInstance(); // 전역변수 객체 호출 , 브라우저에 저장되어있는 토큰을 빼오는것
      final token = prefs.get("token"); // 전역변수 객체에 저장된 key 값 호출
      if(token == null){print("로그인후 가능합니다"); return;} // 비로그인 상태

      // 2. 폼데이터 구성(+ 첨부파일)
      FormData formData = FormData(); // 전송할 자료들을 바이너리(바이트) 타입으로 변경 // 이유 : 대용량
      // + formData.fields.add(MapEntry("필드명", "값")); -> 필드명은 자바의 DTO 필드명과 동일하게 해야한다.
      formData.fields.add(MapEntry("pname", pnameController.text));     // 폼에 입력받은 제품명 대입
      formData.fields.add(MapEntry("pcontent", pcontentController.text)); // 폼에 입력받은 내용 대입
      formData.fields.add(MapEntry("pprice", ppriceController.text)); // 폼에 입력받은 가격 대입
      formData.fields.add(MapEntry("cno", '${cno}')); // 폼에 입력받은 카테고리번호 대입
      // (*) 현재 선택된 이미지들을 formData 에 담아주기.
      for( XFile xFile in selectedImage ){ // 향상된 포문
        // Xfile 의 path : 파일의 경로 , xfile 의 name : 파일 이름 을 // dio의 multipartFile 이용하여 파일객체 만들기.
        // Xfile ----> multipartFile 변환
        final file = await MultipartFile.fromFile( xFile.path , filename:  xFile.name);
        // dio의 multipartFile 객체를 폼 대입 , XFile 자체는 전송이 불가능하다.
        formData.files.add(MapEntry("files", file)); // files 라는 이름으로 file(multiartFile)객체들을 대입한다.
      }

      // 3. DIO 요청
        dio.options.headers['Authorization'] = token; // 3-1 : HTTP Header(통신 정보)에 인증 정보 포함.
      final reponse = await dio.post("$baseUrl/product/register" , data: formData);

      // 4. DIO 응답 처리
      if(reponse.statusCode == 201 && reponse.data == true){print("제품등록"); Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainApp( page: 1, ) ));}
    }catch(e){print(e);}
  }

  // 5. 화면 반환
  @override
  Widget build(BuildContext context) {

    // + 카테고리 드롭다운 위젯 함수
    Widget CategoryDropdown(){
      //return DropdownButton(items: items, onChanged: onChanged);
        // items : 여러개의 드롭다운 안에 들어가는 여러개의 항목들
          // 리스트.map((반복면수){return}).toList()
        // onChange : 드롭다운 값의 선택이 변경 되었을때 이벤트 발생함수.
      // return DropdownButton(
      //     items: categoryList.map((category){return DropdownMenuItem(child: Text("아이템"));
      //     }).toList(),
      //     onChanged: (value){});
      return DropdownButtonFormField<int>( //제네릭 <int> : value에 들어가는 값 타입 -> 생략가능
          value: cno, //카테고리 번호 초기값
          hint: Text("카테고리 선택"), //가이드 라인
          decoration: InputDecoration(border: OutlineInputBorder()),// 바깥 테두리
          items: categoryList.map((category){
            return DropdownMenuItem<int>( // <int> value 에 들어가는 값 타입
              value: category['cno'],  // 드롭다운에서 값 선택시 반환되는 값
              child: Text(category['cname']),//  드롭다운 화면에 보이는 텍스트
            );
          }).toList(),
          onChanged: (value){setState(() {
            cno = value;
          });} // 변경된/선택된 값을 cno에 대입
      );
    }

    // (+) 선택한 이미지를 미리보기 함수
    Widget ImagePreview(){
      if(selectedImage.isEmpty){return SizedBox();}// 만약에 선택된 이미지가 없으면
      return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,//List 방향, 기본값이 세로, 가로 설정
          itemCount: selectedImage.length, //이미지 개수만큼 반복
          itemBuilder: (context , index){// 반복문
            final XFile xFile = selectedImage[index]; //index 번째 xfile 꺼내기
            return Padding(
                padding: EdgeInsets.all(5), //여백
                child: SizedBox(width: 100, height: 100,// 이미지 사이즈
                child: Image.file(File(xFile.path)),), // 현재 index 번째의 xfile 경로를 이미지로 출력
            );
          },
        ),
      );
    }


    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
              CategoryDropdown(),

            SizedBox(height: 16,),
              TextField(controller: pnameController,
                decoration: InputDecoration(
                    labelText: "제품명",
                    border: OutlineInputBorder()),),
              SizedBox(height: 16,),

              TextField(controller: pcontentController,
                maxLines: 3, //텍스트 줄 길이
                decoration: InputDecoration( labelText: "제품 명",border: OutlineInputBorder() ),),
              SizedBox(height: 16,),

              TextField(controller: ppriceController, maxLines: 3, decoration: InputDecoration(labelText: "제품 가격",border: OutlineInputBorder()),),
              SizedBox(height: 16,),

              TextButton.icon(
                icon: Icon(Icons.add_a_photo),
                label: Text("이미지 선택 : ${selectedImage.length}개"),
                onPressed: onSelectImage,
              ),
              ImagePreview(),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: onResiter  ,child: Text("제품등록")),
          ],
        ),
      ),
    );
  }
}