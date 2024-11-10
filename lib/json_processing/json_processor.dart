import 'dart:convert';

class JsonProcessor {
  
  List<String> jsonToTags(String tagsJson){
    List temp = jsonDecode(tagsJson);
    List<String> decodedTagsList  = [];
    for (var element in temp) {
      decodedTagsList.add("$element");
    }
    return decodedTagsList;
  }

}