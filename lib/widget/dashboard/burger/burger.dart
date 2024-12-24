import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/widget/dashboard/burger/burger_animation.dart';

class BurgerController extends GetxController with GetSingleTickerProviderStateMixin {
  OverlayEntry? overlayEntry;
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void showSidebar(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: closeSidebar,
            child: Container(
              color: Colors.black54,
            ),
          ),
          SlideTransition(
            position: slideAnimation,
            child: Sidebar(onClose: closeSidebar),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(overlayEntry!);
    controller.forward();
  }

  void closeSidebar() {
    controller.reverse().then((_) {
      overlayEntry?.remove();
      overlayEntry = null;
    });
  }
}

class Burger extends StatelessWidget {
  const Burger({super.key});

  @override
  Widget build(BuildContext context) {
    final BurgerController controller = Get.put(BurgerController());

    return SizedBox(
      height: 21,
      width: 23,
      child: GestureDetector(
        onTap: () => controller.showSidebar(context),
        child: Image.asset('assets/icons/burger.png'),
      ),
    );
  }
}
