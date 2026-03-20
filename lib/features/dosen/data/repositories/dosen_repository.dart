import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../models/dosen_model.dart';

class DosenRepository {
  final Dio _dio = Dio();

  /// Mendapatkan daftar dosen menggunakan HTTP
  Future<List<DosenModel>> getDosenListHttp() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data dosen: ${response.statusCode}');
    }
  }

  /// Mendapatkan daftar dosen menggunakan Dio (Tugas No 7)
  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dosen: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal memuat data dosen');
    }
  }
}
