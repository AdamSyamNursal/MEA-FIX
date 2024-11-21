import 'package:flutter/material.dart';

class RekomendasiText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1. Masyarakat di sekitar G. Marapi dan pendaki/pengunjung/wisatawan agar tidak memasuki dan tidak melakukan kegiatan di dalam wilayah radius 4.5 km dari pusat erupsi (Kawah Verbeek) G. Marapi.",
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          SizedBox(height: 10),
          Text(
            "2. Masyarakat yang bermukim di sekitar lembah/aliran/bantaran sungai-sungai yang berhulu di puncak G. Marapi agar selalu mewaspadai potensi ancaman bahaya lahar yang dapat terjadi terutama di saat musim hujan.",
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          SizedBox(height: 10),
          Text(
            "3. Jika terjadi hujan abu maka masyarakat diimbau untuk menggunakan masker penutup hidung dan mulut untuk menghindari gangguan saluran pernapasan (ISPA), serta perlengkapan lain untuk melindungi mata dan kulit. Selain itu agar mengamankan sarana air bersih serta membersihkan atap rumah dari abu vulkanik yang tebal agar tidak roboh.",
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          SizedBox(height: 10),
          Text(
            "4. Seluruh pihak agar menjaga kondusivitas suasana di masyarakat, tidak menyebarkan narasi bohong (hoax), dan tidak terpancing isu-isu yang tidak jelas sumbernya. Masyarakat harap selalu mengikuti arahan dari Pemerintah Daerah.",
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          SizedBox(height: 10),
          Text(
            "5. Pemerintah Daerah Kota Bukit Tinggi, Kota Padang Panjang, Kabupaten Tanah Datar, dan Kabupaten Agam agar senantiasa berkoordinasi dengan Pusat Vulkanologi dan Mitigasi Bencana Geologi di Bandung atau dengan Pos Pengamatan G. Marapi di Jl. Prof. Hazairin No.168 Bukit Tinggi untuk mendapatkan informasi langsung tentang aktivitas G. Marapi.",
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          SizedBox(height: 10),
          Text(
            "6. Masyarakat, instansi pemerintah, maupun instansi terkait lainnya dapat memantau perkembangan aktivitas maupun rekomendasi G. Marapi melalui aplikasi android Magma Indonesia, website Magma Indonesia (www.vsi.esdm.go.id atau https://magma.esdm.go.id), dan media sosial PVMBG (facebook, twitter, dan instagram).",
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
        ],
      ),
    );
  }
}
