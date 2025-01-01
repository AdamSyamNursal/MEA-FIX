import 'package:flutter/material.dart';
import 'package:mea/view/all/dashboar.dart';

class Tentangaplikasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFF6F00),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // App Bar Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => dashboard(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Content Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: const [
                          Text(
                            "Tentang Aplikasi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "MEA (Marapi Emergency Alert) adalah aplikasi yang dirancang khusus untuk memberikan informasi dan layanan pelaporan terkait erupsi Gunung Marapi. Aplikasi ini bertujuan untuk meningkatkan kesiapsiagaan dan keselamatan masyarakat yang tinggal di sekitar area berisiko, serta memfasilitasi komunikasi antara warga dan pihak berwenang.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Logo Section
                      Image.asset(
                        'assets/images/BPBD.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
