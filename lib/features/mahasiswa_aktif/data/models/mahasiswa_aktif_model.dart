class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String status;
  final String semester;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.status,
    required this.semester,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      status: json['status'] ?? '',
      semester: json['semester'] ?? '',
    );
  }
}
