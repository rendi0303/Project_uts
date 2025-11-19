import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ======================================================
//  MODEL
// ======================================================
class CoffeModel {
  final String id;
  final String name;
  final String image;
  final String price;
  final String short;
  final String? desc;

  CoffeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.short,
    this.desc,
  });
}

// ======================================================
//  COFFEE CARD — Premium Look
// ======================================================
class CoffeCard extends StatelessWidget {
  final CoffeModel shop;
  final VoidCallback onTap;

  const CoffeCard({super.key, required this.shop, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  shop.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Calibri',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shop.price,
                      style: TextStyle(
                        color: Colors.brown.shade700,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Calibri',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
//  HEADER BANNER — Premium Gradient Coffee
// ======================================================
class HeaderBanner extends StatelessWidget {
  const HeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade800,
            Colors.brown.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 15,
            bottom: 10,
            child: Icon(
              Icons.coffee,
              size: 80,
              color: Colors.white.withOpacity(0.25),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Temukan Kopi Terbaik\nUntuk Hari Terbaikmu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
//  MARKETING CARD — Icon + Teks
// ======================================================
class MarketingCard extends StatelessWidget {
  const MarketingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.local_cafe, size: 42, color: Colors.brown.shade700),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "Promo spesial! Dapatkan diskon 20% untuk semua menu espresso.",
              style: TextStyle(
                color: Colors.brown.shade700,
                fontSize: 15,
                fontFamily: 'Calibri',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
//  EXTRA PAGES
// ======================================================
class PromoPage extends StatelessWidget {
  const PromoPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Promo', style: TextStyle(fontFamily: 'Calibri')),
          backgroundColor: Colors.brown.shade700,
        ),
      );
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Kontak', style: TextStyle(fontFamily: 'Calibri')),
          backgroundColor: Colors.brown.shade700,
        ),
      );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Profil', style: TextStyle(fontFamily: 'Calibri')),
          backgroundColor: Colors.brown.shade700,
        ),
      );
}

// ======================================================
//  COFFEE PAGE
// ======================================================
class CoffePage extends StatelessWidget {
  final CoffeModel? detail;
  final List<CoffeModel>? allCoffes;

  const CoffePage({super.key, this.detail, this.allCoffes});

  Future<void> _openMap(BuildContext context) async {
    const latitude = "-6.200000";
    const longitude = "106.816666";
    final mapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak bisa membuka Google Maps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (detail == null && allCoffes != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Coffee', style: TextStyle(fontFamily: 'Calibri')),
          backgroundColor: Colors.brown.shade700,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: allCoffes!.length,
          itemBuilder: (_, i) => CoffeCard(
            shop: allCoffes![i],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CoffePage(detail: allCoffes![i]),
              ),
            ),
          ),
        ),
      );
    }

    final coffee = detail!;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(coffee.name,
            style: const TextStyle(fontFamily: 'Calibri')),
        backgroundColor: Colors.brown.shade700,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.asset(
                coffee.image,
                height: 270,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffee.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Calibri',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    coffee.price,
                    style: TextStyle(
                      color: Colors.brown.shade700,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Calibri',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    coffee.desc ?? coffee.short,
                    style:
                        const TextStyle(fontSize: 16, fontFamily: 'Calibri'),
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: () => _openMap(context),
                    icon: const Icon(Icons.location_on),
                    label: const Text("Lihat Lokasi",
                        style: TextStyle(fontFamily: 'Calibri')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade700,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Pesan Sekarang",
                        style: TextStyle(fontFamily: 'Calibri')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade800,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
//  HOME PAGE (SHADOW + FAKE CALIBRI)
// ======================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CoffeModel> coffees = [
    CoffeModel(
        id: 'coffe',
        name: 'espresso',
        image: 'assets/images/espresso.jpeg',
        price: 'Rp 85.000',
        short: 'Kopi kuat'),
    CoffeModel(
        id: 'coffe',
        name: 'macchiato',
        image: 'assets/images/macchiato.jpeg',
        price: 'Rp 18.000',
        short: 'Kopi lembut'),
    CoffeModel(
        id: 'coffe',
        name: 'lungo',
        image: 'assets/images/lungo.jpeg',
        price: 'Rp 32.000',
        short: 'Kopi manis'),
    CoffeModel(
        id: 'coffe',
        name: 'viena',
        image: 'assets/images/viena.jpeg',
        price: 'Rp 28.000',
        short: 'Kopi klasik'),
    CoffeModel(
        id: 'coffe',
        name: 'capuccino',
        image: 'assets/images/capuccino.jpeg',
        price: 'Rp 20.000',
        short: 'Kopi klasik'),
    CoffeModel(
        id: 'coffe',
        name: 'latte',
        image: 'assets/images/latte.jpeg',
        price: 'Rp 15.000',
        short: 'Kopi klasik'),
    CoffeModel(
        id: 'coffe',
        name: 'americano',
        image: 'assets/images/americano.jpeg',
        price: 'Rp 30.000',
        short: 'Kopi legit'),
    CoffeModel(
        id: 'coffe',
        name: 'mocha',
        image: 'assets/images/mocha.jpeg',
        price: 'Rp 26.000',
        short: 'Kopi busa'),
  ];

  int _navIndex = 0;

  void _onNavTap(int index) {
    setState(() => _navIndex = index);
    switch (index) {
      case 0:
        return;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CoffePage(allCoffes: coffees)));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const PromoPage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ContactPage()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text(
          'Coffee Shop',
          style: const TextStyle(
            fontFamily: 'Calibri',
            color: Color(0xFFD7B899),        // CERAH
            fontWeight: FontWeight.bold,
            fontSize: 22,
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black45,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.brown.shade700,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.brown.shade200,
      ),

      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const HeaderBanner(),
          const SizedBox(height: 18),
          const MarketingCard(),
          const SizedBox(height: 25),

          const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Text(
              'Coffee Terbaru',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Calibri',
              ),
            ),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.78,
            ),
            itemCount: coffees.length,
            itemBuilder: (_, i) => CoffeCard(
              shop: coffees[i],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CoffePage(detail: coffees[i]),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        selectedItemColor: Colors.brown.shade800,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.coffee_rounded), label: 'Coffee'),
        ],
      ),
    );
  }
}

// ======================================================
//  MAIN (Fake Calibri applied)
// ======================================================
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(fontFamily: 'Calibri'),
    ),
  );
}
