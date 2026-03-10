import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (e, st) => CustomErrorWidget(
          message: e.toString(),
          onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).loadMahasiswa(),
        ),
        data: (list) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return MahasiswaCard(
              mahasiswa: list[index],
              gradientColors: AppConstants.dashboardGradients[index % AppConstants.dashboardGradients.length],
            );
          },
        ),
      ),
    );
  }
}
