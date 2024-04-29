
import 'package:flutter/material.dart';

class CuentasScreen extends StatefulWidget {
  const CuentasScreen({Key ? key}) : super(key: key);

  @override 
  State<CuentasScreen> createState() => _CuentasScreenState();
}

class _CuentasScreenState extends State<CuentasScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Cuentas'),
      )

    );
  }
}