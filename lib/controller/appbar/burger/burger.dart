import 'package:flutter/material.dart';
import 'package:mea/controller/appbar/burger/burger_animation.dart';

class burger extends StatefulWidget {
  @override
  _burgerState createState() => _burgerState();
}

class _burgerState extends State<burger> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1), // Mulai dari luar layar atas
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showSidebar() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _closeSidebar,
            child: Container(
              color: Colors.black54, // Background semi-transparan
            ),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Sidebar(onClose: _closeSidebar),
          ),
        ],
      ),
    );
    Overlay.of(context)!.insert(_overlayEntry!);
    _controller.forward();
  }

  void _closeSidebar() {
    _controller.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      width: 23,
      child: GestureDetector(
        onTap: _showSidebar,
        child: Image.asset('assets/icons/burger.png'),
      ),
    );
  }
}
