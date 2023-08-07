import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



// ignore: camel_case_types
class showUsers extends StatefulWidget {
  const showUsers({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _showUsersState createState() => _showUsersState();
}

// ignore: camel_case_types
class _showUsersState extends State<showUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Show Users'),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final name = userData['name'];
              final age = userData['age'];

              return ListTile(
                title: Text('Name: $name'),
                subtitle: Text('Age: $age'),
              );
            },
          );
        },
      ),
    );
  }
}
