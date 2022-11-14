import 'dart:async';

import 'package:shop_app/config/secure_storage.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/repositories/repository.dart';

/// State of user
/// [LOGGED_IN] User logged in
/// [GUEST] User isn't logged in
/// [TOKEN_EXPIRED] User is logged in but token has expired
enum UserState { LOGGED_IN, GUEST, TOKEN_EXPIRED }

class UserRepository extends Repository {
  Future<bool> register(Map<String, String> inputData) async {
    await this.makePost(API_URL+'/admin/register', inputData: inputData);
    if (this.responseSuccess()) {
      try {
        print(this.getResponse().data);
        UserModel user = UserModel.fromJson(this.getResponse().data);
        setLoggedUser(user);
        return true;
      } catch (err) {
        print(err.toString());
      }
    }
    return false;
  }

  Future<bool> login(Map<String, String> inputData) async {
    await this.makePost(API_URL+'/admin/login', inputData: inputData);
    if (this.responseSuccess()) {
      try {
        print(this.getResponse().data);
        UserModel user = UserModel.fromJson(this.getResponse().data);
        setLoggedUser(user);
        return true;
      } catch (err) {
        print(err.toString());
      }
    }
    return false;
  }

  Future<void> logout() async {
    await this.makePost(API_URL+'/admin/logout', inputData: {});
    if (this.responseSuccess()) {
      try {
        setLoggedUser(null);
      } catch (err) {
        print(err.toString());
      }
    }
  }
}
