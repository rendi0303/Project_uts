import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  // Fungsi umum untuk membuka URL (telepon, WhatsApp, peta, dll)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Tidak dapat membuka URL: $url');
    }
  }

  // 🔹 Fungsi untuk membuka Google Maps
  Future<void> _openGoogleMaps() async {
    // Ganti koordinat di sini dengan lokasi dealer kamu yang sebenarnya
    const double latitude = -6.917464; // Koordinat Bandung
    const double longitude = 107.619123;

    final Uri mapUri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Tidak dapat membuka Google Maps.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kontak Dealer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade700,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 📍 Lokasi coffe
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.red),
                title: const Text('coffe shop house'),
                subtitle: const Text('Jl. Cicalengka no 03 '),
                trailing: IconButton(
                  icon: const Icon(Icons.map, color: Colors.blueAccent),
                  onPressed: _openGoogleMaps,
                  tooltip: 'Lihat di Google Maps',
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 📞 Nomor Telepon
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                onTap: () => _launchURL('tel:+112334556778'),
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text('Telepon'),
                subtitle: const Text('11233455667'),
                trailing: const Icon(Icons.call, color: Colors.green),
              ),
            ),
            const SizedBox(height: 12),

            // 💬 WhatsApp
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                onTap: () => _launchURL('https://wa.me/112223445667'),
                leading: const FaIcon(FontAwesomeIcons.whatsapp,
                    color: Colors.green),
                title: const Text('WhatsApp'),
                subtitle: const Text('112334556778'),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 25),

            // 🗺️ Tombol besar untuk buka peta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _openGoogleMaps,
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text(
                  'Lihat Lokasi di Google Maps',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🟥 Tombol Hubungi Dealer via WhatsApp
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => _launchURL('https://wa.me/1028334556776'),
                icon: const FaIcon(FontAwesomeIcons.whatsapp,
                    color: Colors.white),
                label: const Text(
                  'Hubungi admin Sekarang',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
