import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '210001',
        email: 'budi@student.com',
        angkatan: '2021',
      ),
      MahasiswaModel(
        nama: 'Siti Aminah',
        nim: '210002',
        email: 'siti@student.com',
        angkatan: '2021',
      ),
      MahasiswaModel(
        nama: 'Andi Wijaya',
        nim: '220001',
        email: 'andi@student.com',
        angkatan: '2022',
      ),
    ];
  }
}
