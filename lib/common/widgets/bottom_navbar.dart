import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Perbarui indeks yang dipilih berdasarkan lokasi GoRouter saat ini
    // Memastikan tab yang benar disorot saat BottomNavbar pertama kali dibangun
    final String location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    if (location == '/') {
      _selectedIndex = 0;
    } else if (location == '/pendaftaran-user') {
      _selectedIndex = 1;
    } else if (location == '/jadwal') {
      _selectedIndex = 2;
    } else if (location == '/akun') {
      _selectedIndex = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      selectedFontSize: 15,
      unselectedFontSize: 15,
      iconSize: 25,
      selectedLabelStyle: const TextStyle(fontFamily: "Poppins", fontSize: 15),
      unselectedLabelStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 15,
      ),
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        // Gunakan GoRouter untuk navigasi
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/pendaftaran-user');
            break;
          case 2:
            context.go('/jadwal');
            break;
          case 3:
            context.go('/akun');
            break;
          default:
            break;
        }
      },

      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/icons/home-nav.png", width: 20, height: 20),
          label: "Home",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Tambah"),
        BottomNavigationBarItem(
          icon: Image.asset("assets/icons/date.png", width: 20, height: 20),
          label: "Jadwal",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/icons/akun.png", width: 20, height: 20),
          label: "Akun",
        ),
      ],
    );
  }
}
