import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

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
          'Statistics',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined, color: Colors.black),
            onPressed: () {
              // Handle download action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // Day, Week, Month, Year selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTimePeriodButton('Day', true), // Selected
                  _buildTimePeriodButton('Week', false),
                  _buildTimePeriodButton('Month', false),
                  _buildTimePeriodButton('Year', false),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              // Expense Dropdown
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Expense', // Default selected value
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Inter'),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                      items: <String>['Expense', 'Income', 'Savings']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Chart Area
              Container(
                height: screenHeight * 0.3, // Adjust height for the chart
                width: double.infinity,
                // Placeholder for the chart - a custom painter or charting library would go here
                child: CustomPaint(
                  painter: _ChartPainter(),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: screenHeight * 0.08, // Adjust position based on chart curve
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2F1), // Light teal fill color
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Text(
                              '\$1,230',
                              style: TextStyle(
                                color: Color(0xFF26A69A), // Darker teal text
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ),
                        // Dot on the chart
                        Positioned(
                          top: screenHeight * 0.15, // Adjust position
                          left: screenWidth * 0.45, // Adjust position
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: const Color(0xFF26A69A), // Teal dot
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Chart X-axis labels (Months)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Mar', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                    Text('Apr', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                    Text('May', style: TextStyle(color: Color(0xFF26A69A), fontWeight: FontWeight.bold, fontFamily: 'Inter')), // Highlighted
                    Text('Jun', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                    Text('Jul', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                    Text('Aug', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                    Text('Sep', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Top Spending Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Spending',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.sort, color: Colors.grey), // Sort icon
                    onPressed: () {
                      // Handle sort action
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),

              // Top Spending List Items
              _buildSpendingItem(
                context,
                'Starbucks',
                'Jan 12, 2022',
                '- \$ 150.00',
                Colors.red,
                'https://placehold.co/40x40/D4F4D9/1E88E5?text=SB', // Placeholder for Starbucks logo
              ),
              _buildSpendingItem(
                context,
                'Transfer',
                'Yesterday',
                '- \$ 85.00',
                Colors.red,
                'https://placehold.co/40x40/FCE4EC/E91E63?text=Tr', // Placeholder for avatar
                isHighlighted: true, // Highlight this item
              ),
              _buildSpendingItem(
                context,
                'Youtube',
                'Jan 16, 2022',
                '- \$ 11.99',
                Colors.red,
                'https://placehold.co/40x40/FFEBEE/F44336?text=Yo', // Placeholder for Youtube logo
              ),
              SizedBox(height: screenHeight * 0.1), // Space for bottom nav bar
            ],
          ),
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
              icon: const Icon(Icons.bar_chart, color: Color(0xFF26A69A)), // Highlighted
              onPressed: () {
                // Already on Statistics screen, do nothing or pop to root if needed
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
              icon: const Icon(Icons.wallet_outlined, color: Colors.grey),
              onPressed: () {
                // Handle wallet navigation
              },
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                // Handle profile navigation
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePeriodButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF26A69A) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildSpendingItem(
      BuildContext context, String title, String date, String amount, Color amountColor, String imageUrl, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFF26A69A) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(imageUrl),
            onBackgroundImageError: (exception, stackTrace) {
              print('Error loading image: $exception');
            },
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: isHighlighted ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: isHighlighted ? Colors.white70 : Colors.grey,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isHighlighted ? Colors.white : amountColor,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for the wavy chart
class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE0F2F1) // Light teal fill color
      ..style = PaintingStyle.fill;

    final path = Path();
    // Define points for a wavy shape (simplified for visual representation)
    // These points are relative to the canvas size
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.5, size.width * 0.2, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.4, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.2, size.width * 0.6, size.height * 0.4); // Peak for $1,230
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.5, size.width * 0.8, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.4, size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Draw the line on top of the filled area
    final linePaint = Paint()
      ..color = const Color(0xFF4DB6AC) // Teal line color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final linePath = Path();
    linePath.moveTo(0, size.height * 0.7);
    linePath.quadraticBezierTo(size.width * 0.1, size.height * 0.5, size.width * 0.2, size.height * 0.6);
    linePath.quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.4, size.height * 0.5);
    linePath.quadraticBezierTo(size.width * 0.5, size.height * 0.2, size.width * 0.6, size.height * 0.4);
    linePath.quadraticBezierTo(size.width * 0.7, size.height * 0.5, size.width * 0.8, size.height * 0.3);
    linePath.quadraticBezierTo(size.width * 0.9, size.height * 0.4, size.width, size.height * 0.6);

    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
