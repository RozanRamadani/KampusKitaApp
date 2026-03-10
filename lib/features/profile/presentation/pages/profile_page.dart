import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil Pengguna', 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Profile
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: AppConstants.dashboardGradients[0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppConstants.dashboardGradients[0][0].withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('AD', 
                        style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Admin D4TI', 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
            ),
            const Text('Administrator Sistem', 
              style: TextStyle(color: Colors.grey, fontSize: 14)
            ),
            const SizedBox(height: 32),
            
            // Detail Information Sections
            _buildProfileItem(Icons.email_outlined, 'Email', 'admin.d4ti@vokasi.ac.id'),
            _buildProfileItem(Icons.phone_outlined, 'Telepon', '+62 812 3456 7890'),
            _buildProfileItem(Icons.location_on_outlined, 'Instansi', 'Universitas Airlangga'),
            const Divider(indent: 70, endIndent: 20),
            _buildProfileItem(Icons.settings_outlined, 'Pengaturan Akun', 'Privasi, Keamanan'),
            _buildProfileItem(Icons.help_outline_rounded, 'Bantuan', 'Pusat Bantuan, FAQ'),
            
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Keluar Aplikasi', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: Colors.blueGrey, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: () {},
    );
  }
}
