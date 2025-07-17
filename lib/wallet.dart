import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expenseapp/transaction.dart'; // Import the new TransactionDetailsScreen
import 'package:expenseapp/addexpense.dart'; // Import the new AddExpenseScreen
import 'package:expenseapp/card.dart'; // Import the ConnectWalletScreen

// Define a StateProvider to manage the selected tab (Transactions or Upcoming Bills)
final selectedTabProvider = StateProvider<int>((ref) => 0); // 0 for Transactions, 1 for Upcoming Bills

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Watch the selectedTabProvider to get the current tab index
    final selectedTab = ref.watch(selectedTabProvider);

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
          'Wallet',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top curved background (similar to home screen)
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
            // Total Balance Card (positioned over the curve)
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
                    const Text(
                      'Total Balance',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      '\$ 2,548.00',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // "Add" button - NOW NAVIGATES TO CONNECT WALLET SCREEN
                        _buildActionButton(Icons.add, 'Add', () {
                          Navigator.of(context).pushNamed('/connect_wallet');
                        }),
                        _buildActionButton(Icons.grid_view, 'Pay', () {
                          // Handle Pay action
                        }), // Using grid_view for the squares icon
                        _buildActionButton(Icons.send, 'Send', () {
                          // Handle Send action
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Space after balance card

            // Transactions / Upcoming Bills Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => ref.read(selectedTabProvider.notifier).state = 0,
                        child: _buildTabButton('Transactions', selectedTab == 0),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => ref.read(selectedTabProvider.notifier).state = 1,
                        child: _buildTabButton('Upcoming Bills', selectedTab == 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Conditionally display content based on selected tab
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: selectedTab == 0
                  ? Column(
                children: [
                  // Transaction List Items (reused from home screen)
                  // Added GestureDetector to make the item tappable
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/transaction_details',
                        arguments: {
                          'transactionTitle': 'Upwork',
                          'transactionAmount': '\$ 850.00',
                          'amountColor': Colors.green,
                          'type': 'Income',
                        },
                      );
                    },
                    child: _buildTransactionItem(
                      context,
                      'Upwork',
                      'Today',
                      '+ \$ 850.00',
                      Colors.green,
                      Icons.business_center, // Changed to IconData
                      Colors.green.shade100, // Background color for icon
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/transaction_details',
                        arguments: {
                          'transactionTitle': 'Transfer',
                          'transactionAmount': '- \$ 85.00',
                          'amountColor': Colors.red,
                          'type': 'Expense',
                        },
                      );
                    },
                    child: _buildTransactionItem(
                      context,
                      'Transfer',
                      'Yesterday',
                      '- \$ 85.00',
                      Colors.red,
                      Icons.swap_horiz, // Changed to IconData
                      Colors.red.shade100, // Background color for icon
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/transaction_details',
                        arguments: {
                          'transactionTitle': 'Paypal',
                          'transactionAmount': '+ \$ 1,406.00',
                          'amountColor': Colors.green,
                          'type': 'Income',
                        },
                      );
                    },
                    child: _buildTransactionItem(
                      context,
                      'Paypal',
                      'Jan 30, 2022',
                      '+ \$ 1,406.00',
                      Colors.green,
                      Icons.payment, // Changed to IconData
                      Colors.blue.shade100, // Background color for icon
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/transaction_details',
                        arguments: {
                          'transactionTitle': 'Youtube',
                          'transactionAmount': '- \$ 11.99',
                          'amountColor': Colors.red,
                          'type': 'Expense',
                        },
                      );
                    },
                    child: _buildTransactionItem(
                      context,
                      'Youtube',
                      'Jan 16, 2022',
                      '- \$ 11.99',
                      Colors.red,
                      Icons.play_circle_filled, // Changed to IconData
                      Colors.red.shade100, // Background color for icon
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  // Upcoming Bills List Items
                  _buildUpcomingBillItem(
                    context,
                    'Youtube',
                    'Feb 28, 2022',
                    Icons.play_circle_filled, // Changed to IconData
                    Colors.red.shade100, // Background color for icon
                  ),
                  _buildUpcomingBillItem(
                    context,
                    'Electricity',
                    'Mar 28, 2022',
                    Icons.flash_on, // Changed to IconData
                    Colors.amber.shade100, // Background color for icon
                  ),
                  _buildUpcomingBillItem(
                    context,
                    'House Rent',
                    'Mar 31, 2022',
                    Icons.home, // Changed to IconData
                    Colors.brown.shade100, // Background color for icon
                  ),
                  _buildUpcomingBillItem(
                    context,
                    'Spotify',
                    'Feb 28, 2022',
                    Icons.music_note, // Changed to IconData
                    Colors.green.shade100, // Background color for icon
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
                  Navigator.of(context).pushNamed('/add_expense');
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.wallet, color: Color(0xFF26A69A)), // Highlighted
              onPressed: () {
                // Already on Wallet screen, do nothing or pop to root if needed
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

  // Updated _buildActionButton to include an onTap callback
  Widget _buildActionButton(IconData icon, String text, VoidCallback onTap) {
    return Column(
      children: [
        InkWell( // Use InkWell for tap effect
          onTap: onTap,
          borderRadius: BorderRadius.circular(50), // Match circle shape
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Icon(icon, color: Colors.black87, size: 28),
          ),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      // Adjusted horizontal padding for better visual
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5), // Added margin
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(15), // Slightly less rounded for tabs
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ]
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Color(0xFF26A69A) : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  // Reused from home screen for consistency - UPDATED TO USE ICONS
  Widget _buildTransactionItem(
      BuildContext context, String title, String date, String amount, Color amountColor, IconData icon, Color iconBgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        // Added GestureDetector to make the item tappable
        onTap: () {
          // Navigate to TransactionDetailsScreen, passing data
          Navigator.of(context).pushNamed(
            '/transaction_details',
            arguments: {
              'transactionTitle': title,
              'transactionAmount': amount,
              'amountColor': amountColor,
              'type': amount.contains('+') ? 'Income' : 'Expense', // Determine type based on amount sign
            },
          );
        },
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
      ),
    );
  }

  // New widget for Upcoming Bill items - UPDATED TO USE ICONS
  Widget _buildUpcomingBillItem(BuildContext context, String title, String date, IconData icon, Color iconBgColor) {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1), // Light teal background
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Pay',
              style: TextStyle(
                color: Color(0xFF26A69A), // Darker teal text
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
