class Utilities{
  final String MY_MATCH = "myMatch";
  final String YOUR_MATCH = "yourMatch";
  Map<String,String> getMatch(List<String> list){
    int myMatchPoint = 0;
    int yourMatchPoint = 0;
    for(String data in list){
      if(isMeWin(data)){
        myMatchPoint++;
      } else {
        yourMatchPoint++;
      }
    }
    Map<String,String> map = {
      MY_MATCH:myMatchPoint.toString()
      ,YOUR_MATCH:yourMatchPoint.toString()
    };
    return map;
  }
  bool isMeWin(String str){
    List<String> strList = str.split('-');
    if(2 == strList.length){
      return int.parse(strList[0]) > int.parse(strList[1]); 
    } else {
      return false;
    }
  }
}