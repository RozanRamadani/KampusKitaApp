import 'dart:io';

class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;

  // Constructor menggunakan named parameters
  Mahasiswa({this.nama, this.nim, this.jurusan});

  void tampilkanData() {
    print("Nama: ${nama ?? 'Belum diisi'}");
    print("NIM: ${nim ?? 'Belum diisi'}");
    print("Jurusan: ${jurusan ?? 'Belum diisi'}");
  }
}

void main() {
  print("--- Output Mahasiswa ---");
  MahasiswaAktif aktif = MahasiswaAktif("Rozan", 25345, "TI");
  aktif.infoAktif();

  MahasiswaAlumni alumni = MahasiswaAlumni("Budi", 5325, 1990);
  alumni.infoAlumni();

  print("\n--- Output Mixin Dosen ---");
  Dosen dosen = Dosen("Dr. Eko", 19850101);
  dosen.tampilkanData();
  dosen.mengajar();
  dosen.meneliti();

  print("\n--- Output Mixin Fakultas ---");
  Fakultas ft = Fakultas("Teknik Informatika", 101);
  ft.tampilkanData();
  ft.administrasi();
}

class MahasiswaAktif extends Mahasiswa {
  MahasiswaAktif(String nama, int nim, String jurusan)
      : super(nama: nama, nim: nim, jurusan: jurusan);

  void infoAktif() {
    print("Mahasiswa $nama (NIM: $nim) adalah mahasiswa aktif jurusan $jurusan");
  }
}

class MahasiswaAlumni extends Mahasiswa {
  int tahunLulus;

  MahasiswaAlumni(String nama, int nim, this.tahunLulus)
      : super(nama: nama, nim: nim);

  void infoAlumni() {
    print("Alumni $nama (NIM: $nim) lulus tahun $tahunLulus");
  }
}

// --- 3 Mixins ---
mixin Mengajar {
  void mengajar() {
    print("Aksi: Sedang mengajar di kelas.");
  }
}

mixin Penelitian {
  void meneliti() {
    print("Aksi: Sedang melakukan penelitian.");
  }
}

mixin Administrasi {
  void administrasi() {
    print("Aksi: Mengurus administrasi fakultas.");
  }
}

// class Dosen
class Dosen extends Mahasiswa with Mengajar, Penelitian {
  Dosen(String nama, int nip) : super(nama: nama, nim: nip);

  @override
  void tampilkanData() {
    print("Nama Dosen: $nama");
    print("NIP: $nim");
  }
}

// class Fakultas
class Fakultas extends Mahasiswa with Administrasi {
  Fakultas(String nama, int nim) : super(nama: nama, nim: nim);
}
