import 'dart:io';

import 'package:app/api/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/ProductModel.dart';

class ProductAddForm extends StatefulWidget {
  @override
  _ProductAddFormState createState() => _ProductAddFormState();
}

class _ProductAddFormState extends State<ProductAddForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  File? _image;

  Future _getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your product here"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                          size: 60.0,
                        )
                      : null,
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Product Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a product name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Product Description",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a product description";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: "Product Price",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a product price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid price";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countController,
                decoration: InputDecoration(
                  labelText: "Quantity",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter quantity of the product";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid quantity";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: ()async {
                  if (_formKey.currentState!.validate()) {
                    ProductModel prod = new ProductModel(
                      name: _nameController.text,
                      price: _priceController.text,
                      amount: _countController.text,
                      image: "nil" 
                    );
                    await APIService.addProduct(prod);
                    // TODO: Add product to database or API
                    Navigator.pop(context);
                  }
                },
                child: Text("Add product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
