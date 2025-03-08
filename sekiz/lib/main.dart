import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Google Fonts paketini kullanıyoruz
import 'package:intl/intl.dart';
import 'dart:async';

// Eğer RatingScreen ve DecisionScreen gibi sayfalar varsa, onları import etmelisin
import 'package:sekiz/decisionScreen.dart';
import 'package:sekiz/ratingscreeen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aşkıma Özel',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: const Color.fromARGB(255, 233, 161, 199),
          surface: Color.fromARGB(255, 233, 161, 199),
          background: Colors.black,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Tema genelinde Lobster fontunu kullanıyoruz
        textTheme: GoogleFonts.lobsterTextTheme(),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime startDate = DateTime(2024, 4, 25); // Başlangıç tarihi
  Timer? _timer;
  Timer? _liveTimer;
  int _secondsRemaining = 1800; // 30 dakika
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _liveTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  Duration get totalDuration => DateTime.now().difference(startDate);

  String _formatTime(int seconds) {
    int minutes = (seconds ~/ 60);
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _isTimerRunning = true;
        } else {
          _stopTimer();
          _showTimeUpDialog();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _secondsRemaining = 1800;
      _isTimerRunning = false;
    });
    _stopTimer();
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Süre Doldu!',
          style: GoogleFonts.lobster(
            // Lobster fontu ile başlık
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        content: Text(
          '30 dakika tamamlandı ❤️',
          style: GoogleFonts.lobster(
            // Lobster fontu ile içerik
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 233, 161, 199),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetTimer();
            },
            child: Text(
              'Tamam',
              style: GoogleFonts.lobster(
                // Lobster fontu ile buton
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _liveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = totalDuration;
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aşkıma Özel',
          style: GoogleFonts.lobster(
            // Lobster fontu ile başlık
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
      body: SingleChildScrollView(
        child: Container(
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
              children: <Widget>[
                Text(
                  'Sevgili Olduğumuz Andan Beri',
                  style: GoogleFonts.lobster(
                    // Lobster fontu ile metin
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '$days Gün',
                  style: GoogleFonts.lobster(
                    // Lobster fontu ile gün sayısı
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    '${hours.toString().padLeft(2, '0')} saat '
                    '${minutes.toString().padLeft(2, '0')} dakika '
                    '${seconds.toString().padLeft(2, '0')} saniye geçti',
                    style: GoogleFonts.lobster(
                      // Lobster fontu ile geçen süre
                      fontSize: 24,
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(startDate)}',
                  style: GoogleFonts.lobster(
                    // Lobster fontu ile başlangıç tarihi
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    Text(
                      _formatTime(_secondsRemaining),
                      style: GoogleFonts.lobster(
                        // Lobster fontu ile geri sayım
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _isTimerRunning ? _stopTimer : _startTimer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isTimerRunning
                                ? Colors.grey
                                : const Color.fromARGB(255, 233, 161, 199),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                          ),
                          child: Text(
                            _isTimerRunning ? 'Durdur' : 'Başlat',
                            style: GoogleFonts.lobster(
                              // Lobster fontu ile buton
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _resetTimer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 233, 161, 199),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                          ),
                          child: Text(
                            'Sıfırla',
                            style: GoogleFonts.lobster(
                              // Lobster fontu ile buton
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RatingScreen()),
                    );
                  },
                  child: Text('Gün Değerlendirmesi'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DecisionScreen()),
                    );
                  },
                  child: Text('Karar Verme Ekranı'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
