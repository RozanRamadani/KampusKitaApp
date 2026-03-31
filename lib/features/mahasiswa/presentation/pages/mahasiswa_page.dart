import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d4tivokasi/core/widgets/widgets.dart';
import 'package:d4tivokasi/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:d4tivokasi/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:d4tivokasi/features/dosen/presentation/providers/dosen_provider.dart'; // Import provider yang sudah ada

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mhsState = ref.watch(mahasiswaNotifierProvider);
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // — Section: Data Tersimpan di SharedPreferences —
          _SavedMahasiswaSection(savedUsers: savedUsers),

          // — Section Title: Daftar Mahasiswa —
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa (API)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          // — Mahasiswa List dari API —
          Expanded(
            child: mhsState.when(
              loading: () => const LoadingWidget(),
              error: (err, stack) => CustomErrorWidget(
                message: 'Gagal memuat data: ${err.toString()}',
                onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
              ),
              data: (mhsList) => _MahasiswaListWithSave(
                mhsList: mhsList,
                onRefresh: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// — Widget: Section data SharedPreferences (Identik dengan Dosen) —
class _SavedMahasiswaSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;

  const _SavedMahasiswaSection({required this.savedUsers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Data Tersimpan di Local Storage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              savedUsers.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton.icon(
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).clearAllSavedMahasiswa();
                          ref.invalidate(savedUsersProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Semua data dihapus')),
                            );
                          }
                        },
                        icon: const Icon(Icons.delete_sweep, size: 14, color: Colors.red),
                        label: const Text('Hapus Semua', style: TextStyle(fontSize: 12, color: Colors.red)),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          savedUsers.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text('Gagal membaca data', style: TextStyle(color: Colors.red, fontSize: 12)),
            data: (users) {
              if (users.isEmpty) {
                return _buildEmptyBox();
              }
              return _buildSavedList(users, ref, context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Text(
        'Belum ada mahasiswa yang disimpan.',
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  Widget _buildSavedList(List<Map<String, String>> users, WidgetRef ref, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 12, endIndent: 12),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            dense: true,
            leading: const Icon(Icons.person_pin, size: 20, color: Colors.blue),
            title: Text(user['username'] ?? '-'),
            subtitle: Text('ID: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}', style: const TextStyle(fontSize: 11)),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 16, color: Colors.red),
              onPressed: () async {
                await ref.read(mahasiswaNotifierProvider.notifier).removeSavedMahasiswa(user['user_id'] ?? '');
                ref.invalidate(savedUsersProvider);
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '-';
    try {
      final date = DateTime.parse(isoString);
      return '${date.day}/${date.month} ${date.hour}:${date.minute}';
    } catch (e) { return isoString; }
  }
}

// — Widget: List Mahasiswa dari API —
class _MahasiswaListWithSave extends ConsumerWidget {
  final List<MahasiswaModel> mhsList;
  final VoidCallback onRefresh;

  const _MahasiswaListWithSave({required this.mhsList, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: mhsList.length,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        itemBuilder: (context, index) {
          final mhs = mhsList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${mhs.id}')),
              title: Text(mhs.name),
              subtitle: Text('${mhs.email}\n${mhs.phone}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save_rounded, color: Colors.blue),
                onPressed: () async {
                  await ref.read(mahasiswaNotifierProvider.notifier).saveMahasiswa(mhs);
                  ref.invalidate(savedUsersProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${mhs.username} disimpan ke local storage')),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
