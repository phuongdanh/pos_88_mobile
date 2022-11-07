import 'package:shop_app/helper/util.dart';

class UserModel {

  String id;
  String userName;
  String? name;
  String? email;
  String? companyId;
  String token;

  UserModel({required this.id, required this.userName, this.name, this.email, this.companyId, required this.token});

  factory UserModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new UserModel(
      id: Util.getString(parsedJson['user_id'])??"",
      name: Util.getString(parsedJson['name']),
      userName: Util.getString(parsedJson['name'])!,
      email: Util.getString(parsedJson['email']),
      companyId: Util.getString(parsedJson['company_id']),
      token: Util.getString(parsedJson['token'])??""
    );
  }

  toJson() {
    return {
      "user_id": this.id,
      "user_name": this.userName,
      "name": this.name,
      "email": this.email,
      "company_id": this.companyId,
      "token": this.token,
    };
  }
}
