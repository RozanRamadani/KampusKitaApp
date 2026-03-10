import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_aktif_model.dart';
import '../../data/repositories/mahasiswa_aktif_repository.dart';

final mahasiswaAktifRepositoryProvider = Provider((ref) => MahasiswaAktifRepository());

final mahasiswaAktifNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaAktifNotifier, AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  return MahasiswaAktifNotifier(ref.watch(mahasiswaAktifRepositoryProvider));
});

class MahasiswaAktifNotifier extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repository;
  MahasiswaAktifNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadMahasiswaAktif();
  }

  Future<void> loadMahasiswaAktif() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
