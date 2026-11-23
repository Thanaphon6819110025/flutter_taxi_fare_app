import 'package:flutter/material.dart';

const kYellow = Color(0xFFF5C242);

class TaxiFareUi extends StatefulWidget {
  const TaxiFareUi({super.key});

  @override
  State<TaxiFareUi> createState() => _TaxiFareUiState();
}

class _TaxiFareUiState extends State<TaxiFareUi> {
  final _kmCtrl = TextEditingController();
  final _minCtrl = TextEditingController();
  double _fare = 0;

  // [กม.เริ่มต้น, กม.สิ้นสุด, บาทต่อกม.]
  static const _tiers = [
    [1.0, 10.0, 6.5],
    [10.0, 20.0, 7.0],
    [20.0, 40.0, 8.0],
    [40.0, 60.0, 8.5],
    [60.0, 80.0, 9.0],
    [80.0, double.infinity, 10.5],
  ];

  double _calc(double km, double trafficMin) {
    double f = 35; // กิโลเมตรแรก
    for (final t in _tiers) {
      if (km > t[0]) {
        final upper = km < t[1] ? km : t[1];
        f += (upper - t[0]) * t[2];
      }
    }
    return f + trafficMin * 3.0; // รถติดนาทีละ 3 บาท
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFE05243),
        content: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.yellow, size: 18),
            SizedBox(width: 8),
            Text(
              'กรุณากรอกข้อมูลให้ครบถ้วน',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _onCalculate() {
    final km = double.tryParse(_kmCtrl.text.trim());
    final min = double.tryParse(_minCtrl.text.trim());
    if (km == null || min == null || km <= 0 || min < 0) {
      _showError();
      return;
    }
    setState(() => _fare = _calc(km, min));
  }

  void _onCancel() {
    _kmCtrl.clear();
    _minCtrl.clear();
    setState(() => _fare = 0);
  }

  @override
  void dispose() {
    _kmCtrl.dispose();
    _minCtrl.dispose();
    super.dispose();
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 6),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      );

  Widget _field(TextEditingController c, String hint) => TextField(
        controller: c,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
      );

  Widget _button(String text, Color color, VoidCallback onPressed) => SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: kYellow,
          centerTitle: true,
          title: const Text(
            'Taxi Fare',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ใส่รูปแท็กซี่ตรงนี้ (path รูปอยู่ในเครื่องหมายคำพูด, width คือขนาดรูป)
              Center(child: Image.asset('assets/images/619006.png',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
               )
               ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'คำนวณค่าโดยสารแท็กซี่',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              _label('ระยะทาง (กิโลเมตร) 🛣️'),
              _field(_kmCtrl, 'กรุณากรอกระยะทาง'),
              _label('เวลารถติด (นาที) ⏰'),
              _field(_minCtrl, 'กรุณากรอกเวลารถติด'),
              const SizedBox(height: 20),
              _button('คำนวณค่าโดยสาร', kYellow, _onCalculate),
              const SizedBox(height: 10),
              _button('ยกเลิก', Colors.grey.shade500, _onCancel),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCEBB6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text('ค่าโดยสารแท็กซี่',
                        style: TextStyle(fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(
                      _fare.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE0443A),
                      ),
                    ),
                    const Text('บาท', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}