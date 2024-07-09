import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //auth provider
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Consumer<Auth>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      Image.network(value.user.photoURL ?? '').image,
                ),
                SizedBox(height: 16),
                Text(
                  value.user.displayName!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  value.userRole,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(value.user.email!),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(value.user.phoneNumber ?? 'No Phone Number'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
