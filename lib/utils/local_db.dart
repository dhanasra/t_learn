import 'package:shared_preferences/shared_preferences.dart';

class LocalDBKeys{

  static const name = "name";
  static const exam = "exam";
  static const theme = "theme";
  static const appLang = "app-lang";
  static const saved = "saved";
  static const today = "today";

}

class LocalDB {

  static LocalDB? _instance;
  LocalDB._();

  factory LocalDB() {
    _instance ??= LocalDB._();
    return _instance!;
  }

  static Future<void> save(String key, dynamic value) async{
    var preferences = await SharedPreferences.getInstance();

    print("1 $key");
    await preferences.setString(key, value);
    if(value.runtimeType is String){

      print("2 $key");
      await preferences.setString(key, value);
    }else if(value.runtimeType is bool){

      print("3 $key");
      await preferences.setBool(key, value);
    }else if(value.runtimeType is int){

      print("4 $key");
      await preferences.setInt(key, value);
    }

  }

  static Future<dynamic> get(Type type, String key)async{
    var preferences = await SharedPreferences.getInstance();

    if(type.toString() == "String"){
      return preferences.getString(key);
    }else if(type.toString() == "bool"){
      return preferences.getBool(key);
    }else if(type.toString() == "int"){
      return preferences.getInt(key);
    }else{
      return "";
    }
  }

  static Future<String?> getExamCode()async{
    var preferences = await SharedPreferences.getInstance();
    return preferences.getString(LocalDBKeys.exam);
  }
}