import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: addUser(),
    );
  }
}

class User {
  String name;
  int age;
  String id;

  User({required this.name, required this.age, this.id = ""});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}

// ignore: camel_case_types
class addUser extends StatefulWidget {
  const addUser({Key? key}) : super(key: key);

  @override
  State<addUser> createState() => _addUserState();
}

// ignore: camel_case_types
class _addUserState extends State<addUser> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add User'),
          automaticallyImplyLeading: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: decoration('Name'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerAge,
              decoration: decoration('Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final user = User(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                );
                createUser(user);
                Navigator.pop(context);
              },
              child: const Text('Create'),
            )
          ],
        ),
      );

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      );

  Future<void> createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }
}
