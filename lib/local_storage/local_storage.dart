
import 'package:employee/constants/local_storage_keys.dart';
import 'package:employee/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage{

  var storage = GetStorage();

  writeUserModel(UserModel userModel){
    storage.write(LocalStorageKey.userModel, userModel);
  }

 UserModel readUserModel(){
    var data = storage.read(LocalStorageKey.userModel);

    if(data.runtimeType==UserModel){
      return data;
    }
    return UserModel();
 }

}