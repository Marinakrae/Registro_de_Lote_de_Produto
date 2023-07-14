import 'package:flutter/material.dart';
import 'package:registro_lote_casa_de_cha/dao/loteDAO.dart';
import 'package:registro_lote_casa_de_cha/screens/android/listaLotes.dart';
import 'package:registro_lote_casa_de_cha/screens/android/listaProdutos.dart';
import 'package:registro_lote_casa_de_cha/screens/android/login.dart';
import 'package:registro_lote_casa_de_cha/screens/android/registroLote.dart';

import '../../model/Lote.dart';
import '../../model/login.dart';

class BoasVindas extends StatelessWidget {

  // final Login usuarioLogado;
  //
  // const BoasVindas({Key? key, required this.usuarioLogado}) : super(key: key);

  const BoasVindas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/boasVindas.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Bem-vindo(a)!',
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.pinkAccent,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegistroLote();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 8),
                    Text("Registrar lote de produto"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  LoteDAO loteDao = LoteDAO();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ListaLotesCadastradosPage();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt_outlined),
                    SizedBox(width: 8),
                    Text("Lista de lotes registrados"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt_outlined),
                    SizedBox(width: 8),
                    Text("Lista de produtos"),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                    ),
                    icon: Icon(Icons.door_back_door_outlined, color: Colors.white,),
                    label: Text('Sair'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
