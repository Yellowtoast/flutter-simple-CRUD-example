# 금융기술팀 Flutter 사전 과제전형

## 과제전형 안내

전체 4개의 페이지로 되어있는 간단한 CRUD App 입니다.<br/>
각 페이지의 요구사항에 맞춰 UI 로직과 Controller를 구현하면 됩니다.<br/>
Package 및 Code generation은 자유롭게 사용 가능합니다.

### 안내사항
    - TODO를 따라 각 Page 및 Controller의 요구사항을 작성하시면 됩니다.
    - 제시된 TODO를 모두 구현하지 않으셔도 되며, 제한시간 내에서 최대한 작성해주시면 됩니다.
    - 제출 시 발송자 메일로 회신 부탁드립니다.
    - 회신 시, 작성한 코드 압축파일을 첨부하여 회신 부탁드립니다 (압축 시, 프로젝트 루트 경로에서 flutter clean 후, 압축 및 첨부 부탁드립니다).


<br/>

### UI 공통 구현사항
    - 명시된 로직에 따라 요구사항에 맞게 UI가 보여져야 됩니다.
    - 기기의 가로 화면에서도 UI가 오류 없이 보여져야 합니다.
    - 요구사항 이외에 Widget은 자유롭게 작성 가능합니다.
    - LoginPage 의 경우 test 작성이 포함되어 있습니다.

<br/>

### Controller 공통 구현사항
    - Bloc, GetX, Provider 등 익숙하게 다룰 수 있는 상태관리를 이용해 자유롭게 작성 가능합니다.
    - 각 Controller에 명시된 Repository를 인자로 가져야 합니다.
    - 해당 Controller의 동작에 따라 요구사항에 맞게 UI가 바뀌어야 합니다
    - LoginController 의 경우 test 작성이 포함되어 있습니다.

### Test 공통 구현사항
    - Test Case의 요구사항 내에서 구현한 UI, Controller에 따라 자유롭게 작성 가능합니다.