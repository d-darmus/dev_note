import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dev_note/Note.dart';

class Tab1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _Tab1();
  }
}
class _Tab1 extends State<Tab1> {
  String _input = "";
  List<String> _oneTimeData = [];
  late BuildContext _context;
  var _myNameController = TextEditingController();
  var _yourNameController = TextEditingController();
  @override
  Widget build(BuildContext context){
    this._context = context;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Container(
            child:Row(
              children:[
                Flexible(child:TextField(decoration: InputDecoration(hintText:"自分の名前"),controller: _myNameController,)),
                Flexible(child:TextField(decoration: InputDecoration(hintText:"相手の名前"),controller: _yourNameController,)),
              ],
            ),
          ),
          Container(
            child:Text('$_oneTimeData'),
            margin:EdgeInsets.only(bottom:10,top:10),
          ),
          Container(
            child:Text('$_input'),
            margin:EdgeInsets.only(bottom:10,top:10),
          ),
          // 電卓
          Container(
            color:Colors.blue,
            child:Row(children:[
              TextButton(child:const Text('7',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('7'); }),
              TextButton(child:const Text('8',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('8'); }),
              TextButton(child:const Text('9',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('9'); }),
            ]),
          ),
          Container(
            color:Colors.blue,
            child:Row(children:[
              TextButton(child:const Text('4',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('4'); }),
              TextButton(child:const Text('5',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('5'); }),
              TextButton(child:const Text('6',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('6'); }),
            ]),
          ),
          Container(
            color:Colors.blue,
            child:Row(children:[
              TextButton(child:const Text('1',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('1'); }),
              TextButton(child:const Text('2',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('2'); }),
              TextButton(child:const Text('3',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('3'); }),
            ]),
          ),
          Container(
            color:Colors.blue,
            child:Row(children:[
              TextButton(child:const Text('-',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('-'); }),
              TextButton(child:const Text('0',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addString('0'); }),
              TextButton(child:const Text('C',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ clearString(); }),
            ]),
          ),
          Container(
            color:Colors.blue,
            child:TextButton(child:const Text('次のゲームへ',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ addOneTimeData(this._input); clearString(); }),
          ),
          Container(
            color:Colors.blue,
            child:TextButton(child:const Text('一時保存済みマッチデータを削除',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ clearOneTimeData(); }),
          ),
          Container(
            color:Colors.blue,
            child:TextButton(child:const Text('マッチデータを登録',style:TextStyle(color:Colors.white)),style:ElevatedButton.styleFrom(elevation:24,),onPressed: (){ registData(); }),
          ),
        ]
      )
    );
  }
  void addString(String str){
    this._input+=str;
    setState((){});
  }
  void clearString(){
    this._input="";
    setState((){});
  }
  void addOneTimeData(String str){
    this._oneTimeData.add(str);
    setState((){});
  }
  void clearOneTimeData(){
    this._oneTimeData.clear();
    setState((){});
  }
  void registData() async{
    var result = await showDialog<int>(
      context: this._context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title:Text('確認'),
          content:Text('登録します\n'
            +this._myNameController.text+'-'+this._yourNameController.text+'\n'
            +this._oneTimeData.toString()),
          actions: [
            TextButton(child:Text('OK'),onPressed: () => Navigator.of(context).pop(1),),
            TextButton(child:Text('Cancel'),onPressed: () => Navigator.of(context).pop(0),),
          ],
        );
      }
    );
    if(1 == result){
      String _json = jsonEncode(this._oneTimeData);
      Note _note = Note(
        myName: this._myNameController.text
        ,yourName: this._yourNameController.text
        ,gameResult: _json
      );
      await Note.insertData(_note);
    }
  }
}