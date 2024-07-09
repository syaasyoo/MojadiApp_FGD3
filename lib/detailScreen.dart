import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fgd_2/components/cart_widget.dart';
import 'package:fgd_2/edit_screen.dart';
import 'package:fgd_2/providers/auth.dart';
import 'package:fgd_2/providers/cart.dart';
import 'package:fgd_2/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String productID;
  const DetailScreen({Key? key, required this.productID}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);
    var formatter = NumberFormat.decimalPattern('id');
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/title.png',
          height: 50,
        ),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (context, value, child) {
              return CartWidget(
                qty: value.totalItem.toString(),
              );
            },
          ),
          Consumer<Auth>(
            builder: (context, value, child) {
              return value.isUserLogin() && value.userRole == 'admin'
                  ? IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(
                              productID: widget.productID,
                            );
                          },
                        ));
                      },
                      icon: Icon(Icons.edit),
                    )
                  : Container();
            },
          )
        ],
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: product.productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var productsDetail = snapshot.data!.docs
                .firstWhere((element) => element.id == widget.productID)
                .data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Image.network(productsDetail['image']),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        productsDetail['name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset('assets/star.png',
                                width: 20, height: 20),
                            SizedBox(width: 5),
                            Text('4.8', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/truk.png',
                                width: 20, height: 20),
                            SizedBox(width: 5),
                            Text('Free', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/clock.png',
                                width: 20, height: 20),
                            SizedBox(width: 5),
                            Text('20 min', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(productsDetail['description']),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('SIZE:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: Text('10"',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFBD8456),
                            shape: BoxShape.circle,
                          ),
                          child: Text('14"',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: Text('16"',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Price',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Rp ${formatter.format(productsDetail['price'])}',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFBD8456))),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: decreaseQuantity,
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '$quantity',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: increaseQuantity,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Berhasil Ditambahkan'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        cart.addCart(
                            widget.productID,
                            productsDetail['name'],
                            productsDetail['price'].toDouble(),
                            quantity,
                            productsDetail['image']);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Color(0xFFBD8456)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ADD TO CART',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
