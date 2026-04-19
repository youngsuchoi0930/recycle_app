import 'package:flutter/material.dart';
// 원래 있던 카메라 화면 경로 (본인 프로젝트 경로에 맞게 확인)
import 'package:ultralytics_yolo_example/presentation/screens/camera_inference_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // 세련된 다크 블루 배경
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AI 테크 느낌 아이콘
            const Icon(
              Icons.rocket_launch_rounded,
              size: 100,
              color: Colors.cyanAccent,
            ),
            const SizedBox(height: 24),
            const Text(
              'YOLO VISION AI',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 60),
            // 시작 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 15,
              ),
              onPressed: () {
                // 다음 파일(카메라 화면)로 넘기기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraInferenceScreen(),
                  ),
                );
              },
              child: const Text(
                '스캔 시작하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
