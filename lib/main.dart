import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'dart:async'; // Required for Future.delayed

// Corrected import paths to match your project name 'expenseapp'
import 'package:expenseapp/onboarding_screen.dart';
import 'package:expenseapp/home_page.dart'; // Assuming home_screen.dart is the file name
import 'package:expenseapp/statistics.dart'; // Assuming statistics_screen.dart is the file name
import 'package:expenseapp/profile.dart'; // Assuming profile_screen.dart is the file name
import 'package:expenseapp/wallet.dart'; // Assuming wallet_screen.dart is the file name
import 'package:expenseapp/transaction.dart'; // Import the new TransactionDetailsScreen
import 'package:expenseapp/addexpense.dart'; // Import the new AddExpenseScreen
import 'package:expenseapp/card.dart'; // Import the new ConnectWalletScreen


// 1. Define a FutureProvider for app initialization.
// This provider simulates an asynchronous task that needs to complete
// before the app's main content is shown.
final initializationProvider = FutureProvider<void>((ref) async {
  // Simulate some asynchronous work, e.g., loading user data, fetching configs.
  await Future.delayed(const Duration(seconds: 3)); // 3-second delay
  // You could perform actual initialization logic here.
  print('App initialization complete!');
});

// Define the main function to run the app
void main() {
  // 2. Wrap the entire application with ProviderScope.
  // This is necessary for Riverpod to manage and provide states.
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// MyApp is the root of your application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mono App', // Title for the app
      theme: ThemeData(
        primarySwatch: Colors.teal, // Define a primary color swatch
      ),
      home: const SplashScreen(), // Set SplashScreen as the initial screen
      routes: {
        // Define the route for the OnboardingScreen
        '/onboarding': (context) => const OnboardingScreen(),
        // Define the route for the HomeScreen (now correctly using the imported one)
        '/home': (context) => const HomeScreen(),
        // Define the route for the StatisticsScreen
        '/statistics': (context) => const StatisticsScreen(),
        // Define the route for the ProfileScreen
        '/profile': (context) => const ProfileScreen(),
        // Define the route for the WalletScreen
        '/wallet': (context) => const WalletScreen(),
        // Corrected route for TransactionDetailsScreen to extract arguments
        '/transaction_details': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return TransactionDetailsScreen(
            transactionTitle: args['transactionTitle'] as String,
            transactionAmount: args['transactionAmount'] as String,
            amountColor: args['amountColor'] as Color,
            type: args['type'] as String,
          );
        },
        // Define the route for the AddExpenseScreen
        '/add_expense': (context) => const AddExpenseScreen(),
        // Define the route for the ConnectWalletScreen
        '/connect_wallet': (context) => const ConnectWalletScreen(),
      },
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}

// SplashScreen widget
// 3. Extend ConsumerWidget to use Riverpod providers.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 4. Watch the initializationProvider.
    // This will rebuild the widget when the provider's state changes (loading, error, data).
    final initializationState = ref.watch(initializationProvider);

    // 5. Handle the state of the initialization provider.
    initializationState.when(
      data: (_) {
        // Data is loaded, navigate to the ONBOARDING screen.
        // Use addPostFrameCallback to ensure navigation happens after the current frame is built.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed('/onboarding');
        });
      },
      loading: () {
        // Still loading, do nothing (stay on splash screen).
        // The UI below will show the splash screen content.
      },
      error: (err, stack) {
        // Handle error during initialization.
        // You might want to show an error message or retry option.
        print('Error during initialization: $err');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading app: $err')),
          );
        });
      },
    );

    return Scaffold(
      // Set the background color to a teal shade, matching the image.
      backgroundColor: const Color(0xFF26A69A), // A shade of teal
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: const [
            Text(
              'mono', // The text from your splash screen image
              style: TextStyle(
                color: Colors.white, // White color for the text
                fontSize: 48.0, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Bold font weight
                fontFamily: 'Inter', // Assuming Inter font, or pick a suitable one
              ),
            ),
            SizedBox(height: 30), // Add some space
            // Show a loading indicator while initialization is in progress
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// REMOVED: The placeholder HomeScreen widget definition was here.
// It is now expected that HomeScreen is imported from 'package:expenseapp/home_screen.dart'.
