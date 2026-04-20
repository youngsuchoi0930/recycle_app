# ♻️ [AI휴먼4 app 실습] 분리수거 AI 분류 앱

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

**📸 사진 한 장으로 끝나는 분리수거, AI가 도와드립니다!**

스마트폰으로 쓰레기 사진을 찍으면 AI가 자동으로 분류해주는 Flutter 앱입니다.

</div>

---

## 🌟 프로젝트 소개

분리수거, 헷갈리신 적 있으신가요? 🤔

> *"이 플라스틱 컵은 어디에 버려야 하지?"*  
> *"유리병 뚜껑은 어떻게 분리하지?"*

이런 고민을 해결하기 위해 **카메라로 찍기만 하면 분리수거 종류를 알려주는 AI 앱**을 개발했습니다.  
MobileNetV2 기반 딥러닝 모델을 TensorFlow Lite로 변환하여 **온디바이스 추론**이 가능합니다.

---

## ✨ 주요 기능

<table>
  <tr>
    <td align="center" width="25%">
      <h3>📸</h3>
      <b>카메라 촬영</b><br>
      <sub>실시간으로 쓰레기 사진 촬영</sub>
    </td>
    <td align="center" width="25%">
      <h3>🖼️</h3>
      <b>갤러리 선택</b><br>
      <sub>저장된 사진으로 분류 가능</sub>
    </td>
    <td align="center" width="25%">
      <h3>🤖</h3>
      <b>AI 자동 분류</b><br>
      <sub>온디바이스에서 즉시 판별</sub>
    </td>
    <td align="center" width="25%">
      <h3>📋</h3>
      <b>배출 가이드</b><br>
      <sub>올바른 분리배출 방법 안내</sub>
    </td>
  </tr>
</table>

---

## 🗂️ 분류 카테고리

| 아이콘 | 카테고리 | 학습 이미지 | 설명 |
|:---:|:---:|:---:|:---|
| 🥫 | **Can (캔)** | 426장 | 알루미늄 캔, 스틸 캔 |
| 🍾 | **Glass (유리)** | 524장 | 유리병, 유리 용기 |
| 📄 | **Paper (종이)** | 1,006장 | 종이류, 신문지, 박스 |
| 🥤 | **Plastic (플라스틱)** | 522장 | PET, 플라스틱 용기 |

> 총 **2,478장**의 이미지로 학습된 모델을 사용합니다.

---

## 🛠️ 기술 스택

<div align="center">

### Frontend
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)

