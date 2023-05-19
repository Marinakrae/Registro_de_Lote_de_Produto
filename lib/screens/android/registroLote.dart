import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:registro_lote_casa_de_cha/screens/android/boasVindas.dart';

class RegistroLote extends StatefulWidget {
  const RegistroLote({Key? key}) : super(key: key);

  @override
  State<RegistroLote> createState() => _RegistroLoteState();
}

class _RegistroLoteState extends State<RegistroLote> {

  final _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm'); // Define o formato da data e hora

  String _dataRecebimento = '';
  File? _imagePreview;

  @override
  void initState() {
    super.initState();
    _setDataHoraAtual(); // Define a data e hora atuais ao iniciar o estado
  }

  void _setDataHoraAtual() {
    final agora = DateTime.now(); // Obtém a data e hora atuais
    setState(() {
      _dataRecebimento = _dateTimeFormat.format(agora); // Formata a data e hora no formato desejado
    });
  }

  String _selectedProduct = 'Produto A'; // Variável para armazenar o produto selecionado

  List<String> _products = [
    'Produto A',
    'Produto B',
    'Produto C',
  ]; // Lista de produtos

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return BoasVindas();
                }));
              },
            ),
            title: Text("Registro de Lote"),
            backgroundColor: Colors.pinkAccent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Text('Selecione um produto:', style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Container(
                          width: double.infinity,
                          child: DropdownButton(
                            value: _selectedProduct,
                            items: _products.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text('Selecione um produto'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedProduct = newValue ?? '';
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80.0)
                            ),
                            labelText: 'Quantidade recebida:',
                            prefixIcon: Icon(Icons.add_business_outlined)
                        ),
                        keyboardType: TextInputType.number
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Container(
                    child: TextField(
                      //inputFormatters: [maskFormatter],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        labelText: 'Data de validade:',
                        prefixIcon: Icon(Icons.date_range_outlined),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80.0)
                            ),
                            labelText: 'Data de recebimento:',
                            prefixIcon: Icon(Icons.timer_outlined)
                        ),
                        controller: TextEditingController(text: _dataRecebimento),
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          pickImage();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                        ),
                        icon: Icon(Icons.camera_alt, color: Colors.white,),
                        label: Text('Tirar uma foto')
                    ),
                  ),
                ),
                Image(
                  image: _imagePreview != null ? FileImage(_imagePreview!) as ImageProvider<Object> : AssetImage('lib/assets/imgPreview.png'),
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Lógica do botão "Salvar"
                      },
                      icon: Icon(Icons.save_outlined, color: Colors.white),
                      label: Text('Salvar', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return BoasVindas();
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        icon: Icon(Icons.cancel_outlined, color: Colors.white,),
                        label: Text('Cancelar')
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  //Metodo para abrir a camera
  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      //final imageTemp = PickedFile(image?.path);

      setState(() {
        if (image != null) {
          _imagePreview = File(image.path);
        } else {
          return;
        }
      });

    } on PlatformException catch(e) {
      print('Falha em abrir a imagem: $e');
    }
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: 'dd/mm/yyyy',
      type: MaskAutoCompletionType.eager
  );
}

