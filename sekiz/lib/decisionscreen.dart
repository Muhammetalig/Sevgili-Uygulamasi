import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DecisionScreen extends StatefulWidget {
  @override
  _DecisionScreenState createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  String? _selectedOption; // Seçilen seçenek
  final List<String> _options = [
    'Ayşenin Dediği 🐋',
    'Alinin Dediği 🐒'
  ]; // Seçenekler

  void _makeDecision() {
    // Rastgele bir seçenek seç
    final randomIndex = _options.length > 1
        ? DateTime.now().millisecondsSinceEpoch % _options.length
        : 0;
    setState(() {
      _selectedOption = _options[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Karar Ver',
          style: GoogleFonts.lobster(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, const Color.fromARGB(255, 233, 161, 199)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, const Color.fromARGB(255, 233, 161, 199)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hangisi Olsun?',
                style: GoogleFonts.lobster(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              if (_selectedOption != null)
                Padding(
                  padding: const EdgeInsets.only(left: 75.0),
                  child: Text(
                    'Seçilen: $_selectedOption',
                    style: GoogleFonts.lobster(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _makeDecision,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 233, 161, 199),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: GoogleFonts.lobster(
                    fontSize: 18,
                  ),
                ),
                child: Text(
                  'Karar Ver',
                  style: GoogleFonts.lobster(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
