import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healwiz/Screens/form_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cliente> listaClientes = [];
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

        List<DocumentSnapshot> documentos = clientesQuery.docs;
        List<Cliente> documentosClientes = documentos.map((doc) {
          // Aquí conviertes cada documento en un objeto Cliente
          var data = doc.data(); // Obtén los datos del documento
          return Cliente(
            nombre: (data as Map<String, dynamic>)['nombre'] ?? '',
            contacto: (data)['contacto'] ?? '',
            descripcion: (data)['descripcion'] ?? '',
            direccion: (data)['direccion'] ?? '',
            ordenIndex: (data)['ordenIndex'] ?? 0,
          );
        }).toList();
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
              // Cuadro de busqueda
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.teal[400],
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // ...
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Escriba aquí...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormClient()));
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listaClientes.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  heightFactor: 3,
                  child: Text(
                    listaClientes[index].nombre,
                    style: const TextStyle(
                      fontSize: 18, // Tamaño de fuente
                      fontWeight: FontWeight.bold, // Peso de la fuente
                      // Otros estilos que desees aplicar
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Cliente {
  String nombre;
  String contacto;
  String descripcion;
  String direccion;
  int ordenIndex;

  Cliente({
    required this.nombre,
    required this.contacto,
    required this.descripcion,
    required this.direccion,
    required this.ordenIndex,
  });
}
