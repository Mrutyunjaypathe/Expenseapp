import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class AddExpenseScreen extends ConsumerWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // TextEditingController for the amount field to programmatically set its value
    final TextEditingController amountController = TextEditingController(text: '\$ 48.00');
    // TextEditingController for the date field
    final TextEditingController dateController = TextEditingController(text: 'Tue, 22 Feb 2022');

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
          'Add Expense',
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
            // Form Section
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field (Dropdown)
                    const Text(
                      'NAME',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: 'Netflix', // Default value
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Inter'),
                          onChanged: (String? newValue) {
                            // Handle dropdown value change
                          },
                          items: <String>['Netflix', 'Spotify', 'Amazon', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  // Placeholder for Netflix logo
                                  Image.network(
                                    'https://placehold.co/30x30/FF0000/FFFFFF?text=N',
                                    width: 24, height: 24,
                                    errorBuilder: (context, error, stackTrace) => Icon(Icons.movie, size: 24, color: Colors.red),
                                  ),
                                  SizedBox(width: 10),
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Amount Field
                    const Text(
                      'AMOUNT',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: amountController, // Assign the controller
                      readOnly: true, // Make it read-only so keyboard doesn't pop up automatically
                      onTap: () {
                        // Show the custom number pad when the field is tapped
                        _showNumberPad(context, amountController);
                      },
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
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () {
                            amountController.clear(); // Clear the amount
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: Colors.grey, fontFamily: 'Inter'),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      ),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 20),

                    // Date Field
                    const Text(
                      'DATE',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: dateController, // Assign the date controller
                      readOnly: true,
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
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today, color: Colors.grey),
                          onPressed: () async {
                            // Handle date picker
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Color(0xFF26A69A), // Header background color
                                      onPrimary: Colors.white, // Header text color
                                      onSurface: Colors.black, // Body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Color(0xFF26A69A), // Button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              // Format the picked date and update the controller
                              dateController.text = DateFormat('EEE, dd MMM yyyy').format(picked);
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      ),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 20),

                    // Add Invoice Button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_circle_outline, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            'Add Invoice',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05), // Add some space at the bottom
          ],
        ),
      ),
    );
  }

  // Method to show the custom number pad as a bottom sheet
  void _showNumberPad(BuildContext context, TextEditingController controller) {
    // Extract numerical part from the controller's text, handling initial '$ '
    String initialAmount = controller.text.replaceAll('\$', '').trim();
    if (initialAmount == '0.00' || initialAmount.isEmpty) {
      initialAmount = ''; // Start with empty string if it's 0.00 or empty
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take full height if needed
      builder: (BuildContext bc) {
        return StatefulBuilder( // Use StatefulBuilder to update the sheet's content
          builder: (BuildContext context, StateSetter setState) {
            String currentAmount = initialAmount; // Use a local state variable for the keypad

            // Function to format the display string for the keypad
            String _formatDisplayAmount(String amount) {
              if (amount.isEmpty) return '0.00';
              if (amount.contains('.')) {
                List<String> parts = amount.split('.');
                if (parts.length > 1 && parts[1].length > 2) {
                  amount = '${parts[0]}.${parts[1].substring(0, 2)}'; // Limit to 2 decimal places
                }
              }
              return amount;
            }

            return Container(
              height: MediaQuery.of(context).size.height * 0.55, // Adjusted height for better keypad visibility
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // Display current amount being typed
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '\$ ${_formatDisplayAmount(currentAmount)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: Column(
                      children: [
                        _buildNumberPadRow(['1', '2', '3'], currentAmount, setState),
                        _buildNumberPadRow(['4', '5', '6'], currentAmount, setState),
                        _buildNumberPadRow(['7', '8', '9'], currentAmount, setState),
                        _buildNumberPadRow(['.', '0', 'backspace'], currentAmount, setState),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Update the main TextFormField controller with the final formatted amount
                        controller.text = '\$ ${_formatDisplayAmount(currentAmount)}';
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF26A69A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Inter'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Updated _buildNumberPadRow to handle input logic and update state
  Widget _buildNumberPadRow(List<String> keys, String currentAmount, StateSetter setState) {
    return Expanded(
      child: Row(
        children: keys.map((key) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1, // Make buttons square
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (key == 'backspace') {
                        if (currentAmount.isNotEmpty) {
                          currentAmount = currentAmount.substring(0, currentAmount.length - 1);
                        }
                      } else if (key == '.') {
                        if (!currentAmount.contains('.')) {
                          currentAmount += key;
                        }
                      } else {
                        // Prevent multiple leading zeros (e.g., 005) but allow 0.5
                        if (currentAmount == '0' && key != '.') {
                          currentAmount = key; // Replace 0 with new digit
                        } else {
                          currentAmount += key;
                        }
                      }
                      // No need for (context as Element).markNeedsBuild(); here.
                      // setState() itself will trigger the rebuild of the StatefulBuilder.
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: key == 'backspace'
                          ? const Icon(Icons.backspace_outlined, color: Colors.black87)
                          : Text(
                        key,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Inter',
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
