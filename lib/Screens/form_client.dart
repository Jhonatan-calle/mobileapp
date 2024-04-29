import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormClient extends StatefulWidget {
  const FormClient({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FormClientSate createState() => _FormClientSate();
}

class _FormClientSate extends State<FormClient> {
  final _formKey = GlobalKey<FormState>();

  

  String _name = '';
  String _contacto = '';
  String _notas = '';
  String _direccion = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Nuevo cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contacto'),
                onSaved: (value) {
                  _contacto = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dirección'),
                onSaved: (value) {
                  _direccion = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notas'),
                maxLines: 3,
                onSaved: (value) {
                  _notas = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final db = FirebaseFirestore.instance;
                  User? user = FirebaseAuth.instance.currentUser;
                  if (_formKey.currentState!.validate() && user != null) {
                    _formKey.currentState!.save();
                    // Aquí puedes enviar los datos a donde los necesites
                    // Por ejemplo, puedes imprimirlos en la consola
                    db.collection('users').doc(user.uid).collection('clientes').add({})
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
