import 'package:bloc_project_2/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LoginApiProtocol{
   LoginApiProtocol();

   Future<LoginHandle?> login({
     required String email,
     required String password,
   });
}

class LoginApi implements LoginApiProtocol{
   //Singleton pattern
//    LoginApi._sharedInstance();
//  static  LoginApi _shared = LoginApi._sharedInstance();
//    factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email, 
    required String password,
    }) => Future.delayed( 
      Duration(seconds: 2),
      () => email =='foo@bar.com' && password=='foobar',
    ).then((isLoggedIn) => isLoggedIn? LoginHandle.fooBar(): null);

}