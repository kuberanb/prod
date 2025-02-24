import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic>? userDetails;
  
  const HomeScreen({
    super.key,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome ${userDetails?['firstName'] ?? ''} ${userDetails?['lastName'] ?? ''}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text('Email: ${userDetails?['email'] ?? ''}'),
            Text('Username: ${userDetails?['username'] ?? ''}'),
            Text('Gender: ${userDetails?['gender'] ?? ''}'),
            if (userDetails?['image'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.network(
                  userDetails!['image'],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
