import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final String text = '3CGFnoQ6ISf6Huuu7wyC';
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  final Stream<QuerySnapshot> _ordersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _ordersStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("что то пошло не так"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Загрузка'),
          );
        }
        orders.get();
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['phone_number']),
              subtitle: Text('asd'),
            );
          }).toList(),
        );
      },
    );
  }
}
