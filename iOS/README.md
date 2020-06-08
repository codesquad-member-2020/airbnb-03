# 👨🏻‍💻 Airbnb - iOS Ground Rule

[🗒 요구사항 기술서](https://docs.google.com/spreadsheets/d/16KADEgGEA3QFg9AMztSqdLGoR4wPMbWns9SoLhhbfHg/edit#gid=0)

<br>

## 🤖 컨벤션

- ViewController는 코드로 구현한다.
- View는 XIB로 구현하여 관리한다.
- 클래스 하나에 파일 하나를 갖도록 한다.
- 파일 생성시 자동으로 추가되는 주석들은 모두 제거한다.
- 상속을 하지 않을 class는 final class로 선언한다.
- class의 첫줄은 개행으로 유지한다. extension, struct는 개행없이 코드를 작성한다.
- 그 외에 Swift 코드 스타일은 다음 컨벤션을 따른다.
  - [스타일 쉐어 코드 컨벤션](https://github.com/StyleShare/swift-style-guide#%EC%A4%84%EB%B0%94%EA%BF%88)


### 📂 폴더 구조

- 기능단위로 폴더를 나눈다.
- 해당 기능 폴더 안에서 아래와 같이 폴더를 나눈다.
  - Views/Models/ViewControllers


### ✅ PR 리뷰

- dev-ios로 PR을 요청시에는 서로에게 review 요청한다.
- dev로 PR을 요청할 때 JK에게 review 요청한다.


### 📑 이슈 및 PR 관리
- 너무 크지 않게 이슈를 생성한다. (충돌 방지)
- PR도 GitHub Repository 프로젝트에 추가한다.


### ⏱ 마일 스톤
- 기본적으로 ViewController 단위로 마일스톤을 정한다.


### 💥 소스 충돌 방지
아래와 같은 요소들은 수정 하기 전 상의한다.
- 프로젝트 설정, info.plist, Assets
- storyboard, XIB 수정