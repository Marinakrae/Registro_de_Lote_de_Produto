import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:registro_lote_casa_de_cha/dao/loteDAO.dart';
import 'package:registro_lote_casa_de_cha/model/Lote.dart';
import 'package:registro_lote_casa_de_cha/screens/android/boasVindas.dart';


class RegistroLote extends StatefulWidget {
  const RegistroLote({Key? key}) : super(key: key);

  @override
  State<RegistroLote> createState() => _RegistroLoteState();
}

class _RegistroLoteState extends State<RegistroLote> {
  final _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  String _dataRecebimento = '';
  File? _imagePreview;

  //Valores dos campos
  late TextEditingController _quantidadeController;
  late TextEditingController _dataValidadeController;
  late TextEditingController _dataRecebimentoController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _setDataHoraAtual();

    _quantidadeController = TextEditingController();
    _dataValidadeController = TextEditingController();
    _dataRecebimentoController = TextEditingController(text: _dataRecebimento);
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _dataValidadeController.dispose();
    _dataRecebimentoController.dispose();
    super.dispose();
  }

  void _setDataHoraAtual() {
    final agora = DateTime.now();
    setState(() {
      _dataRecebimento = _dateTimeFormat.format(agora);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _selectedProduct = 'Produto A';
  List<String> _products = [
    'Produto A',
    'Produto B',
    'Produto C',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                      child: Text('Selecione um produto:',
                          style: TextStyle(fontSize: 16)),
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
                      controller: _quantidadeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: 'Quantidade recebida:',
                          prefixIcon:
                          Icon(Icons.add_business_outlined)),
                      keyboardType: TextInputType.number),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Container(
                  child: TextField(
                    controller: _dataValidadeController,
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
                    controller: _dataRecebimentoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        labelText: 'Data de recebimento:',
                        prefixIcon: Icon(Icons.timer_outlined)),
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
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.pinkAccent),
                      ),
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      label: Text('Tirar uma foto')),
                ),
              ),
              Image(
                image: _imagePreview != null
                    ? FileImage(_imagePreview!) as ImageProvider<Object>
                    : AssetImage('lib/assets/imgPreview.png'),
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_imagePreview != null) {
                        convertImageToBase64(_imagePreview!).then((base64Image) {
                          // Lote lote = Lote(
                          //   200,
                          //   _dataValidadeController.text,
                          //   _dataRecebimentoController.text,
                          //   int.parse(_quantidadeController.text),
                          //   100,
                          //   base64Image,
                          // );
                          Lote loteSemImagem = Lote (
                            200,
                            _dataValidadeController.text,
                            _dataRecebimentoController.text,
                            int.parse(_quantidadeController.text),
                            100
                          );
                          LoteDAO().adicionar(loteSemImagem);

                          // Exibir mensagem de sucesso
                          _showSnackBar('Cadastro realizado com sucesso');

                          // Voltar para a tela anterior após 2 segundos
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        });
                      }
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return BoasVindas();
                            }));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      icon: Icon(Icons.cancel_outlined, color: Colors.white),
                      label: Text('Cancelar')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        if (image != null) {
          _imagePreview = File(image.path);
        } else {
          return;
        }
      });
    } on PlatformException catch (e) {
      print('Falha em abrir a imagem: $e');
    }
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: 'dd/mm/yyyy',
    type: MaskAutoCompletionType.eager,
  );

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }
}
