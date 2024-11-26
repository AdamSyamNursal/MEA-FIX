import 'package:get/get.dart';

class BurgerController extends GetxController {
  // State untuk menu
  var isMenuOpen = false.obs;

  // Fungsi untuk membuka menu
  void openMenu() {
    isMenuOpen.value = true;
  }

  // Fungsi untuk menutup menu
  void closeMenu() {
    isMenuOpen.value = false;
  }

  // Fungsi toggle menu (buka/tutup)
  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }
}
