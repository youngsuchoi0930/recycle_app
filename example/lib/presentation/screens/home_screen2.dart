import 'package:flutter/material.dart';
// 원래 있던 카메라 화면 경로
import 'package:ultralytics_yolo_example/presentation/screens/camera_inference_screen.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 그라데이션
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF050816),
                  Color(0xFF0A0F2C),
                  Color(0xFF120A2A),
                  Color(0xFF03040A),
                ],
              ),
            ),
          ),

          // 네온 글로우 1
          Positioned(
            top: -80,
            left: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.35),
                    blurRadius: 120,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          // 네온 글로우 2
          Positioned(
            bottom: -100,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent.withOpacity(0.10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(0.35),
                    blurRadius: 140,
                    spreadRadius: 35,
                  ),
                ],
              ),
            ),
          ),

          // 배경 그리드
          Positioned.fill(child: CustomPaint(painter: _CyberGridPainter())),

          // 메인 콘텐츠
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 36,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.cyanAccent.withOpacity(0.25),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.08),
                      blurRadius: 40,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 상단 아이콘 박스
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00F5FF),
                            Color(0xFF7C3AED),
                            Color(0xFFFF2BD6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyanAccent.withOpacity(0.45),
                            blurRadius: 30,
                            spreadRadius: 3,
                          ),
                          BoxShadow(
                            color: Colors.pinkAccent.withOpacity(0.25),
                            blurRadius: 35,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.remove_red_eye_rounded,
                        size: 56,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'YOLO VISION AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.4,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.cyanAccent, blurRadius: 18),
                          Shadow(color: Colors.pinkAccent, blurRadius: 28),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      'REAL-TIME OBJECT DETECTION SYSTEM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2,
                        color: Colors.cyanAccent.withOpacity(0.85),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      '카메라를 통해 객체를 빠르게 인식하고\n실시간으로 분석을 시작하세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.white.withOpacity(0.78),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // 버튼
                    InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CameraInferenceScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 34,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF00F5FF),
                              Color(0xFF6D5BFF),
                              Color(0xFFFF2BD6),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyanAccent.withOpacity(0.35),
                              blurRadius: 22,
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.pinkAccent.withOpacity(0.25),
                              blurRadius: 24,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.radar_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '스캔 시작하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'SYSTEM STATUS : ONLINE',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        color: Colors.greenAccent.withOpacity(0.85),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CyberGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.08)
      ..strokeWidth = 1;

    const double gap = 32;

    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final glowPaint = Paint()
      ..color = Colors.pinkAccent.withOpacity(0.06)
      ..strokeWidth = 1.2;

    for (double y = 16; y <= size.height; y += 64) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
