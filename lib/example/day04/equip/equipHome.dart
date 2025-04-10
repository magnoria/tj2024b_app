
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EquipHome extends StatefulWidget{
  @override
  _EquipHomeState createState() {
    return _EquipHomeState();
  }
}

class _EquipHomeState extends State<EquipHome>{
  Dio dio = Dio();
  List<dynamic> equipList = [];
  
  //비품 조회함수
  void equipFindAll() async{
    try{
      final response = await dio.get("http://192.168.40.25:8080/day04/equip");
      final data = response.data;
      print( data );
      setState(() {
         equipList = data;
      });
    }catch(e) {print(e);}
  }

  @override
  void initState() {
    super.initState();
    equipFindAll();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인페이지"),),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: ()=> {Navigator.pushNamed(context, "/write")},
                child: Text("비품추가")
            ),
            SizedBox(height: 20,),
            
            Expanded(child: ListView(
              children:
              equipList.map((equip) {
                return Card(
                  //{"name" : "비품1" , "description" : "비상보충용" , "quantity" : "10"}
                  child: ListTile(
                    title: Text("비품리스트"),
                     subtitle: Column(
                       children: [
                         Text("비품이름 : ${equip['name']}"),
                         Text("비품내용 : ${equip['description']}"),
                         Text("비품수량 : ${equip['quantity']}"),
                       ],
                     ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () => {Navigator.pushNamed(context, "/update", arguments: equip['id'])}, icon: Icon(Icons.add_box_rounded)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ))
            
          ],
        ),
      )
    );
  }
}