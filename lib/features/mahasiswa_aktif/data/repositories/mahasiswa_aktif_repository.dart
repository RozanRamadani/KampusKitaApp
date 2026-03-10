import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      MahasiswaAktifModel(
        nama: 'Rozan Aiman',
        nim: '210003',
        status: 'Aktif',
        semester: '4',
      ),
      MahasiswaAktifModel(
        nama: 'Dewi Lestari',
        nim: '210004',
        status: 'Aktif',
        semester: '5',
      ),
      MahasiswaAktifModel(
        nama: 'Fajar Nugraha',
        nim: '220002',
        status: 'Aktif',
        semester: '3',
      ),
    ];
  }
}
