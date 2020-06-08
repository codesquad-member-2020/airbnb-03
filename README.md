<h1 align="center">
  Airbnb
</h1>
<p align="center">

<p align="center">
 <img src="https://img.shields.io/badge/platform-iOS-9cf.svg">
 <p align="center">에어비앤비 서비스 일부를 똑같이 만들어 보는 프로젝트</p>
</p>

<br>

## 🍔 TEAM

#### 든든한 백엔드

- [Alex 🚌](https://github.com/haveagood)
- [Hamill 🏂](https://github.com/Hamill210)

#### 꼼꼼한 iOS

- [Cory 🦊](https://github.com/corykim0829)
- [모스 👽](https://github.com/kjoonk)

<br>

## 📝 Ground Rule

### Branch 관리 컨벤션

- `master`: Code Freeze 때 릴리즈되는 브랜치
- `dev`: 각 클래스 별 기능 완료 시 PR보내는 브랜치, default 브랜치로 설정
- `dev-be`,`dev-ios`
- `feat/{class}/{contents}`: 기능 단위로 브랜치 클래스 분류해서 설정
  - Ex. feat/be/make-skeleton-code
  - 기능 단위 브랜치는 `dev` 로 머지 후에 삭제한다.
- `master`, `dev` 는 배포를 위해서 동작하는 상태의 산출물이 있어야합니다.

### 배포

- develop 브랜치에 deploy 브랜치를 만들어서 배포를 진행한다.

### 커밋 컨벤션 가이드

#### [**Header] Commit Type**

| 타입     | 설명                                |
| -------- | ----------------------------------- |
| feat     | 새로운 기능 추가                    |
| fix      | 버그, 에러 수정                     |
| refactor | 코드 리팩토링                       |
| style    | 코드 포맷팅 (코드 변경이 없는 경우) |
| modify   | 수정                                |
| chore    | 빌드 스크립트 수정 등의 기타 작업   |

#### [ClassName] {Commit Type}: Subject

변경된 내용 요약

#### [**Body]**

자유로운 커밋 메서지 작성

#### [**Footer]**

- issue: #이슈번호
- close,fix,resolved:

```
    [Class Name] {Commit Type}: Subject
    [iOS],[BE]
    
    body - 커밋 내용
    
    footer - issue 번호 작성
```

```
    [iOS] feat: index page 구현
    
    - 자유롭게 작성
    
    issue: #1
    close, fix, resolved: #2
```
### iOS Ground Rule

- [iOS README](https://github.com/codesquad-member-2020/airbnb-03/blob/dev/iOS/README.md)

<br>

## 📃 API Documentation

[API Documentation](https://documenter.getpostman.com/view/10764927/SzmmUuWY?version=latest)
