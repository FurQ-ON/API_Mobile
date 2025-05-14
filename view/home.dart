import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/mahasiswa.dart';
import './crud.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    refreshdatamhs();
    super.initState();
  }

  List _mahasiswa = [];
  void refreshdatamhs() async {
    final hasil = await http.get(Uri.parse("http://localhost/iwima/list.php"));

    print(hasil.statusCode);
    print(hasil.body);
    setState(() {
      _mahasiswa = json.decode(hasil.body);
    });
  }

  void hapusdatamhs(String nim) async {
    await http.post(
      Uri.parse("http://localhost/iwima/delete.php"),
      body: {
        'nim': nim,
      },
    );
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confhapusdatamhs(String nim) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Apakah adan yakin akan menghapus data ini?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Icon(Icons.cancel),
            ),
            ElevatedButton(
              onPressed: () => hapusdatamhs(nim),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Mahasiswa API MYSQL')),
      body: ListView.builder(
          itemCount: _mahasiswa.length,
          itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_mahasiswa[index]['nim']),
                  subtitle: Text(
                      '${_mahasiswa[index]['nama']} - ${_mahasiswa[index]['progdi']}'),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) =>
                                      CRUD(datamhs: _mahasiswa[index]),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              confhapusdatamhs(_mahasiswa[index]['nim']);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => CRUD(datamhs: null),
            ),
          );
        },
      ),
    );
  }
}
