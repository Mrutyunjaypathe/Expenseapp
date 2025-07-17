import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Required for Riverpod
import 'package:expenseapp/home_page.dart'; // Import the new HomeScreen

// This file would typically be named onboarding_screen.dart

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get screen dimensions for responsive layout
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Overall white background
      body: Column(
        children: [
          // Top section with gradient background and illustration
          Expanded(
            flex: 3, // Takes more space
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                // Using a subtle gradient to mimic the light, airy feel
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE0F2F1), // Lighter teal/mint shade
                    Color(0xFFFFFFFF), // White at the bottom
                  ],
                ),
                // The circular pattern is complex for pure Flutter code without custom painter.
                // For a simple example, we'll use a gradient.
                // If a precise pattern is needed, it would involve CustomPainter or an SVG asset.
              ),
              child: Center(
                // Adjusted Image.asset properties for better fit and alignment
                child: SizedBox( // Use SizedBox to give the image a constrained size
                  width: screenWidth * 0.75, // Adjust width (e.g., 75% of screen width)
                  height: screenHeight * 0.45, // Adjust height (e.g., 45% of screen height)
                  child: Image.asset(
                    'assets/images/body.png', // Path to your local image asset
                    fit: BoxFit.contain, // Ensures the image is scaled to fit within bounds
                    alignment: Alignment.center, // Ensures the image is centered within its SizedBox
                  ),
                ),
              ),
            ),
          ),
          // Bottom section with text and buttons
          Expanded(
            flex: 2, // Takes less space
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title text
                  const Text(
                    'Spend Smarter\nSave More',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26A69A), // Darker teal for text
                      fontFamily: 'Inter', // Assuming Inter font
                      height: 1.2, // Line height adjustment
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05), // Responsive spacing

                  // Get Started Button
                  SizedBox(
                    width: double.infinity, // Full width button
                    height: 56.0, // Fixed height for the button
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the next screen (e.g., home or sign-up)
                        // Using pushReplacementNamed to prevent going back to onboarding
                        Navigator.of(context).pushReplacementNamed('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4DB6AC), // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Rounded corners
                        ),
                        elevation: 5, // Shadow effect
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), // Responsive spacing

                  // Already Have Account? Log In text
                  TextButton(
                    onPressed: () {
                      // Navigate to the login screen
                      print('Log In tapped!');
                      // Example: Navigator.of(context).pushNamed('/login');
                    },
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey, // Default grey color
                          fontFamily: 'Inter',
                        ),
                        children: [
                          const TextSpan(text: 'Already Have Account? '),
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor, // Use primary color for link
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
