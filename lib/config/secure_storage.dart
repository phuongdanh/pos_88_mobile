import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app/models/User.dart';

final secureStorage = new FlutterSecureStorage();

Future<UserModel?> getLoggedUser() async {
  String? str = await secureStorage.read(key: "loggedUser");
  if (str == null || str == "") {
    return null;
  }
  try {
    var userJson = json.decode(str);
    return UserModel.fromJson(userJson);
  } catch (err) {
    return null;
  }
}

setLoggedUser(UserModel value) {
  secureStorage.write(key: "loggedUser", value: json.encode(value));
}

