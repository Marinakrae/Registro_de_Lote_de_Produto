import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:registro_lote_casa_de_cha/dao/loteDAO.dart';
import 'package:registro_lote_casa_de_cha/model/Lote.dart';
import 'package:registro_lote_casa_de_cha/screens/android/boasVindas.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'listaLotes.dart';

class Produto {
  final int id;
  final String nome;

  Produto(this.id, this.nome);
}

class RegistroLote extends StatefulWidget {
  final Lote? lote;

  const RegistroLote({Key? key, this.lote}) : super(key: key);

  @override
  State<RegistroLote> createState() => _RegistroLoteState();
}

class _RegistroLoteState extends State<RegistroLote> {
  final _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  String _dataRecebimento = '';
  File? _imagePreview;

  late TextEditingController _quantidadeController;
  late TextEditingController _dataValidadeController;
  late TextEditingController _dataRecebimentoController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _quantidadeController = TextEditingController();
    _dataValidadeController = TextEditingController();
    _dataRecebimentoController = TextEditingController();

    if (widget.lote != null) {
      _quantidadeController.text = widget.lote!.quantidade.toString();
      _dataValidadeController.text = widget.lote!.dataValidade;
      _dataRecebimentoController.text = widget.lote!.dataRecebimento;
      _dataRecebimento = widget.lote!.dataRecebimento;

      // Selecionar o produto correspondente ao ID do lote
      _selectedProductId = widget.lote!.id_produto.toString();
    } else {
      _setDataHoraAtual();
    }
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
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  String _selectedProductId = '1';
  List<Produto> _products = [
    Produto(1, 'Produto A'),
    Produto(2, 'Produto B'),
    Produto(3, 'Produto C'),
  ];

  Produto getSelectedProduct() {
    int selectedId = int.parse(_selectedProductId);
    return _products.firstWhere((produto) => produto.id == selectedId);
  }

  @override
  Widget build(BuildContext context) {
    _dataRecebimentoController.text = _dataRecebimento;

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
                      child: Text(
                        'Selecione um produto:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        width: double.infinity,
                        child: DropdownButton(
                          value: _selectedProductId,
                          items: _products.map((Produto produto) {
                            return DropdownMenuItem(
                              value: produto.id.toString(),
                              child: Text(produto.nome),
                            );
                          }).toList(),
                          hint: Text('Selecione um produto'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedProductId = newValue ?? '';
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
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Quantidade recebida:',
                      prefixIcon: Icon(Icons.add_business_outlined),
                    ),
                    keyboardType: TextInputType.number,
                  ),
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
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Data de recebimento:',
                      prefixIcon: Icon(Icons.timer_outlined),
                    ),
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
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.pinkAccent,
                      ),
                    ),
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    label: Text('Tirar uma foto'),
                  ),
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
                          Produto selectedProduct = getSelectedProduct();
                          int selectedProductId = selectedProduct.id;

                          int idLote = DateTime.now().microsecondsSinceEpoch;

                          Lote lote = Lote(
                              idLote,
                              _dataValidadeController.text,
                              _dataRecebimento != null ? _dataRecebimento : _dataRecebimentoController.text,
                              int.parse(_quantidadeController.text),
                              selectedProduct.id
                          );

                          if (widget.lote != null) {
                            lote.id_Lote = widget.lote!.id_Lote;
                            LoteDAO().atualizar(lote).then((value) {
                              _showSnackBar('Lote atualizado com sucesso!');
                              Fluttertoast.showToast(
                                  msg: "Lote atualizado com sucesso!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => ListaLotesCadastradosPage()),
                                    (Route<dynamic> route) => false,
                              );
                            });
                          } else {
                            LoteDAO().adicionar(lote).then((value) {
                              _showSnackBar('Lote registrado com sucesso!');
                              Fluttertoast.showToast(
                                  msg: "Lote registrado com sucesso!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => ListaLotesCadastradosPage()),
                                    (Route<dynamic> route) => false,
                              );
                            });
                          }
                        });
                      } else {
                        _showSnackBar('Por favor, tire uma foto do lote.');
                        Fluttertoast.showToast(
                            msg: "Por favor, tire uma foto do lote.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.pinkAccent,
                      ),
                    ),
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text('Salvar'),
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
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagePreview = File(pickedFile.path);
      });
    }
  }

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }
}