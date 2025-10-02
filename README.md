# <img width="40" height="40" alt="icon-ios-20x20@2x" src="https://github.com/user-attachments/assets/2a48c534-07de-4a16-926e-a4318b0a602d" />&nbsp; MyContacts-iOS

## Swift로 연락처 앱 만들기

## 프로젝트 소개

**PokeAPI**를 활용한 iOS 연락처 앱입니다.

서버와의 통신으로 랜덤 이미지를 받아 프로필 사진으로 지정하고, 코어데이터를 사용해서 기기 내에 이름과 전화번호를 저장/관리할 수 있습니다.

>**API**: https://pokeapi.co/

---
## 실행 화면

|`연락처 저장`|`연락처 편집`|`연락처 삭제`|
|-------|-------|-------|
|<img src="https://github.com/user-attachments/assets/00bff053-2dcf-474b-9b21-ec2ad2f9152a" width="286" height="600">|<img src="https://github.com/user-attachments/assets/92aeb1cf-a5bd-46d4-b361-1f0e85f9317b" width="286" height="600">|<img src="https://github.com/user-attachments/assets/7a728443-777a-4dd6-beb0-494166bbe017" width="286" height="600">|

---
## Development Environment 🛠 

![iOS Version](https://img.shields.io/badge/iOS-18.5-lightgrey.svg?style=for-the-badge&logo=apple&logoColor=white)&nbsp;&nbsp;&nbsp;![Xcode Version](https://img.shields.io/badge/Xcode-16.4-blue.svg?style=for-the-badge&logo=xcode&logoColor=white)&nbsp;&nbsp;&nbsp;![Swift Version](https://img.shields.io/badge/Swift-6.1.2-orange.svg?style=for-the-badge&logo=swift&logoColor=white)


---
## Skills & Tech Stacks 🐈  
- Swift
- UIKit
- Snapkit
- CoreData
- URLSession
- MVC

---
## 트러블 슈팅

[**위키 페이지 💬**](https://github.com/hemssy/MyContacts-iOS/wiki/트러블슈팅)

---
## 📂 Foldering
```bash

myContacts/
├── 📁myContacts/
│   ├── 📁Controller/
│   │   ├── PhoneBookViewController.swift
│   │   └── ViewController.swift
│   │
│   ├── 📁Delegate/
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   │
│   ├── 📁Model/
│   │   ├── CoreDataStack.swift
│   │   └── PhoneBookModel.xcdatamodeld
│   │
│   ├── 📁Resources/
│   │   ├── Assets.xcassets
│   │   └── LaunchScreen.storyboard
│   │
│   ├── 📁Utils/
│   │   └── PokemonAPI.swift
│   │
│   ├── 📁View/
│   │   └── ContactCell.swift
│   │
│   └── Info.plist
│
└── 📦Package Dependencies/
    └── SnapKit 5.7.1

