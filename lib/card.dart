import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expenseapp/debitcard.dart'; // Import the new DebitCardWidget

// Define a StateProvider to manage the selected tab (0 for Cards, 1 for Accounts)
final connectWalletSelectedTabProvider = StateProvider<int>((ref) => 0);

class ConnectWalletScreen extends ConsumerWidget {
  const ConnectWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Watch the selected tab provider
    final selectedTab = ref.watch(connectWalletSelectedTabProvider);

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
          'Connect Wallet',
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
            // Cards / Accounts Tabs
            Transform.translate(
              offset: Offset(0, -screenHeight * 0.05), // Adjust to move up
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 50, // Fixed height for the tab container
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ref.read(connectWalletSelectedTabProvider.notifier).state = 0,
                          child: _buildTabButton('Cards', selectedTab == 0), // Cards selected
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ref.read(connectWalletSelectedTabProvider.notifier).state = 1,
                          child: _buildTabButton('Accounts', selectedTab == 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Debit Card Image (or other content based on selected tab)
            Transform.translate(
              offset: Offset(0, -screenHeight * 0.08), // Adjust to move up further
              child: Center(
                child: selectedTab == 0
                    ? const DebitCardWidget() // Display DebitCardWidget for 'Cards' tab
                    : const Text(
                  'Accounts content will go here', // Placeholder for 'Accounts' tab
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Space after card

            // Add your debit Card section (only visible for Cards tab)
            if (selectedTab == 0) // Conditionally display this section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add your debit Card',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 5),
                    const Text(
                      'This card must be connected to a bank account\nunder your name',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 20),

                    // Form Fields
                    _buildTextField('NAME ON CARD', 'IRVAN MOSES'),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('DEBIT CARD NUMBER', '')),
                        SizedBox(width: 15),
                        Expanded(child: _buildTextField('CVC', '')),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('EXPIRATION MM/YY', '')),
                        SizedBox(width: 15),
                        Expanded(child: _buildTextField('ZIP', '')),
                      ],
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

  Widget _buildTabButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      // Adjusted horizontal padding for better visual
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5), // Added margin
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10), // Slightly less rounded for tabs
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

  Widget _buildTextField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue.isNotEmpty ? initialValue : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF26A69A)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
        ),
      ],
    );
  }
}
