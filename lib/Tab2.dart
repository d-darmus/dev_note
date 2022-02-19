import 'package:flutter/material.dart';
import 'package:dev_note/Note.dart';

class Tab2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _Tab2();
  }
}
class _Tab2 extends State<Tab2>{
  late BuildContext _context;
  List<Note> _allData = [];
  @override
  Widget build(BuildContext context){
    this._context = context;
    return Column(
      children:[
        TextButton(child:const Text('削除'),onPressed: (){ Note.deleteData(0); },),
        TextButton(child:const Text('更新'),onPressed: (){ getSaveData(); setState((){}); },),
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
  }
  Widget listData(int index){
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left:10),
          child:Text(this._allData[index].myName),
        ),
        Container(
          margin: EdgeInsets.only(left:10),
          child:Text(this._allData[index].yourName),
        ),
        Container(
          margin: EdgeInsets.only(left:10),
          child:Text(this._allData[index].gameResult),
        ),
      ],
    );
  }
}