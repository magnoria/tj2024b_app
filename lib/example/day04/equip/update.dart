

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EquipUpdate extends StatefulWidget{
  @override
  _EquipUpdateState createState() {
    return _EquipUpdateState();
  }
}

class _EquipUpdateState extends State<EquipUpdate>{

  // 위젯으로 부터 전달받은 인수 가져오기
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    int id = ModalRoute.of(context)!.settings.arguments as int;
    equipFindById(id);
  }

  // 컨트롤러에 초기값 대입
  Dio dio = Dio();
  Map<String , dynamic> equip = {};
  void equipFindById(id) async{
    try{
      final response = await dio.get("http://192.168.40.25:8080/day04/equip/view?id=$id");
      final data = response.data;
      setState(() {
        equip = data;
        nameContoller.text = data['name'];
        descriptionController.text = data['description'];
        quantityController.text = data['quantity'];
      });
    }catch(e){print(e);}
  }

  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();


  // 수정된 값으로 자바에게 수정처리 요청
  void equipUpdate() async{
    try{
      final sendData = {
        "id" : equip['id'],
        "name" : nameContoller.text,
        "description" : descriptionController.text,
        "quantity" : quantityController.text
      };
      final response = await dio.put("http://192.168.40.25:8080/day04/equip", data: sendData );
      final data = response.data;
      if(data != null){Navigator.pushNamed(context, "/");}
    }catch(e){print(e);}

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("수정화면"),),
      body: Center(
        child: Column(
          children: [
            TextField(controller: nameContoller, decoration: InputDecoration(labelText: "비품이름"),maxLength: 10,),
            
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "비품내용"),maxLength: 10,),
            
            TextField(controller: quantityController , decoration: InputDecoration(labelText: "비품수량"),maxLength: 3,),
            
            OutlinedButton(onPressed: equipUpdate, child: Text("수정하기"))
          ],
        ),
      ),
    );
  }
}