import 'package:flutter/material.dart';
import 'package:mea/view/all/dashboar.dart';

class Tentangaplikasi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFFFF6F00),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 56,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
Container(
  height: 27,
  width: 27,
  child: GestureDetector(
    onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => dashboard(), // Navigasi ke dashboard
        ),
      );
    },
    child: Icon(
      Icons.keyboard_backspace_rounded,
      color: Colors.white,
    ),
  ),
),
                
              ],
            ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 560,
              width: 357,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                    height: 10,
                  ),
                  Center(child: Text("Tentang Aplikasi", style: TextStyle(fontWeight: FontWeight.bold),),)
                  ,SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 271,
                    height: 162,
                    child: Text("MEA (Marapi Emergency Alert) adalah aplikasi yang dirancang khusus untuk memberikan informasi dan layanan pelaporan terkait erupsi Gunung Marapi. Aplikasi ini bertujuan untuk meningkatkan kesiapsiagaan dan keselamatan masyarakat yang tinggal di sekitar area berisiko, serta memfasilitasi komunikasi antara warga dan pihak berwenang.",textAlign: TextAlign.center,),
                  )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: Image.asset('assets/images/BPBD.png'),
                        ),
                        
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}