import 'package:flutter/material.dart';

class Imc extends StatefulWidget {
  const Imc({Key? key}) : super(key: key);

  @override
  State<Imc> createState() => _ImcState();
}

class _ImcState extends State<Imc> {

  double _altura = 171;
  double _peso = 60;
  double _imc = 0;
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          backgroundColor: Colors.pinkAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("Altura "+this._altura.toStringAsFixed(2)+" (cm)",
                  style:
                  TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400
                  )
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Slider(
                  min: 50.0,
                  max: 250.0,
                  onChanged: (altura){
                    setState(() {
                      this._altura = altura;
                    });
                  },
                  value: this._altura,
                )
              ),
              Text("Peso "+this._peso.toStringAsFixed(2)+" (kg)",
                  style:
                  TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400
                  )
              ),
              Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Slider(
                    min: 2.5,
                    max: 600.0,
                    onChanged: (peso){
                      setState(() {
                        this._peso = peso;
                      });
                    },
                    value: this._peso,
                  )
              ),
              Container(
                child: ElevatedButton.icon(
                  onPressed: (){
                    double imc = this._peso/((this._altura/100)*(this._altura/100));
                    String msg="";
                    if(imc < 18.5){
                      msg = "Você está abaixo do peso";
                    } else if (imc > 18.5 && imc < 25){
                      msg = "Você está normal";
                    } else {
                      msg = "Obeso...";
                    }

                    setState(() {
                      this._imc = imc;
                      this._msg = msg;
                    });
                  },
                  icon: Icon(Icons.accessibility_sharp, color: Colors.white,),
                  label: Text('Calcular'))
              ),
              Text("IMC: "+this._imc.toStringAsFixed(2)),
              Text(this._msg)
            ],
          ),
        )
      ),
    );
  }
}
