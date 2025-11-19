import 'package:flutter/material.dart';

class MarketingCard extends StatelessWidget {
  const MarketingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/images/marketing.jpeg', width: 86, height: 86, fit: BoxFit.cover)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Nikmati kopi fresh setiap hari dengan biji kopi pilihan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 6),
                  Text('Melayani dine-in, takeaway, dan delivery ke seluruh Bandung.'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
