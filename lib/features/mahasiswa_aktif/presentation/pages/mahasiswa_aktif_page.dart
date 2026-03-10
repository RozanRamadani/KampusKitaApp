import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/mahasiswa_aktif_provider.dart';
import '../widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif', 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
        ),
        elevation: 0,
        // Disesuaikan agar konsisten dengan tema halaman lain (menggunakan warna primer tema)
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (e, st) => CustomErrorWidget(
          message: e.toString(),
          onRetry: () => ref.read(mahasiswaAktifNotifierProvider.notifier).loadMahasiswaAktif(),
        ),
        data: (list) => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return MahasiswaAktifCard(
              mahasiswa: list[index],
              gradientColors: AppConstants.dashboardGradients[index % AppConstants.dashboardGradients.length],
            );
          },
        ),
      ),
    );
  }
}
