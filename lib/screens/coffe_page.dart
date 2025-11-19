import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ===== Model Coffe =====
class CoffeModel {
  final String id;
  final String name;
  final String image;
  final String price;
  final String? desc;
  final String? short;

  CoffeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.desc,
    this.short,
  });
}

// ===== CoffeCard Widget =====
class CoffeCard extends StatelessWidget {
  final CoffeModel shop;
  final VoidCallback onTap;

  const CoffeCard({super.key, required this.shop, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: shop.id,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    shop.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (shop.short != null)
                    Text(
                      shop.short!,
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  const SizedBox(height: 6),
                  Text(
                    shop.price,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
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

// ===== CoffePage =====
class CoffePage extends StatefulWidget {
  final CoffeModel? detail;
  final List<CoffeModel>? allCoffes;

  const CoffePage({super.key, this.detail, this.allCoffes});

  @override
  State<CoffePage> createState() => _CoffePageState();
}

class _CoffePageState extends State<CoffePage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => _isLoading = false);
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() => _opacity = 1.0);
      });
    });
  }

  Future<void> _openMap() async {
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
    // Mode daftar semua coffee
    if (widget.detail == null && widget.allCoffes != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Coffee'),
          backgroundColor: Colors.red.shade700,
        ),
        body: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: widget.allCoffes!.length,
            itemBuilder: (context, index) {
              final coffee = widget.allCoffes![index];
              return CoffeCard(
                shop: coffee,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          CoffePage(detail: coffee),
                      transitionsBuilder:
                          (_, animation, __, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }

    // Mode detail coffee
    final coffee = widget.detail!;
    return Scaffold(
      appBar: AppBar(
        title: Text(coffee.name),
        backgroundColor: Colors.red.shade700,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 3,
              ),
            )
          : AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: coffee.id,
                      child: Image.asset(
                        coffee.image,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coffee.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            coffee.price,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            coffee.desc ??
                                "coffee ${coffee.name} hadir dengan cita rasa terbaik, nikmati setiap tegukan Anda.",
                            style: const TextStyle(fontSize: 15, height: 1.5),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: _openMap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.location_on,
                                color: Colors.white),
                            label: const Text(
                              'lihat lokasi',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.shopping_cart,
                                color: Colors.white),
                            label: const Text(
                              'pesan sekarang',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      backgroundColor: Colors.grey[100],
    );
  }
}
