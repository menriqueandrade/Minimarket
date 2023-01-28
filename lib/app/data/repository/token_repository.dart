
import 'package:get_storage/get_storage.dart';

class TokenRepository {

  final storage = GetStorage();

  Future<bool?> token()async{
    return storage.read('token') != null;
    // final SharedPreferences localuser = await SharedPreferences.getInstance();    
    // return localuser.getString('token')!=null;
  }
  Future<String?> getToken()async{
    return storage.read('token');
    // final SharedPreferences localuser = await SharedPreferences.getInstance();    
    // return localuser.getString('token');
  }
  Future<void> setToken(token)async{
    storage.write('token', token);
    // final SharedPreferences localuser = await SharedPreferences.getInstance();    
    // localuser.setString('token',token);
  }
  deletetoken()async{
    storage.remove('token');
    // final SharedPreferences localuser = await SharedPreferences.getInstance();        
    // await localuser.clear();
  }
}