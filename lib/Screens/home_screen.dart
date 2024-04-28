import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> listaClientes = [];
    TextEditingController text = TextEditingController();


  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Get the user document from Firestore
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        QuerySnapshot clientesQuery =
            await userRef.collection('clientes').get();

        List<Map<String, String>> documentosClientes = clientesQuery.docs
            .map((doc) => (doc.data() as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, value.toString())))
            .toList();

        // Check if the widget is still mounted before updating the state
        if (mounted) {
          // Get the user's name field from the document
          setState(() {
            listaClientes = documentosClientes;
          });
        }
      } catch (e) {
        print('Error loading user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(1, 6), // Shadow position
                  ),
                ],
              ),
              child:   const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    // color: Colors.black,
                    size: 30,
                  ),
                  Expanded(
                    child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escriba aquí...',
                      border: InputBorder.none
                    ),
                  ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
