import 'dart:io';

import 'package:fgd_2/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

import 'providers/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _imageFile != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(_imageFile!),
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
              SizedBox(height: 16),
              TextField(
                controller: auth.nameC,
                decoration: InputDecoration(
                  labelText: 'Display Name',
                  hintText: 'Display Name...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: auth.emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: auth.passwordC,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password...',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  auth.uploadImage(_imageFile!.path, _fileName).then(
                    (value) {
                      auth
                          .registerUser(auth.emailC.text, auth.passwordC.text,
                              auth.nameC.text, value)
                          .then(
                        (value) {
                          if (value) {
                            //clear text field
                            auth.emailC.clear();
                            auth.passwordC.clear();
                            auth.nameC.clear();
                            //pop screen
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                            //show snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Register Successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            //show snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Register Failed'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFBD8456),
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
