import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionDetailsScreen extends ConsumerWidget {
  // You might want to pass transaction details to this screen
  final String transactionTitle;
  final String transactionAmount;
  final Color amountColor;
  final String type; // e.g., "Income", "Expense"

  const TransactionDetailsScreen({
    super.key,
    required this.transactionTitle,
    required this.transactionAmount,
    required this.amountColor,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Transaction Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top curved background (similar to other screens)
            Container(
              height: screenHeight * 0.15, // Adjust height as needed
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF26A69A), // Darker teal
                    Color(0xFF4DB6AC), // Lighter teal
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.1),
                  bottomRight: Radius.circular(screenWidth * 0.1),
                ),
              ),
            ),
            // Transaction Summary Card (positioned over the curve)
            Transform.translate(
              offset: Offset(0, -screenHeight * 0.08), // Adjust to move up
              child: Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent, // No background for logo
                      child: Image.network(
                        'https://placehold.co/60x60/E8F5E9/4CAF50?text=Up', // Placeholder for Upwork logo
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.business_center, size: 40, color: Colors.grey);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: type == 'Income' ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE), // Light green for Income, light red for Expense
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: type == 'Income' ? Colors.green.shade700 : Colors.red.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      transactionAmount,
                      style: TextStyle(
                        color: amountColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Space after balance card

            // Transaction Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transaction details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Icon(Icons.arrow_drop_up, color: Colors.grey), // Arrow up icon
                    ],
                  ),
                  SizedBox(height: 20),
                  // Updated Status row to correctly display the passed 'type'
                  _buildDetailRow('Status', type, isBoldValue: true, valueColor: type == 'Income' ? Colors.green : Colors.red),
                  _buildDetailRow('From', 'Upwork Escrow'),
                  _buildDetailRow('Time', '10:00 AM'),
                  _buildDetailRow('Date', 'Feb 30, 2022'), // Note: Feb 30 is not a real date
                  SizedBox(height: 30),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  SizedBox(height: 30),
                  _buildDetailRow('Earnings', '\$ 870.00'),
                  _buildDetailRow('Fee', '- \$ 20.00'),
                  _buildDetailRow('Total', '\$ 850.00', isBoldValue: true),
                  SizedBox(height: screenHeight * 0.05),

                  // Download Receipt Button
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: 56.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle download receipt
                          print('Download Receipt tapped!');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0F2F1), // Light teal background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 0, // No shadow
                        ),
                        child: const Text(
                          'Download Receipt',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26A69A), // Darker teal text
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.1), // Space for bottom nav bar
          ],
        ),
      ),
      // Bottom Navigation Bar (reused from HomeScreen for consistency)
      bottomNavigationBar: Container(
        height: screenHeight * 0.1, // Adjust height as needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.08),
            topRight: Radius.circular(screenWidth * 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/statistics');
              },
            ),
            // Centered floating action button
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF4DB6AC),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  // Handle add transaction
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.wallet, color: Color(0xFF26A69A)), // Highlighted if coming from Wallet
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/wallet');
              },
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/profile');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBoldValue = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
              color: valueColor ?? Colors.black87,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
