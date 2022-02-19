import 'package:dev_note/Tab1.dart';
import 'package:dev_note/Tab2.dart';
import 'package:dev_note/Tab3.dart';
import 'package:dev_note/Tab4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text:'入力'),
    Tab(text:'記録'),
  ];
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length:tabs.length,vsync:this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        title:TabBar(
          tabs:tabs,
          controller:_tabController,
          unselectedLabelColor:Colors.grey,
          indicatorColor:Colors.blue,
          indicatorSize:TabBarIndicatorSize.tab,
          indicatorWeight:2,
          indicatorPadding:EdgeInsets.symmetric(horizontal:18.0,vertical:8),
          labelColor:Colors.black,
        ),
      ),
      body: TabBarView(
        controller:_tabController,
        children:tabs.map((tab){
          return _createTab(tab);
        }).toList(),
      ),
    );
  }
  Widget _createTab(Tab tab){
    if(tab == tabs[0]){
      return Tab1();
    } else if(tab == tabs[1]) {
      return Tab4();
    } else {
      return Tab3().showTab3();
    }
  }
}
