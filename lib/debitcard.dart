import 'package:flutter/material.dart';

class DebitCardWidget extends StatelessWidget {
  const DebitCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height; // Using screenHeight for card height responsiveness

    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.25, // Adjust height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF26A69A), // Darker teal
            Color(0xFF4DB6AC), // Lighter teal
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Debit Card',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Text(
              'Mono',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 80,
            child: Icon(Icons.credit_card, color: Colors.white, size: 40), // Chip icon
          ),
          Positioned(
            left: 20,
            bottom: 40,
            child: Text(
              '6219  8610  2888  8075',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 15,
            child: Text(
              'IRVAN MOSES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 15,
            child: Text(
              '22/01',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
