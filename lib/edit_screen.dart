import 'package:fgd_2/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.productID});
  final String productID;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  //controller for product name, description, and price
  final productC = TextEditingController();
  final descriptionC = TextEditingController();
  final priceC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final productData = product.getData(widget.productID);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: productData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var productsDetail = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Image.network(productsDetail['image']),
                  TextFormField(
                    controller: productC..text = productsDetail['name'],
                    decoration:
                        const InputDecoration(labelText: 'Product Name'),
                  ),
                  TextFormField(
                    controller: descriptionC
                      ..text = productsDetail['description'],
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextFormField(
                    controller: priceC
                      ..text = productsDetail['price'].toString(),
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  const SizedBox(height: 20),
                  //update button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFBD8456),
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      product.updateProduct(
                        widget.productID,
                        productC.text,
                        descriptionC.text,
                        productsDetail['image'],
                        int.parse(priceC.text),
                      );
                      //snack bar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product Berhasil Diupdate'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //delete button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      product.deleteProduct(widget.productID);
                      //snack bar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product Berhasil Dihapus'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      //pop 2x to go back to home screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Hapus',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
