import 'package:fgd_2/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: auth.emailC,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Email...',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: auth.passwordC,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password...',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFBD8456),
                minimumSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                auth
                    .loginUser(
                  auth.emailC.text,
                  auth.passwordC.text,
                )
                    .then(
                  (value) {
                    if (value) {
                      //clear text field
                      auth.emailC.clear();
                      auth.passwordC.clear();
                      //navigate to home screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                      //show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login Successfully'),
                        ),
                      );
                    } else {
                      //show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login Failed'),
                        ),
                      );
                    }
                  },
                );
              },
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            //dont have account
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen();
                    },
                  ),
                );
              },
              child: Text(
                'Don\'t have account? Register here',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
