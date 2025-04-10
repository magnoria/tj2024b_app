

import 'package:flutter/material.dart';

class EquipUpdate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EquipUpdateState();
  }
}

class _EquipUpdateState extends State<EquipUpdate>{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("수정화면"),),
      body: Center(
        child: Column(
          children: [
            TextField(controller: , decoration: InputDecoration(labelText: "비품이름"),),
            
            TextField(controller: , decoration: InputDecoration(labelText: "비품내용"),),
            
            TextField(controller: , decoration: InputDecoration(labelText: "비품수량"),),
            
            OutlinedButton(onPressed: onPressed, child: Text("수정하기"))
          ],
        ),
      ),
    );
  }
}