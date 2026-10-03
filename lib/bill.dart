import 'package:flutter/material.dart';

class BillScreen extends StatelessWidget {
  final double amount;
  final String data;

  const BillScreen({super.key, required this.amount, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bill"),
        backgroundColor: const Color(0xFF7A3E1D),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const Text(
              "Cafe Bill",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF54270F),
              ),
            ),

            const SizedBox(height: 20),

            // Bill items
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8F3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF7A3E1D)),
                ),

                child: SingleChildScrollView(
                  child: Text(
                    data,
                    style: const TextStyle(fontSize: 18, height: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Divider(thickness: 2),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                Text(
                  "Rs.${amount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7A3E1D),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Print Bill button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Print bill
                },
                icon: const Icon(Icons.print),
                label: const Text(
                  "Print Bill",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7A3E1D),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
