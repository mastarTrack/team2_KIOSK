# ☕️ 칼퇴카페 키오스크 (iOS)

Swift로 개발한 **카페 키오스크 형태의 iOS 애플리케이션**입니다.  
로컬 JSON 파일을 기반으로 커피 메뉴를 불러오고, 메인화면에서 메뉴선택 → 옵션 선택 → 장바구니 담기 → 가격 계산까지의 흐름을 구현했습니다.

---

## 🧾 프로젝트 소개

**칼퇴카페 키오스크**는  
iOS UIKit 기반으로 키오스크 주문 플로우를 직접 설계·구현하며  
**MVVM 구조, 커스텀 UI 컴포넌트, 데이터 흐름 관리**를 학습하기 위해 제작된 프로젝트입니다.

- 네트워크 없이 **로컬 JSON 데이터** 사용
- **CollectionView 중심 UI 구성**
- **MVVM 패턴 적용**
- 실제 키오스크 주문 UX를 고려한 화면 구성

---

## 🛠 기술 스택

- **Language**: Swift  
- **UI Framework**: UIKit  
- **Architecture**: MVVM
- **Data Source**: Local JSON  
- Package
  - **Layout**: SnapKit
  - **Image Loading**: Kingfisher
  - **Utility**: Then

---

## 📁 프로젝트 구조
```
CafeKIOSKApp
├── Data
│ └── CoffeeMenu.json
│
├── Model
│ ├── CartModel.swift
│ └── CoffeeModel.swift
│
├── Service
│ └── CoffeeMenuDataService.swift
│
├── Util
│ ├── LabelConfiguration.swift
│ ├── StringUtils.swift
│ ├── UIButton+.swift
│ └── UILabel+.swift
│
├── View
│ ├── CartBottomView.swift
│ ├── CartTopView.swift
│ └── CartTableViewCell.swift
│ └── MainBottomView.swift
│ └── MainMenuCollectionView.swift
│ └── MaimMenuSectionView.swift
│ └── MenuDescriptionView.swift
│ └── MenuIceHotView.swift
│ └── MenuOptionCheckView.swift
│ └── MenuOptionOrderView.swift
│ └── MenuOptionStapperView.swift
│ └── optionCheckCell.swift
│ └── optionDescriptionCell.swift
│ └── optionIceHotCell.swift
│ └──  optionStapperCell.swift
│
├── ViewModel
│ └── MainMenuViewModel.swift
│ └── MenuOptionViewModel.swift
│
└── ViewController
│ ├── MainMenuViewController.swift
│ ├── MenuOptionViewController.swift
│ └── CartTableViewController.swift
```

## 📂 구조 설명

### Data
- **CoffeeMenu.json**  
  커피 메뉴, 옵션, 가격 정보를 담고 있는 로컬 데이터 파일

### Model
- **CoffeeModel**  
  커피 메뉴 정보를 표현하는 모델
- **CartModel**  
  장바구니 상태 및 선택된 옵션 데이터 관리

### Service
- **CoffeeMenuDataService**  
  로컬 JSON 로드 및 디코딩 담당

### Util
- 공통 UI 설정 및 문자열/버튼/라벨 확장
- 중복 코드 제거 및 UI 일관성 유지 목적

### View
- 재사용 가능한 **커스텀 View 컴포넌트**
- 각 화면에 알맞게 커스텀 뷰를 제작
- 재사용에 용이하게 구현

### ViewModel
  - View와 비즈니스 로직 분리

### ViewController
- 화면 전환 및 View–ViewModel 연결

---

## 🔄 데이터 흐름

1. 앱 실행  
2. `CoffeeMenuDataService`에서 로컬 JSON 로드  
3. JSON 데이터를 `CoffeeModel`로 디코딩  
4. `MainMenuViewController` → CollectionView에 메뉴 표시  
5. 메뉴 선택 → 옵션 상세 화면 이동  
6. 옵션 선택 후 장바구니 담기  
7. 메인 화면 복귀 시 장바구니 UI 리프레시  

---

## ✨ 주요 기능

- 로컬 JSON 기반 커피 메뉴 로딩
- CollectionView를 활용한 메뉴 리스트 UI
- 옵션 선택(샷 추가, 수량 증감 등)
- Min / Max 조건에 따른 버튼 활성화 제어
- 장바구니 담기 및 가격 계산
- 네비게이션 기반 화면 전환

---

## 🎯 구현 포인트

- **MVVM 패턴 적용**
  - View와 비즈니스 로직 분리
- **커스텀 View 설계**
  - 각 뷰를 커스텀화하여 재사용에 용이하게 설계 및 구현
- **Closure 기반 이벤트 처리**
  - 버튼 액션 → ViewModel 전달
- **SnapKit 기반 코드 UI 구성**
- **화면 복귀 시 상태 동기화 처리**

---

## 👤 Author

- **팀장**: 장예슬  
- **팀원**: 김주희, 한주헌  

iOS Developer (Swift)

---
