import 'dart:convert';
import 'package:dev_note/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:dev_note/Note.dart';

class Tab4 extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _Tab4();
  }
}
class _Tab4 extends State<Tab4>{
  late BuildContext _context;
  List<Note> _allData = [];
  List<dynamic> _gameResult = [];
  List<Map<String,String>> _match = [];

  @override
  void initState(){
    getSaveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    this._context = context;
    return Column(
      children:[
        TextButton(child:const Text('削除'),onPressed: (){ deleteAllData(); },),
        TextButton(child:const Text('更新'),onPressed: (){ getSaveData(); },),
        Flexible(
          child:ListView.builder(
            itemCount: this._allData.length,
            itemBuilder: (BuildContext context,int index){
              return listData(index);
            }
          ),
        ),
      ],
    );
  }

  void getSaveData() async{
    this._allData = await Note.getDatas();
    this._gameResult.clear();
    for(Note note in this._allData){
      setState((){
        this._gameResult.add(jsonDecode(note.gameResult));
      });
    }
    for(dynamic json in this._gameResult){
      List<String> dataList = [];
      for(int i = 0; i < json.length; i++){
        dataList.add(json[i]);
      }
      setState(() {
        this._match.add( Utilities().getMatch(dataList) );
      });
    }
  }

  Widget listData(int index){
    return 
    Container(
      decoration: BoxDecoration(
        border: Border.all(color:Colors.black),
      ),
      margin:EdgeInsets.only(top:8),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left:10),
            child:Text(this._allData[index].myName),
          ),
          Container(
            margin: EdgeInsets.only(left:10),
            child:Text(this._match[index][Utilities().MY_MATCH].toString()),
          ),
          Column(
            children:[
              Container(
                margin: EdgeInsets.only(left:10),
                child:Text(this._gameResult[index].length > 0 ? this._gameResult[index][0]:''),
              ),
              Container(
                margin: EdgeInsets.only(left:10),
                child:Text(this._gameResult[index].length > 1 ? this._gameResult[index][1]:''),
              ),
              Container(
                margin: EdgeInsets.only(left:10),
                child:Text(this._gameResult[index].length > 2 ? this._gameResult[index][2]:''),
              ),
              Container(
                margin: EdgeInsets.only(left:10),
                child:Text(this._gameResult[index].length > 3 ? this._gameResult[index][3]:''),
              ),
              Container(
                margin: EdgeInsets.only(left:10),
                child:Text(this._gameResult[index].length > 4 ? this._gameResult[index][4]:''),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left:10),
            child:Text(this._match[index][Utilities().YOUR_MATCH].toString()),
          ),
          Container(
            margin: EdgeInsets.only(left:10),
            child:Text(this._allData[index].yourName),
          ),
        ],
      ),
    );
  }

  void deleteAllData() async{
    var result = await showDialog<int>(
      context: this._context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title:Text('確認'),
          content:Text('登録済みの全てのデータを削除します。よろしいですか？'),
          actions: [
            TextButton(child:Text('OK'),onPressed: () => Navigator.of(context).pop(1),),
            TextButton(child:Text('Cancel'),onPressed: () => Navigator.of(context).pop(0),),
          ],
        );
      }
    );
    if(1 == result){
      Note.deleteData(0);
    }
  }
}