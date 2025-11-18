/*  
Enum Representa um grupo fixo de valores possíveis. Neste caso, podendo ser login ou cadastro.
- Define dois 'modos' 
*/ 

import 'dart:io';
import 'dart:isolate';

enum AuthMode {signup,login}
class AuthFormData {
  // criação de atributos 
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isLogin{
    return _mode == AuthMode.login;
  }

  bool get isSignup{
    return _mode == AuthMode.signup;
  }

  void toggleAuthMode(){// mod responsável para alternar entre módulos 
    _mode = isLogin ? AuthMode.signup : AuthMode.login;

  }





}