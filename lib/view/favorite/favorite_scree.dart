import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          
            'Category',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700]),
          ),
      ),
    );
  }
}