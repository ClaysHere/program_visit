import 'package:flutter/material.dart';
import 'package:program_visit/features/admin/view/home_view.dart';
import 'package:program_visit/common/styles/font.dart';
import 'package:program_visit/common/widgets/custom_text_style.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeView(), HomeView()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(child: _pages.elementAt(_selectedIndex)),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        // Warna latar belakang FAB sesuai gambar (ungu)
        backgroundColor: const Color(
          0xFF9E7DE8,
        ), // Warna ungu yang mendekati gambar
        onPressed: () {
          // Logika untuk tombol FAB tengah (ikon kamera)
          // ignore: avoid_print
          print('Tombol kamera ditekan!');
          // Contoh: Membuka FormPendaftaranUser sebagai halaman baru
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormPendaftaranUser()));
        },
        child: const Icon(Icons.camera_alt, color: Colors.white), // Ikon kamera
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // Membuat lekukan untuk FAB
        notchMargin: 8.0, // Jarak antara FAB dan AppBar
        color: Colors.white, // Warna latar belakang BottomAppBar
        surfaceTintColor:
            Colors
                .white, // Memastikan tidak ada pewarnaan pada latar belakang putih
        elevation: 5.0, // Menambah sedikit bayangan
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Item kiri (sesuai gambar)
            _buildNavItem(0, 'Home', Icons.home),
            _buildNavItem(1, 'Home', Icons.home), // Item Home kedua
            // Spasi di tengah untuk FAB
            const SizedBox(
              width: 48,
            ), // Spasi untuk mencegah tumpang tindih dengan FAB
            // Item kanan (sesuai gambar)
            _buildNavItem(3, 'Profile', Icons.person), // Item Profile pertama
            _buildNavItem(4, 'Profile', Icons.person), // Item Profile kedua
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    bool isSelected = _selectedIndex == index;
    // Warna item yang dipilih adalah ungu terang sesuai gambar
    final Color selectedColor = const Color(0xFF9E7DE8);
    // Warna item yang tidak dipilih adalah abu-abu muda
    final Color unselectedColor = Colors.grey[400]!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onItemTapped(index),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                color: isSelected ? selectedColor : unselectedColor,
                size: 28, // Ukuran ikon agar terlihat lebih besar
              ),
              CustomTextStyle(
                text: label,
                fontSize: 12,
                fontWeight:
                    AppFontWeight.regular, // Font weight reguler sesuai gambar
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
