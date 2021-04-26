import 'package:shared_preferences/shared_preferences.dart' ;

 class SharedPreferencesHelper {

   static Future<bool> clearSP() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance() ;
     return prefs.clear();
   }

   static Future<bool> checkKey(String keyname) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance() ;
     return prefs.containsKey(keyname) ;
   }


   static Future<bool>  setUseremail(String useremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('useremail', useremail) ;
  }

  static Future<String> getUseremail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('useremail') ;
  }

 }