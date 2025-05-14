import 'package:flutter/material.dart';

class Mahasiswa {
  String? nim;
  String? nama;
  String? progdi;
  Mahasiswa({this.nim, this.nama, this.progdi});
  factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        nim: json['nim'],
        nama: json['nama'],
        progdi: json['progdi'],
      );
  Map<String, dynamic> toJson() => {
        'nim': nim,
        'nama': nama,
        'progdi': progdi,
      };
}
