import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expenseapp/statistics.dart'; // Import the StatisticsScreen
import 'package:expenseapp/profile.dart'; // Import the new ProfileScreen
import 'package:expenseapp/wallet.dart'; // Import the new WalletScreen
import 'package:expenseapp/addexpense.dart'; // Import the new AddExpenseScreen
import 'package:expenseapp/card.dart'; // Import the new ConnectWalletScreen

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top curved background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.35, // Adjust height as needed
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
          ),
          // Content Scrollable Area
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar: Good afternoon, Name, Notification Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Good afternoon,',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            'Enjelin Morgeana',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.notifications_none, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Total Balance Card - UPDATED BACKGROUND COLOR AND TEXT COLORS
                  Center(
                    child: Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF26A69A), // Changed background to green/teal
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    'Total Balance',
                                    style: TextStyle(
                                      color: Colors.white70, // Changed text color for contrast
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_up, color: Colors.white70), // Changed icon color
                                ],
                              ),
                              const Icon(Icons.more_horiz, color: Colors.white70), // Changed icon color
                            ],
                          ),
                          SizedBox(height: 10),
                          const Text(
                            '\$ 2,548.00',
                            style: TextStyle(
                              color: Colors.white, // Changed text color to white
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.arrow_downward, color: Colors.white), // Changed icon color
                                      Text(
                                        'Income',
                                        style: TextStyle(
                                          color: Colors.white70, // Changed text color
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '\$ 1,840.00',
                                    style: TextStyle(
                                      color: Colors.white, // Changed text color
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.arrow_upward, color: Colors.white), // Changed icon color
                                      Text(
                                        'Expenses',
                                        style: TextStyle(
                                          color: Colors.white70, // Changed text color
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '\$ 284.00',
                                    style: TextStyle(
                                      color: Colors.white, // Changed text color
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Transactions History
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transactions History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFF4DB6AC),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Transaction List Items
                  _buildTransactionItem(
                    context,
                    'Upwork',
                    'Today',
                    '+ \$ 850.00',
                    Colors.green,
                    Icons.business_center, // Changed to IconData
                    Colors.green.shade100, // Background color for icon
                  ),
                  _buildTransactionItem(
                    context,
                    'Transfer',
                    'Yesterday',
                    '- \$ 85.00',
                    Colors.red,
                    Icons.swap_horiz, // Changed to IconData
                    Colors.red.shade100, // Background color for icon
                  ),
                  _buildTransactionItem(
                    context,
                    'Paypal',
                    'Jan 30, 2022',
                    '+ \$ 1,406.00',
                    Colors.green,
                    Icons.payment, // Changed to IconData
                    Colors.blue.shade100, // Background color for icon
                  ),
                  _buildTransactionItem(
                    context,
                    'Youtube',
                    'Jan 16, 2022',
                    '- \$ 11.99',
                    Colors.red,
                    Icons.play_circle_filled, // Changed to IconData
                    Colors.red.shade100, // Background color for icon
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Send Again
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Send Again',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFF4DB6AC),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Send Again Avatars - Now using Icons for generic person representation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAvatarWithIcon(Icons.person, Colors.blue.shade200),
                      _buildAvatarWithIcon(Icons.person, Colors.green.shade200),
                      _buildAvatarWithIcon(Icons.person, Colors.orange.shade200),
                      _buildAvatarWithIcon(Icons.person, Colors.purple.shade200),
                      _buildAvatarWithIcon(Icons.person, Colors.red.shade200),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.1), // Space for bottom nav bar
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home, color: Color(0xFF26A69A)),
                    onPressed: () {
                      // Already on Home screen, do nothing or pop to root if needed
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.bar_chart, color: Colors.grey),
                    onPressed: () {
                      // Navigate to Statistics screen
                      Navigator.of(context).pushNamed('/statistics'); // Navigate to StatisticsScreen
                    },
                  ),
                  // Centered floating action button
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFF4DB6AC),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Navigate to Add Expense screen
                        Navigator.of(context).pushNamed('/add_expense');
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.wallet_outlined, color: Colors.grey),
                    onPressed: () {
                      // Navigate to Wallet screen
                      Navigator.of(context).pushNamed('/wallet'); // Navigate to WalletScreen
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person_outline, color: Colors.grey),
                    onPressed: () {
                      // Navigate to Profile screen
                      Navigator.of(context).pushNamed('/profile'); // Navigate to ProfileScreen
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated _buildTransactionItem to accept IconData and icon background color
  Widget _buildTransactionItem(
      BuildContext context, String title, String date, String amount, Color amountColor, IconData icon, Color iconBgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconBgColor, // Background color for the icon
            child: Icon(icon, color: Colors.white, size: 24), // Icon as logo
          ),
          SizedBox(width: 15),
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
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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
              color: amountColor,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  // New _buildAvatarWithIcon function for "Send Again" section
  Widget _buildAvatarWithIcon(IconData icon, Color bgColor) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: bgColor,
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
