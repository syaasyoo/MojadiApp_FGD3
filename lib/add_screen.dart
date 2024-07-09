import 'dart:io';

import 'package:fgd_2/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

import 'homeScreen.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var productC = TextEditingController();

  var descriptionC = TextEditingController();

  var imageC = TextEditingController();

  var priceC = TextEditingController();

  final DateFormat formatter = DateFormat('yyyyMMddHmmss');

  File? _imageFile;
  late String _fileName;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _fileName =
            formatter.format(DateTime.now()) + p.extension(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: productC,
              decoration: InputDecoration(
                labelText: 'Product Name',
                hintText: 'Product Name...',
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextField(
                controller: descriptionC,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            _imageFile != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.file(
                              _imageFile!,
                              width: 100,
                              height: 100,
                            ),
                            Text(_fileName),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _imageFile = null;
                            });
                          },
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: LinearBorder(),
                        padding: EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        pickImage();
                      },
                      child: Text(
                        'Pick Image',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextField(
                controller: priceC,
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFBD8456),
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                onPressed: () {
                  product.uploadImage(_imageFile!.path, _fileName).then(
                    (imageUrl) {
                      print(imageUrl);
                      product.addProduct(
                        productC.text,
                        descriptionC.text,
                        imageUrl,
                        int.parse(priceC.text),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Product Added'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    onError: (err) {
                      print('Error : $err');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error : $err'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
