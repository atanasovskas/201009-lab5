import 'package:flutter/material.dart';
import 'package:mis_lab3/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  String? errorMess="";
  bool isLogin=true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> singInWithEmailAndPassword() async{
    try{
      await Auth().singInWithEmailAndPassword(email: _controllerEmail.text,
          password: _controllerPassword.text,
      );
    }
    on FirebaseAuthException catch(err){
      setState(() {
        errorMess = err.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    try{
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    }
    on FirebaseAuthException catch(err){
      setState(() {
        errorMess = err.message;
      });
    }
  }

  Widget _title(){
    return const Text("Exams");
  }

  Widget _entryField(
      String title,
      TextEditingController controller,
      ){
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        labelText:  title,
      ),
    );
  }

  Widget _errorMessage(){
    return Text(errorMess == '' ? '' : '$errorMess');
  }

  Widget _submitButtom() {
    return ElevatedButton(
      onPressed:
      isLogin ? singInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'login' : 'Register'),
    );
  }
    Widget _loginOrRegisterButtom() {
      return TextButton(
        onPressed: (){
          setState(() {
            isLogin =!isLogin;
          });
        },
        child: Text(isLogin ? "You don't have account? Register here" : 'You have already account? Login here'),
      );
    }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container (
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            _errorMessage(),
            _submitButtom(),
            _loginOrRegisterButtom(),
          ],
        ),
      ),
    );
  }
}