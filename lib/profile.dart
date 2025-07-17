import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

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
          'Profile',
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
            // Profile Picture and Name (positioned over the curve)
            Transform.translate(
              offset: Offset(0, -screenHeight * 0.08), // Adjust to move up
              child: Column(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.15, // Responsive radius
                    backgroundColor: Colors.white, // Background for the image
                    child: ClipOval(
                      child: Image.network(
                        'https://placehold.co/${(screenWidth * 0.3).toInt()}x${(screenWidth * 0.3).toInt()}/A0D9D5/FFFFFF?text=Profile', // Placeholder image
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            color: const Color(0xFFA0D9D5),
                            child: const Center(
                              child: Icon(Icons.person, color: Colors.white, size: 50),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Enjelin Morgeana',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '@enjelin_morgeana',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Space after profile info

            // Menu Items
            _buildMenuItem(context, Icons.card_giftcard, 'Invite Friends', const Color(0xFF26A69A)), // Using a gift card icon for the diamond
            _buildMenuItem(context, Icons.person_outline, 'Account info'),
            _buildMenuItem(context, Icons.people_outline, 'Personal profile'),
            _buildMenuItem(context, Icons.mail_outline, 'Message center'),
            _buildMenuItem(context, Icons.security, 'Login and security'),
            _buildMenuItem(context, Icons.lock_outline, 'Data and privacy'),
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
              icon: const Icon(Icons.wallet_outlined, color: Colors.grey),
              onPressed: () {
                // Handle wallet navigation
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Color(0xFF26A69A)), // Highlighted
              onPressed: () {
                // Already on Profile screen, do nothing or pop to root if needed
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, [Color? iconColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: iconColor ?? Colors.grey.shade700, size: 28),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontFamily: 'Inter',
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
            onTap: () {
              print('$title tapped!');
              // Handle navigation or action for each menu item
            },
          ),
          Divider(height: 1, color: Colors.grey.shade200, indent: 60, endIndent: 20),
        ],
      ),
    );
  }
}
