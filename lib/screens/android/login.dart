import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registro_lote_casa_de_cha/screens/android/boasVindas.dart';
import 'package:registro_lote_casa_de_cha/screens/android/listaLotes.dart';
import 'package:registro_lote_casa_de_cha/screens/android/registroLote.dart';
import 'package:registro_lote_casa_de_cha/service/loginService.dart';

import '../../model/login.dart';
import 'imc.dart';

class LoginPage extends StatelessWidget {
  //const Login({Key? key}) : super(key: key);

  final loginController = TextEditingController();
  final senhaController = TextEditingController();
  Login usuarioLogado = Login.empty();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Casa de Chá",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.pinkAccent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
                  child: Image.asset('lib/assets/logo.png', height: 110),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: loginController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)
                          ),
                          labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: TextField(
                    controller: senhaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.password_outlined),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.pinkAccent,
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        if (logar(loginController.value.text, senhaController.value.text, context)) {
                          return BoasVindas();
                        } else {
                          return LoginPage();
                        }
                      }));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.door_front_door_outlined),
                        SizedBox(width: 8),
                        Text("Entrar"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

logar(String login, String senha, BuildContext context) {
  // new LoginService().login(login, senha).then((value)=> {
  // });
  if (login == "marina@teste" && senha == "123"){
    return true;
  } else {
    Fluttertoast.showToast(
        msg: "Usuário não identificado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return false;
  }
}
