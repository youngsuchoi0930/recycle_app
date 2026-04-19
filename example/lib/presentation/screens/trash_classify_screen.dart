import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TrashClassifyScreen extends StatefulWidget {
  const TrashClassifyScreen({super.key});

  @override
  State<TrashClassifyScreen> createState() => _TrashClassifyScreenState();
}

class _TrashClassifyScreenState extends State<TrashClassifyScreen> {
  final ImagePicker _picker = ImagePicker();

  Interpreter? _interpreter;
  List<String> _labels = [];

  File? _selectedImage;
  bool _isLoadingModel = true;
  bool _isPredicting = false;

  String _resultLabel = '아직 결과 없음';
  String _resultLabelKor = '-';
  double _confidence = 0.0;
  String _guideText = '사진을 선택하면 분리수거 분류 결과가 표시됩니다.';

  static const int _inputSize = 224;

  @override
  void initState() {
    super.initState();
    _loadModelAndLabels();
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  Future<void> _loadModelAndLabels() async {
    try {
      final interpreter = await Interpreter.fromAsset(
        'assets/models/trash_classifier.tflite',
      );

      final labelsRaw = await rootBundle.loadString('assets/models/labels.txt');

      final labels = labelsRaw
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      debugPrint('=== 모델 정보 ===');
      debugPrint('입력 Shape: ${interpreter.getInputTensor(0).shape}');
      debugPrint('입력 Type: ${interpreter.getInputTensor(0).type}');
      debugPrint('출력 Shape: ${interpreter.getOutputTensor(0).shape}');
      debugPrint('출력 Type: ${interpreter.getOutputTensor(0).type}');
      debugPrint('라벨: $labels');

      setState(() {
        _interpreter = interpreter;
        _labels = labels;
        _isLoadingModel = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingModel = false;
        _guideText = '모델 또는 라벨 파일 로드 실패: $e';
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile == null) return;

      final file = File(pickedFile.path);

      setState(() {
        _selectedImage = file;
      });

      await _runInference(file);
    } catch (e) {
      setState(() {
        _guideText = '이미지 선택 실패: $e';
      });
    }
  }

  Future<void> _runInference(File imageFile) async {
    if (_interpreter == null || _labels.isEmpty) {
      setState(() {
        _guideText = '모델이 아직 준비되지 않았습니다.';
      });
      return;
    }

    setState(() {
      _isPredicting = true;
      _resultLabel = '분석 중...';
      _resultLabelKor = '-';
      _confidence = 0.0;
    });

    try {
      final bytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null) {
        setState(() {
          _resultLabel = '이미지 읽기 실패';
          _resultLabelKor = '-';
          _guideText = '선택한 이미지를 해석할 수 없습니다.';
          _isPredicting = false;
        });
        return;
      }

      final resized = img.copyResize(
        decodedImage,
        width: _inputSize,
        height: _inputSize,
      );

      // ⭐⭐⭐ 중요: 정규화 없이 0~255 그대로! ⭐⭐⭐
      // 학습 시 모델 내부에 preprocess_input이 포함되어 있으므로
      // Flutter에서는 추가 전처리하면 안 됨!
      final input = List.generate(
        1,
        (_) => List.generate(
          _inputSize,
          (y) => List.generate(_inputSize, (x) {
            final pixel = resized.getPixel(x, y);

            // 정규화 없이 픽셀값 그대로 전달
            return [
              pixel.r.toDouble(),
              pixel.g.toDouble(),
              pixel.b.toDouble(),
            ];
          }),
        ),
      );

      final output = List.generate(1, (_) => List.filled(_labels.length, 0.0));

      _interpreter!.run(input, output);

      final scores = output[0];

      // 디버그: 모든 클래스 확률 출력
      debugPrint('========================');
      debugPrint('=== 예측 결과 ===');
      for (int i = 0; i < _labels.length; i++) {
        debugPrint('${_labels[i]}: ${(scores[i] * 100).toStringAsFixed(2)}%');
      }
      debugPrint('========================');

      int maxIndex = 0;
      double maxScore = scores[0];

      for (int i = 1; i < scores.length; i++) {
        if (scores[i] > maxScore) {
          maxScore = scores[i];
          maxIndex = i;
        }
      }

      final label = _labels[maxIndex];
      final labelKor = _toKoreanLabel(label);
      final guide = _getGuide(label);

      setState(() {
        _resultLabel = label;
        _resultLabelKor = labelKor;
        _confidence = maxScore;
        _guideText = guide;
        _isPredicting = false;
      });
    } catch (e) {
      setState(() {
        _resultLabel = '예측 실패';
        _resultLabelKor = '-';
        _guideText = '추론 중 오류 발생: $e';
        _isPredicting = false;
      });
    }
  }

  String _toKoreanLabel(String label) {
    switch (label) {
      case 'plastic':
        return '플라스틱';
      case 'paper':
        return '종이';
      case 'glass':
        return '유리';
      case 'can':
        return '캔';
      case 'normal':
      case 'trash':
        return '일반쓰레기';
      default:
        return label;
    }
  }

  String _getGuide(String label) {
    switch (label) {
      case 'plastic':
        return '내용물을 비우고 이물질을 제거한 뒤 배출하세요.';
      case 'paper':
        return '물기에 젖지 않게 하고 테이프, 비닐을 제거한 뒤 배출하세요.';
      case 'glass':
        return '깨지지 않게 주의하고 병뚜껑 등 다른 재질은 분리하세요.';
      case 'can':
        return '내용물을 비우고 헹군 뒤 가능하면 찌그러뜨려 배출하세요.';
      case 'normal':
      case 'trash':
        return '재활용이 어렵다면 종량제 봉투에 배출하세요.';
      default:
        return '분리배출 가이드를 찾을 수 없습니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),
      appBar: AppBar(
        title: const Text('분리수거 분류'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoadingModel
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.cyanAccent),
                    ),
                    child: _selectedImage == null
                        ? const Center(
                            child: Text(
                              '선택된 이미지가 없습니다.',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isPredicting
                          ? null
                          : () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('갤러리에서 선택'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isPredicting
                          ? null
                          : () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('카메라로 촬영'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.cyanAccent),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '분류 결과',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          _resultLabelKor,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '영문 라벨: $_resultLabel',
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '신뢰도: ${(_confidence * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '분리배출 가이드',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _guideText,
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
