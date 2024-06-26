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
  List<Cliente> listaFiltrada = [];
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    textController.addListener(_filterClients);
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
            listaFiltrada = documentosClientes;
          });
        }
      } catch (e) {
        print('Error loading user data: $e');
      }
    }
  }

  void _filterClients() {
    String query = textController.text.toLowerCase();
    setState(() {
      listaFiltrada = listaClientes.where((cliente) {
        return cliente.nombre.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Cuadro de busqueda
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // ...busqueda cliente por nombre o dni
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: textController, //aqui
                      decoration: InputDecoration(
                        hintText: 'Escriba aquí...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormClient()));
                      _loadUserData();
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
          //lista de clientes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listaFiltrada.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: ListTile(
                      title: Text(
                    listaFiltrada[index].nombre,
                    style: const TextStyle(
                      fontSize: 18, // Tamaño de fuente
                      fontWeight: FontWeight.bold, // Peso de la fuente
                      // Otros estilos que desees aplicar
                    ),
                  )),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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
