import 'dart:async';

import 'package:shop_app/constants.dart';
import 'package:shop_app/repositories/repository.dart';

/// State of user
/// [LOGGED_IN] User logged in
/// [GUEST] User isn't logged in
/// [TOKEN_EXPIRED] User is logged in but token has expired
enum UserState { LOGGED_IN, GUEST, TOKEN_EXPIRED }

class UserRepository extends Repository {
  Future register(Map<String, String> inputData) async {
    await this.makePost(API_URL+'/admin/register', inputData: inputData);
    if (this.responseSuccess()) {
      print(this.responseSuccess());
    }
  }

  Future login(Map<String, String> inputData) async {
    await this.makePost(API_URL+'/admin/login', inputData: inputData);
    print(this.responseData.data);
  }
}
