import 'dart:convert';

class JsonProcessor {
  
  List<String> jsonToList(String stringJson){
    List temp = jsonDecode(stringJson);
    List<String> decodedList  = [];
    for (var element in temp) {
      decodedList.add("$element");
    }
    return decodedList;
  }

}