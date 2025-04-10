
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EquipWrite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EquipWriteState();
  }
}


class _EquipWriteState extends State<EquipWrite>{
  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  
  Dio dio = Dio();
  void equipSave() async{
    try{
      final sendData = {
        "name" : nameContoller.text,
        "description" : descriptionController.text,
        "quantity"  : quantityController.text
      };
      final response = await dio.post("http://192.168.40.25:8080/day04/equip", data: sendData);
      final data = response.data;
      if(data != null){
        Navigator.pushNamed(context, "/");
      }
      
    }catch(e){print(e);}
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("물품 등록화면"),),
      body: Column(
        children: [

          Text("물품등록"),

          TextField(
            controller: nameContoller,
            decoration: InputDecoration(labelText: "비품이름"),
            maxLength: 10,
          ),


          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: "비품내용"),
            maxLines: 10,
          ),


          TextField(
            controller: quantityController,
            decoration: InputDecoration(labelText: "비품수량"),
            maxLines: 3,
          ),
          

          OutlinedButton(onPressed: equipSave, child: Text("등록하기"))
        ],      
      ),
    );
  }
}