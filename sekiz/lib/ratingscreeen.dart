import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Google Fonts paketini ekliyoruz

class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final Map<String, double> _ratings = {
    'Yakışıklılık': 5,
    'Temas Sıklığı': 5,
    'İlgi Gösterme': 5,
    'Hanımcılık': 5,
    'Espri Seviyesi': 5,
    'Sabır Seviyesi': 5,
    'Dinleme Becerisi': 5,
  };

  final Map<String, IconData> _icons = {
    'Yakışıklılık': Icons.face_retouching_natural,
    'Temas Sıklığı': Icons.favorite_border,
    'İlgi Gösterme': Icons.visibility,
    'Hanımcılık': Icons.verified_user,
    'Espri Seviyesi': Icons.sentiment_very_satisfied,
    'Sabır Seviyesi': Icons.accessibility_new,
    'Dinleme Becerisi': Icons.hearing,
  };

  double get _average =>
      _ratings.values.reduce((a, b) => a + b) / _ratings.length;

  String get _motivation {
    if (_average >= 9) return 'Kocan Olay! 💘';
    if (_average >= 8) return 'Mükemmel iş çıkarıyor! 😍';
    if (_average >= 7) return 'Harika ama daha iyisi olabilir 💪';
    if (_average >= 6) return 'İyi ama daha çok çabalamalı 🌟';
    return 'Sanırım biraz soğuk davrandı 🥶';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beni Nasıl Buldun?',
          style: GoogleFonts.lobster(fontSize: 24, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                const Color.fromARGB(255, 233, 161, 199)
              ], // Siyahdan yeşile geçiş
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              const Color.fromARGB(255, 233, 161, 199)
            ], // Siyahdan yeşile geçiş
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: _ratings.keys.map((category) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      color: const Color.fromARGB(255, 233, 161, 199)
                          .withOpacity(0.7), // Kart rengi
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(_icons[category], color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  category,
                                  style: GoogleFonts.lobster(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Slider(
                              value: _ratings[category]!,
                              min: 0,
                              max: 10,
                              divisions: 10,
                              label: '${_ratings[category]!.round()}',
                              activeColor: _getSliderColor(_ratings[category]!),
                              onChanged: (value) =>
                                  setState(() => _ratings[category] = value),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Kötü',
                                      style: GoogleFonts.lobster(
                                          color: Colors.grey)),
                                  Text('Harika',
                                      style: GoogleFonts.lobster(
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 161, 199)
                      .withOpacity(0.7), // Konteyner rengi
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Ortalama Puan: ${_average.toStringAsFixed(1)}',
                      style: GoogleFonts.lobster(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _motivation,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lobster(
                        fontSize: 16,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Sonuçları göster
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Değerlendirme Sonucu',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 247, 188, 213),
                            content: Text(
                              'Verdiğin puan: ${_average.toStringAsFixed(1)}\n\n$_motivation',
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Tamam',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Sonucu Gör'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 233, 161, 199), // Buton rengi
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSliderColor(double value) {
    if (value >= 8) return const Color.fromARGB(255, 233, 161, 199);
    if (value >= 6) return Colors.orange;
    return Colors.grey;
  }
}
