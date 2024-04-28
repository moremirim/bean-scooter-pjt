# Table of Contents
1. [Description](#description)
2. [Period](#period)
3. [Demo](#demo)
4. [Features](#features)
5. [Requirements](#requirements)
6. [Stacks](#stacks)
7. [ProjectStructure](#projectStructure)
8. [Developer](#developer)

# Bean Mobility Korea

킥보드 렌탈이 가능한 Bean App!

## Description

주변에 대여 가능한 킥보드를 확인하고, 대여까지! 간편한 결제 방식과 그 외에 여러 기능들을 경험해보세요!

## Period

- 24.04.22
    - Project 아이디어 회의 및 기본 기능 구현
        - 상품 표시, 담은 물품 표시

- 24.04.23
    - 각종 버튼 기능 구현 (주문하기, 문의하기, 주문취소)
    - 추가 기능 회의

- 24.04.24
    - 기존 UI 디자인 변경 및 추가 기능 구현
        - TabBar 추가 (홈, 상품, 마이페이지, 고객센터로 세분화)
        - Modal View로 장바구니 화면 별도 구현
        - Notification Badge형식 구현
        - App Icon 등록

- 24.04.25
    - 홈 화면 기능 및 디자인
    - 고객센터 페이지 구현
    - 상품페이지 SearchBar 기능 구현
      
- 24.04.26
    - 고객센터 내 매장찾기 기능 추가 (지도구현)
    - 마이페이지 구현
    - 새로 출시된 제품 구분 기능 추가

- 24.04.27
    - 제품 상세페이지 기능 구현
    - Launch Screen 디자인

- 24.04.28
    - UI 및 기능 최종 점검 


## Demo
<p float="left">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/4328ddbc-937e-4d0b-b486-94bc2456d561" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/dc57391b-8139-45b1-9490-d5648d936c26" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/04ccb255-e4c1-421a-9f63-ae2c97625602" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/d83aa43d-ee09-46ac-b334-893e54f77bce" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/1a253df5-752a-4ee1-8235-81f2a2d3b2f4" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/d8a00b9d-3c8d-4f8e-ac0d-396728440321" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/30b3d22e-438f-47dd-afcf-2747f44e3540" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/75054b95-e74b-44d8-917f-a1c51bee3ef1" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/d7a86600-13e5-475d-b0e1-ad79b0c86880" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/cd26f2d3-1c85-4de5-8af2-2ebf15f44701" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/22fda91e-76f3-449e-b54c-09f77ce2a9b4" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/42eee60f-fde2-48d7-aa5e-ba55094ec40c" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/9b0063e2-2dba-4280-9ac8-e5b3bbdde1c3" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/79cbf6a3-10bf-4350-9244-fbf7dfddcbc9" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/01fd8e86-79bd-4bf1-9243-cfac5c930419" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/ba6ece38-ef79-4b76-b668-f4a03e596cae" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/5ed6ee28-732b-4fc8-980f-b99511352d81" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/987eafa9-b99a-4b75-96de-af06ef8d0108" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/36af0180-e963-4c4a-b4bd-ee12e99bd4d3" width="200" height="430">
<img src="https://github.com/moremirim/bean-scooter-pjt/assets/160707647/a5293592-0476-4868-81c0-c2ea4f64363a" width="200" height="430">
</p>

## Features
### 로그인
- 회원 정보 가입을 통해 로그인

### 지도
- 유저의 현재 위치와 주변 킥보드 확인

### 킥보드 대여
- 대여 가능한 거리(150m)에 위치한 킥보드 대여
- 대여 후 반납

### 결제
- 주행한 거리만큼 가격을 지불

### 마이페이지
- 회원 정보 수정
- 주행 기록
- 주행 가이드
- 친구 추천
- 쿠폰 등록
- 로그아웃

### 관리자 계정을 통한 관리
- admin으로 로그인 할 시 별도의 Manage 페이지를 통해 킥보드 등록 / 삭제 관리

## Requirements
- App requires **iOS 17.4 or above**

## Stacks
- **Environment**

    <img src="https://img.shields.io/badge/-Xcode-147EFB?style=flat&logo=xcode&logoColor=white"/> <img src="https://img.shields.io/badge/-git-F05032?style=flat&logo=git&logoColor=white"/>

- **Language**

    <img src="https://img.shields.io/badge/-swift-F05138?style=flat&logo=swift&logoColor=white"/> 

- **API**

    <img src="https://img.shields.io/badge/-Kakao-FFCD00?style=flat&logo=Kakao&logoColor=white"/>

- **Communication**

    <img src="https://img.shields.io/badge/-Slack-4A154B?style=flat&logo=Slack&logoColor=white"/> <img src="https://img.shields.io/badge/-Notion-000000?style=flat&logo=Notion&logoColor=white"/>

## Project Structure

```markdown
Bean
├── Singleton
│   ├── RecordSingleton
│   └── SavedPinSingleton
│
├── Service
│   ├── CoordGenerator
│   └── MapManager
│
├── Model
│   ├── AccountInfo
│   ├── AcountModel
│   ├── CouponModel
│   ├── GuideModel
│   ├── MapModel
│   ├── ProfileModel
│   ├── RecordModel
│   └── PinModel.xcdatamodeld
│
├── View
│   ├── CouponCollectionViewCell
│   ├── GuideTableViewCell
│   ├── ProfileTableViewCell
│   ├── RecordTableViewCell
│   ├── ScooterManagerTableViewCell
│   ├── LaunchScreen.storyboard
│   └── Main.storyboard
│
├── Controller
│   ├── CouponViewController
│   ├── EditProfileViewController
│   ├── GuideViewController
│   ├── InviteFriendsViewController
│   ├── LaunchViewController
│   ├── MapViewController
│   ├── ModalViewController
│   ├── ProfileViewController
│   ├── RecordTableViewController
│   ├── ScooterManageViewController
│   ├── SignInViewController
│   ├── SignupViewController
│   ├── TabbarViewController
│   └── PayViewController
│
├── Assets
└ 
```


## Developer
*  **박중권** ([jungkweon93](https://github.com/jungkweon93))
    - 애플 지도 생성
    - 현재 위치 이동 기능
    - Launch Screen 기능 구현
    - 쿠폰 페이지 구현
*  **박미림** ([moremirim](https://github.com/moremirim))
    - Project Merge 구현
    - 대여 기능 구현
    - 전체적인 UI Design
    - 결제 페이지 구현 
*  **송동익** ([Haroldfromk](https://github.com/haroldfromk))
    - 반납 기능 구현
    - Annotation Pin 구현
    - 거리 계산 로직 구현
    - Dummy Data 생성
*  **조희라** ([Heather-Cho](https://github.com/Heather-Cho))
    - 로그인, 회원가입 페이지 구현
    - 회원정보 수정 페이지 구현
    - Userdefault를 사용한 회원 정보 저장
    - 친구초대 페이지 구현
*  **채나연** ([Nayeon Chae](https://github.com/NY-Chae))
    - 마이페이지 구현
    - 주행가이드 페이지 구현
    - 로그아웃 기능 구현
    - 프로젝트내 필요한 이미지 구성