### AI / ML
![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=flat-square&logo=tensorflow&logoColor=white)
![Keras](https://img.shields.io/badge/Keras-D00000?style=flat-square&logo=keras&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)

### Tools
![VSCode](https://img.shields.io/badge/VSCode-007ACC?style=flat-square&logo=visualstudiocode&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)

</div>

### 📦 주요 패키지

```yaml
dependencies:
  flutter: sdk
  tflite_flutter: ^0.11.0    # TensorFlow Lite 추론 엔진
  image_picker: ^1.1.2       # 카메라/갤러리 접근
  image: ^4.2.0              # 이미지 전처리
```

---

## 🔥 앱 작동 방식

### 📊 전체 플로우

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│   📱 사용자                                                  │
│      │                                                      │
│      │ 1. 사진 촬영 / 선택                                   │
│      ▼                                                      │
│   🖼️ 이미지 로드                                             │
│      │                                                      │
│      │ 2. 224x224 리사이즈                                   │
│      ▼                                                      │
│   🔢 Tensor 변환                                             │
│      │                                                      │
│      │ 3. RGB 픽셀값 추출                                    │
│      ▼                                                      │
│   🧠 TFLite 모델 추론                                        │
│      │                                                      │
│      │ 4. MobileNetV2 기반 분류                              │
│      ▼                                                      │
│   📊 확률 계산 (Softmax)                                     │
│      │                                                      │
│      │ 5. 최고 확률 클래스 선택                               │
│      ▼                                                      │
│   🎯 결과 표시                                               │
│      │                                                      │
│      └─▶ 분류 결과 + 신뢰도 + 배출 가이드                    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 🎬 실제 동작 순서

1. **앱 실행** → `TFLite 모델 (.tflite)` 및 `라벨 (labels.txt)` 로드
2. **사진 선택** → 갤러리 또는 카메라에서 이미지 획득
3. **전처리** → 이미지를 224x224 크기로 리사이즈
4. **추론** → AI 모델이 각 클래스별 확률 계산
5. **결과 표시** → 가장 높은 확률의 카테고리와 분리배출 가이드 제공

---

## 🧠 AI 모델 상세

### 🏗️ 모델 아키텍처

**Transfer Learning 기반 MobileNetV2**

```
Input (224, 224, 3)
    ↓
Data Augmentation
    ├─ RandomFlip
    ├─ RandomRotation
    ├─ RandomZoom
    ├─ RandomContrast
    └─ RandomBrightness
    ↓
MobileNetV2 Preprocess (-1 ~ 1 정규화)
    ↓
MobileNetV2 Base Model (ImageNet 사전학습 가중치)
    ↓
GlobalAveragePooling2D
    ↓
Dropout (0.3)
    ↓
Dense (4 units, Softmax)
    ↓
Output: [can, glass, paper, plastic]
```

### 📈 학습 전략

#### 🎯 1단계: Feature Extraction (20 epochs)
- MobileNetV2 가중치 **고정**
- 상단 분류 레이어만 학습
- Learning Rate: `0.001`

#### 🎯 2단계: Fine-tuning (10 epochs)
- MobileNetV2 상위 레이어 **학습 가능**으로 전환
- Learning Rate: `0.0001` (10배 감소)
- 전체 모델 미세 조정

### 📊 학습 결과

<div align="center">

| 메트릭 | 값 |
|:---:|:---:|
| 🎯 **최종 검증 정확도** | **~92%** |
| 📉 **최종 검증 손실** | **0.32** |
| ⏱️ **추론 시간** | **< 1초** |
| 💾 **모델 크기** | **~9MB** |

</div>

### 🔧 학습 환경

```python
IMG_SIZE = (224, 224)
BATCH_SIZE = 16
EPOCHS = 20 (1단계) + 10 (2단계)
OPTIMIZER = Adam
LOSS = Sparse Categorical Crossentropy
```

---

## 📱 앱 화면 구성

### 🎨 UI 레이아웃

```
┌───────────────────────────────┐
│  🏷️  분리수거 분류             │  ← AppBar
├───────────────────────────────┤
│                               │
│  ┌─────────────────────────┐  │
│  │                         │  │
│  │      📷 이미지 영역      │  │  ← 선택한 이미지 표시
│  │                         │  │
│  └─────────────────────────┘  │
│                               │
│  ┌─────────────────────────┐  │
│  │  🖼️  갤러리에서 선택     │  │  ← 버튼
│  └─────────────────────────┘  │
│  ┌─────────────────────────┐  │
│  │  📸  카메라로 촬영       │  │  ← 버튼
│  └─────────────────────────┘  │
│                               │
│  ┌─────────────────────────┐  │
│  │  📊 분류 결과            │  │
│  │                         │  │
│  │     유리                 │  │  ← 한글 라벨
│  │     영문 라벨: glass     │  │
│  │     신뢰도: 91.45%       │  │
│  │                         │  │
│  │  📋 분리배출 가이드      │  │
│  │  깨지지 않게 주의하고... │  │
│  └─────────────────────────┘  │
└───────────────────────────────┘
```

### 🎨 디자인 컨셉

- **컬러 테마**: 다크 네이비 (`#0B1020`) + 사이안 포인트 (`Colors.cyanAccent`)
- **스타일**: 모던하고 깔끔한 카드 UI
- **반응성**: 로딩 인디케이터로 자연스러운 UX

---

## 💻 핵심 코드 설명

### 🔑 모델 로딩

```dart
Future<void> _loadModelAndLabels() async {
  // TFLite 모델 로드
  final interpreter = await Interpreter.fromAsset(
    'assets/models/trash_classifier.tflite',
  );
  
  // 라벨 파일 로드
  final labelsRaw = await rootBundle.loadString('assets/models/labels.txt');
  final labels = labelsRaw.split('\n').map((e) => e.trim()).toList();
  
  _interpreter = interpreter;
  _labels = labels;
}
```

### 🖼️ 이미지 전처리

```dart
// 224x224로 리사이즈
final resized = img.copyResize(decodedImage, width: 224, height: 224);

// Tensor 변환 (정규화 없이 0~255 그대로)
// ※ 모델 내부에 preprocess_input이 포함되어 있음
final input = List.generate(
  1,
  (_) => List.generate(
    224,
    (y) => List.generate(224, (x) {
      final pixel = resized.getPixel(x, y);
      return [
        pixel.r.toDouble(),
        pixel.g.toDouble(),
        pixel.b.toDouble(),
      ];
    }),
  ),
);
```

### 🤖 AI 추론

```dart
// 출력 텐서 준비
final output = List.generate(1, (_) => List.filled(_labels.length, 0.0));

// 추론 실행
_interpreter!.run(input, output);

// 최고 확률 클래스 찾기
final scores = output[0];
int maxIndex = 0;
double maxScore = scores[0];

for (int i = 1; i < scores.length; i++) {
  if (scores[i] > maxScore) {
    maxScore = scores[i];
    maxIndex = i;
  }
}
```

### 🇰🇷 한글 라벨 변환

```dart
String _toKoreanLabel(String label) {
  switch (label) {
    case 'plastic': return '플라스틱';
    case 'paper':   return '종이';
    case 'glass':   return '유리';
    case 'can':     return '캔';
    default:        return label;
  }
}
```

### 📋 분리배출 가이드

```dart
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
    default:
      return '분리배출 가이드를 찾을 수 없습니다.';
  }
}
```

---

## 📂 프로젝트 구조

```
yolo-flutter-app/
│
├── 📄 README.md                      ← 프로젝트 설명
├── 📄 .gitignore                     ← Git 제외 파일 설정
│
├── 📁 example/                       ← Flutter 앱 프로젝트
│   ├── 📁 lib/
│   │   ├── 📄 main.dart              ← 앱 진입점
│   │   └── 📁 presentation/
│   │       └── 📁 screens/
│   │           └── 📄 trash_classify_screen.dart  ← 🌟 메인 화면
│   │
│   ├── 📁 assets/
│   │   └── 📁 models/
│   │       ├── 🧠 trash_classifier.tflite         ← AI 모델
│   │       └── 📝 labels.txt                      ← 클래스 라벨
│   │
│   ├── 📁 android/                   ← Android 설정
│   ├── 📁 ios/                       ← iOS 설정
│   └── 📄 pubspec.yaml               ← 패키지 설정
│
└── 📁 python/                        ← AI 모델 학습 코드
    ├── 🐍 train_trash_classifier.py         ← 학습 스크립트
    └── 🐍 convert_tflite.py                 ← TFLite 변환
```

---

## 🚀 시작하기

### 📋 사전 요구사항

```
✅ Flutter SDK 3.0 이상
✅ Android SDK 26 이상 (Android 8.0+)
✅ Python 3.8+ (학습 시)
✅ 실제 Android 기기 또는 에뮬레이터
```

### 💻 설치 및 실행

```bash
# 1️⃣ 저장소 클론
git clone https://github.com/본인아이디/trash-classifier-flutter.git

# 2️⃣ 프로젝트 디렉토리로 이동
cd trash-classifier-flutter/example

# 3️⃣ Flutter 패키지 설치
flutter pub get

# 4️⃣ 앱 실행 (USB로 폰 연결 후)
flutter run
```

### 🧠 모델 학습 (선택사항)

직접 모델을 학습시키고 싶다면:

```bash
# 1️⃣ Python 패키지 설치
pip install tensorflow matplotlib scikit-learn pillow

# 2️⃣ 데이터셋 준비
# Sample 폴더에 아래와 같이 구성:
# Sample/
#   ├── can/      (이미지들)
#   ├── glass/    (이미지들)
#   ├── paper/    (이미지들)
#   └── plastic/  (이미지들)

# 3️⃣ 학습 실행
python train_trash_classifier.py

# 4️⃣ 생성된 모델을 Flutter 앱에 복사
# trash_classifier.tflite → example/assets/models/
# labels.txt              → example/assets/models/
```

---

## 🐛 개발 중 겪은 이슈

### 1️⃣ TFLite 양자화 문제
- **문제**: 양자화된 모델이 정확도 저하 발생
- **해결**: `tf.lite.Optimize.DEFAULT` 제거, float32 유지

### 2️⃣ 전처리 불일치
- **문제**: Keras 모델은 잘 되는데 Flutter에서 오분류
- **해결**: 모델 내부에 `preprocess_input`이 포함되어 있어 Flutter에서는 정규화 없이 0~255 그대로 전달

### 3️⃣ 클래스 불균형
- **문제**: 초기에 trash 클래스 100장 vs 다른 클래스 500장 → 편향
- **해결**: trash 클래스 제외 후 4개 클래스만 사용

### 4️⃣ tflite_flutter 버전 호환성
- **문제**: Dart 3.x와 tflite_flutter 0.10.x 호환성 이슈
- **해결**: tflite_flutter 0.11.0 이상 사용

---

## 📊 성능 벤치마크

<div align="center">

| 항목 | 측정값 |
|:---:|:---:|
| 🎯 정확도 | **92%** |
| ⚡ 추론 속도 | **< 1초** |
| 💾 앱 크기 | **~30MB** |
| 🧠 모델 크기 | **9MB** |
| 📱 최소 Android | **8.0 (API 26)** |

</div>

---

## 🎯 향후 계획

- [ ] 🌐 iOS 지원 추가
- [ ] 🔄 실시간 카메라 스트림 분류
- [ ] 📊 분류 이력 저장 및 통계
- [ ] 🗺️ 근처 재활용 센터 위치 안내
- [ ] 🌏 다국어 지원 (영어, 일본어)
- [ ] 📦 더 많은 카테고리 추가 (비닐, 스티로폼 등)
- [ ] 🎨 다크 모드 / 라이트 모드 토글

---

## 🤝 기여하기

이 프로젝트에 기여하고 싶으시다면:

```bash
# 1. Fork 하기
# 2. 기능 브랜치 만들기
git checkout -b feature/멋진기능

# 3. 변경사항 커밋
git commit -m "✨ 멋진 기능 추가"

# 4. 브랜치 푸시
git push origin feature/멋진기능

# 5. Pull Request 열기
```

---

## 📄 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다.

---

## 🙏 참고 자료

- 📚 [TensorFlow Lite 공식 문서](https://www.tensorflow.org/lite)
- 🐦 [Flutter 공식 문서](https://flutter.dev/docs)
- 🧠 [MobileNetV2 논문](https://arxiv.org/abs/1801.04381)
- 📦 [tflite_flutter 패키지](https://pub.dev/packages/tflite_flutter)
- 🗑️ [TrashNet 데이터셋](https://github.com/garythung/trashnet)

---

<div align="center">

### 💚 지구를 위한 한 걸음

**올바른 분리수거로 더 깨끗한 환경을 만들어요!**

Made with ❤️ and ☕

⭐ 이 프로젝트가 도움이 되었다면 Star를 눌러주세요! ⭐

</div>
