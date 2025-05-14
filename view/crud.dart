import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/mahasiswa.dart';

class CRUD extends StatefulWidget {
  final Map? datamhs;

  CRUD({Key? key, required this.datamhs})
      : super(key: key); // Jika null safety aktif

  @override
  CRUDState createState() => CRUDState();
}

class CRUDState extends State<CRUD> {
  String status = "";
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController progdiController = TextEditingController();

  // Menambahkan data tabel
  Future tambahmhs() async {
    return await http.post(
      Uri.parse("http://localhost/iwima/create.php"),
      body: {
        "nim": nimController.text,
        "nama": namaController.text,
        "progdi": progdiController.text,
      },
    );
  }

  // Update data tabel
  Future ubahmhs() async {
    return await http.post(
      Uri.parse("http://localhost/iwima/update.php"),
      body: {
        "nim": widget.datamhs!['nim'],
        "nama": namaController.text,
        "progdi": progdiController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.datamhs != null) {
      status = "Ubah Data Mahasiswa";
      nimController.text = widget.datamhs!['nim'];
      namaController.text = widget.datamhs!['nama'];
      progdiController.text = widget.datamhs!['progdi'];
    } else {
      status = "Tambah Data Mahasiswa";
      nimController.text = "";
      namaController.text = "";
      progdiController.text = "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(status),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: nimController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'nim'),
                ),
                TextFormField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: progdiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Progdi'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (widget.datamhs == null) {
                      await tambahmhs();
                    } else {
                      await ubahmhs();
                    }
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                  child: Text(widget.datamhs == null ? 'Tambah' : 'Ubah'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
