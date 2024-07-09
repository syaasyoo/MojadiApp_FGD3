import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fgd_2/add_screen.dart';
import 'package:fgd_2/components/cart_widget.dart';
import 'package:fgd_2/detailScreen.dart';
import 'package:fgd_2/login_screen.dart';
import 'package:fgd_2/profile_screen.dart';
import 'package:fgd_2/providers/cart.dart';
import 'package:fgd_2/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = true;

  @override
  void initState() {
    displayUserRole();
    super.initState();
  }

  void displayUserRole() async {
    final auth = Provider.of<Auth>(context, listen: false);
    String role = await auth.getUserRole();
    print('User role is: $role');
    setState(() {
      auth.userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    //get user role from auth function

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
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
          )
        ],
        backgroundColor: Colors.white,
      ),
      drawer: Consumer<Auth>(
        builder: (context, value, child) {
          return Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  title: Center(
                    child: Image.asset('assets/title.png'),
                  ),
                ),
                value.isUserLogin()
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          ),
                          title: Text('Profile'),
                          tileColor: Color(0xFFBD8456),
                        ),
                      )
                    : SizedBox(),
                value.isUserLogin() && value.userRole == 'admin'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddScreen(),
                            ),
                          ),
                          title: Text('Add Product'),
                          tileColor: Color(0xFFBD8456),
                        ),
                      )
                    : SizedBox(),
                value.isUserLogin()
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          onTap: () => value.logoutUser().then(
                            (value) {
                              if (value) {
                                Navigator.pop(context);
                                //change user role to user
                                setState(() {
                                  auth.userRole = 'user';
                                });
                                //show snackbar logout success
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Logout Successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                          ),
                          title: Text('Logout'),
                          tileColor: Color(0xFFBD8456),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              )),
                          title: Text('Login'),
                          tileColor: Color(0xFFBD8456),
                        ),
                      )
              ],
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: product.filterC,
              decoration: InputDecoration(
                labelText: "Search Here!",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "All Categories",
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/cakes.png',
                          height: 30,
                        ),
                        Text('Cakes'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/cupcakes.png',
                          height: 30,
                        ),
                        Text('Cakes'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/brownis.png',
                          height: 30,
                        ),
                        Text('Brownis'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommendation Product",
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  icon: Icon(isGridView ? Icons.grid_view : Icons.list),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Product().productStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var listAllDocs = snapshot.data!.docs;
                  // print(listAllDocs[0].data() as Map<String, dynamic>);
                  return Expanded(
                    child: isGridView
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: listAllDocs.length,
                            itemBuilder: (context, index) {
                              return BuildCard(
                                productData: listAllDocs[index].data()
                                    as Map<String, dynamic>,
                                productID: listAllDocs[index].id,
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: listAllDocs.length,
                            itemBuilder: (context, index) {
                              return BuildCard(
                                productData: listAllDocs[index].data()
                                    as Map<String, dynamic>,
                                productID: listAllDocs[index].id,
                              );
                            },
                          ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text('No Data');
              },
            )
          ],
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  final Map<String, dynamic> productData;
  final String productID;
  const BuildCard(
      {super.key, required this.productData, required this.productID});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat.decimalPattern('id');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              productID: productID,
            ),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.network(productData['image']),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  productData['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rp ${formatter.format(productData['price'])}',
                style: TextStyle(color: Color(0xFFBD8456)),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
