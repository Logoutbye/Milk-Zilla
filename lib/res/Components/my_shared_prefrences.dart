
import 'package:shared_preferences/shared_preferences.dart';


class MySharedPrefencesSessionHandling {
  // shared preferences variables for session handling

  static String? whichUserLoggedIn = "";

  static getWhichUserLoggedInFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    whichUserLoggedIn = prefs.getString('whichUserLoggedIn');
  }

  static removeWhichUserLoggedInFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('whichUserLoggedIn');

    If(kDebugMode) {
      print("User Data removed on logout");
    }
  }

  static void setOrupdateWhichUserLoggedInSharedPreferences(
    var whichUserLoggedIn_passed,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('whichUserLoggedIn', '$whichUserLoggedIn_passed');

    whichUserLoggedIn = whichUserLoggedIn_passed;
  }

}
