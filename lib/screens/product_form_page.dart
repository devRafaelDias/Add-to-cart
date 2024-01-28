import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formData = Map<String, Object>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() => setState(() {});

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'].toString(),
      description: _formData['description'].toString(),
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'].toString(),
    );

    print(newProduct.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                style: const TextStyle(color: Colors.black),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (name.trim().length < 3) {
                    return 'Nome precisa ter no mínimo 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                style: const TextStyle(color: Colors.black),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                focusNode: _priceFocus,
                validator: (_price) {
                  final priceString = _price ?? '-1';

                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Informe um preço válido.';
                  }

                  return null;
                },
                textInputAction: TextInputAction.next,
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (_description) {
                  final description = _description ?? '';

                  if (description.trim().isEmpty) {
                    return 'A descrição é obrigatória';
                  }
                  if (description.trim().length < 10) {
                    return 'A descrição precisa ter no mínimo 3 letras.';
                  }

                  return null;
                },
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                maxLines: 3,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'URL da Imagem'),
                      style: const TextStyle(color: Colors.black),
                      focusNode: _imageUrlFocus,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                      validator: (_imageUrl) {
                        final imageUrl = _imageUrl ?? '';

                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma Url válida';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text(
                            'Informe a Url',
                            style: TextStyle(color: Colors.black),
                          )
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
