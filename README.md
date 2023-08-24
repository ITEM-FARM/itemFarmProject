# ITEM FARM _ [3PL] 물류대행 플랫폼
![badge](https://img.shields.io/github/repo-size/ITEM-FARM/itemFarmProject)
![badge](https://img.shields.io/github/languages/top/ITEM-FARM/itemFarmProject)
![GitHub contributors](https://img.shields.io/github/contributors/ITEM-FARM/itemFarmProject)
![GitHub commit activity](https://img.shields.io/github/commit-activity/w/ITEM-FARM/itemFarmProject) <br/>
<img src="https://img.shields.io/github/forks/ITEM-FARM/itemFarmProject?style=social" />
<img src="https://img.shields.io/github/watchers/ITEM-FARM/itemFarmProject?style=social" />
![GitHub Repo stars](https://img.shields.io/github/stars/ITEM-FARM/itemFarmProject?style=social)

## 목차
- [1️⃣프로젝트 개요](#1️⃣프로젝트-개요)
- [2️⃣개발환경](#2️⃣개발환경)
- [3️⃣시스템 개요](#3️⃣시스템개요)
- [4️⃣테이블구조](#4️⃣테이블구조)
- [5️⃣시스템 구조](#5️⃣시스템구조)
- [6️⃣프로그램 화면](#6️⃣프로그램화면)
- [7️⃣중요 소스코드](#7️⃣중요소스코드)

## 1️⃣프로젝트 개요
자사 물류 센터를 직접 운영할 수 없는 중소기업 또는 스타트업을 대상으로 3PL 플랫폼을 구축하여 상품 등록부터 발주, 입/출고까지 전반적인 물류 시스템을 제작한다.
특히, 자동화 환경에 초점을 두어 물류 재고 파악의 정확도를 높인다.
또한, 고객사가 마케팅과 같은 판매 업무에 더욱 집중할 수 있도록 매출 통계 서비스를 추가적으로 제공한다.

## 2️⃣개발환경
<table>
  <tbody>
    <tr>
      <th>Language</th>
      <td>
        <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white">
        <img src="https://img.shields.io/badge/sql-4479A1?style=for-the-badge">
        <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
        <img src="https://img.shields.io/badge/jsp-de2b2f?style=for-the-badge&logo=java&logoColor=white">
      </td>
    </tr>
    <tr>
      <th>Tool</th>
      <td>
        <img src="https://img.shields.io/badge/eclipse-2C2255?style=for-the-badge&logo=eclipseide&logoColor=white">
        <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
        <img src="https://img.shields.io/badge/Mockaroo-52a553?style=for-the-badge&logoColor=white">
      </td>
    </tr>
    <tr>
      <th>DataBase</th>
      <td>
        <img src="https://img.shields.io/badge/MySQL 8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
      </td>
    </tr>
    <tr>
      <th>Server</th>
      <td>
        <img src="https://img.shields.io/badge/Apache Tomcat 9.0-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black">
      </td>
    </tr>
     <tr>
      <th>Library</th>
      <td>
        <img src="https://img.shields.io/badge/chart.js-FF6384?style=for-the-badge&logo=chartdotjs&logoColor=white">
        <img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
        <img src="https://img.shields.io/badge/JSTL-E8E8E8?style=for-the-badge">
        <img src="https://img.shields.io/badge/POI3.7ver-E8E8E8?style=for-the-badge">
      </td>
    </tr>
  </tbody>
</table>

## 3️⃣시스템개요
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/dfbb7aab-1c1f-461e-bdfe-16e48e6609d3" width="70%"/><br/>
### 3PL(Third Party Logistics)이란
제 3자가 관여하는 물류대행 서비스이다. 회사에서 발생하는 물류 업무를 외부 물류 전문 업체에게 아웃소싱하여 물류 서비스를 제공받는다.

### 시스템 기능
|분류|기능|비고|
|:------|:------|:------|
|로그인|3PL 관리자, 고객사 로그인|비활성화된 고객사는 로그인 X, <br/> 고객사 로그인 시 기업관리, 입고관리 메뉴는 보이지 않음.|
|고객사 관리|고객사 기업 등록/조회/수정/비활성화 기능|활성화,비활성화 여부에 따른 필터링 기능 구현, <br/> 삭제 기능 대신 비활성화 기능으로 안정성 고려.|
|상품 관리|고객사 상품 등록/조회/수정/비활성화 기능|상품 활성화, 비활성화 여부에 따른 필터링 기능 구현, <br/> 삭제 기능 대신 비활성화 기능으로 안정성 고려.|
|발주 관리|자동 발주 상품 목록 조회, <br/> 발주 상품 등록/상세조회 기능| 안전재고 > 현재재고 상태의 상품들만 자동 발주 상품 목록에 뜨도록 구현. <br/> 발주코드는 B-기업코드-시퀀스(날짜)로 생성 하여 Unique성 고려.|
|입고 관리|발주서 연동 자동 입고 등록 기능, <br/> 상품별 수동 입고 등록 기능, <br/> 수동입고를 위한 상품 통합 검색 기능, <br/> 입고 품목 수정,삭제,확정 기능, <br/> 확정 입고 내역 조회 기능|발주서 연동 시 재확인을 위한 상세 조회 기능 추가. <br/> 입고 코드는 I-기업코드-시퀀스(날짜)로 생성하여 Unique성 고려. <br/> 각 처리 시 확정여부를 다시한번 묻는 모달창 생성.
|출고 관리|주문건 수동 등록, 자동 등록 기능, <br/> 주문건 상세 조회 기능|주문건 자동 등록은 엑셀 파일 업로드시 자동 등록 되도록 구현, <br/> 출고 코드는 O-기업코드-시퀀스(날짜)로 생성하여 Unique성 고려.|
|입출고 내역 조회|입/출고 내역 조회 기능|입고/출고 별 필터링 기능 구현.|
|통계서비스| 기간별, 카테고리별, 상품별 매출 통계 기능 | 표와 차트 동시 제공. <br/> 고객기업사가 물류 이외의 다른 업무에 집중할 수 있도록 매출 통계 부가서비스를 제공하여 다른 3PL 플랫폼과의 차별성을 둠. |


## 4️⃣테이블구조
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/361a548a-b118-4fd5-b541-a7cf170cdacc" width="70%" />

## 5️⃣시스템구조
### 1) 메뉴구성도
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/0b60f2e9-2dac-4a35-840c-a56d4323269d" width="70%" />

### 2) 시스템 구조(IA)
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/8a6144bd-a521-4822-888b-3e7deb9a580d" width="70%" />

## 6️⃣프로그램화면
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/a6d623e1-b4de-4bdf-a9af-3b02c0f2fbd1" width="70%"/> <br/>
<a href="https://youtu.be/vxyvumJXXcE">유튜브 링크</a>

## 7️⃣중요소스코드
### 1) 입고 트리거
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/4e1b01d0-d505-459a-a368-d15321639f50" width="70%"><br/>
(부가 설명)

### 2) 통합 검색 cast
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/8f9a4f38-d05c-4321-a2eb-397008572b22" width="70%"><br/>
(부가 설명)

### 3) 체크박스 - 전체 선택
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/007f86b1-db3c-490e-ae87-d7be206f6272" width="70%"><br/>
(부가 설명)

### 4) 입고 품목 확정 리스트 확정 전, 리스트에서 삭제하는 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/7165e2ca-7133-4ee3-bf84-8d22ad8b7aa9" width="70%"><br/>
(부가 설명)

### 5) 입고 품목 최종 확정 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/4401b70c-e368-4fa6-a951-94ef7da5fb1a" width="70%"><br/>
(부가 설명)

### 6) 엑셀파일 업로드 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/926bc683-fe37-4dfc-9aa5-83fced2b796c" width="70%">
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/ed35359e-4820-4a0b-b201-a5e9abdd7130" width="70%"><br/>
[출고관리 - 주문건등록] <br>
3PL 직원이 고객기업 측에서 보낸 주문건을 등록하는 방법에는 2가지가 있습니다.<br>
첫째, 단 1건의 주문등록 - 직원이 고객과 주문정보를 일일이 입력하여 등록하는 방법<br>
둘째, 여러 건의 주문등록 - 고객기업 측에서 보낸 엑셀 데이터를 업로드하여 등록하는 방법<br>
<br>
위 로직은 두번째 방법을 구현한 코드입니다.  <br>
(엑셀 데이터 예시 : [Samsung_김신한씨.xlsx](https://github.com/ITEM-FARM/itemFarmProject/files/11471278/Samsung_.xlsx)) <br>
기업 측에서 위 양식대로 주문 정보를 입력하여 보내면 다량의 주문건을 손쉽게 등록할 수 있습니다.

### 7) 송장 입력 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/022793fb-dc31-42b5-837b-6aef2cd6d4d0" width="70%"><br/>
[출고관리 - 주문건조회] <br>
'송장입력' 버튼을 누르고 => 입력할 주문건을 체크 => '입력저장' 버튼을 누르면 <br>
(1)송장번호와 출고일자가 찍히고 주문상태는 '출고완료'로 바뀝니다. <br>
(2)따라서 그에 해당하는 재고가 감소하게끔 로직을 짰습니다. <br>
<br>
'주문취소', '취소저장' 버튼에 대한 로직도 위와 비슷합니다. 

### 8) 매출 통계 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/f924fb83-95e5-4903-be7b-a02c4ce89241" width="70%">
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/b746679a-c1e3-498a-a410-c969ac4aa02e" width="70%"><br/>
[마케팅 리포트] <br>
각 기업마다 '일별', '카테고리별', '상품별' 매출 및 순이익 등에 대한 통계자료를 한눈에 보여주도록 하였습니다. <br>
이는 위 '7)송장입력 및 주문취소'의 연장선상으로 주문완료 또는 주문취소 수량과 그에 대한 매출/순이익을 한 테이블에 보여줍니다. <br>
보다 가시성을 높이기 위해 chart.js를 이용하여 그래프도 도입하였습니다. <br>
<br>
특이사항으로 위 로직을 짤 때 full outer join을 해야 했는데, 저희는 MySQL을 사용했기 때문에 union이라는 문법을 써서 해결했습니다.

### 9) NAV바 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/591a033a-cd6d-41be-8de0-3da94853fcc3" width="70%"><br/>
페이지마다 nav 바를 활성화하기 위해 주소창을 불러와 nav 링크 주소와 비교했습니다.

### 10) 조회 기업 변경 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/79661a06-27c4-48ad-956a-80ce67c38061" width="70%"><br/>
3PL이 조회 기업을 변경할 때마다 기업 변경 컨트롤러로 이동해 세션에 기업 정보를 저장했습니다.

### 11) 시퀀스 생성
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/fd697251-d98f-47ec-a706-260091551578" width="70%"><br/>
MySQL에는 시퀀스가 존재하지 않기 때문에 procedure, function을 이용해 기업, 상품을 위한 별도의 시퀀스를 생성했습니다.

### 12) 모달 객체 생성 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/049ff783-49b1-4a29-b17d-211d91d37aac" width="70%"><br/>
기업, 상품 수정 시 현재 정보를 모달 창에 그대로 보이기 위해 자바스크립트 객체 형태로 받아 조건에 따라 모달 창에 정보를 채웠습니다.

### 13) 입출고 날짜 처리 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/9ee1b4b9-3a7e-4b66-b72d-544f00d53aa0" width="70%"><br/>
입고, 출고 데이터를 하나의 테이블에 함께 보이기 위해 입고인 경우, 출고인 경우로 나눠 칼럼을 설정하였습니다. 또한 첫 번째로 날짜 기준 내림차순, 두 번째로 상품 번호 기준 오름차순 정렬을 위해 compareTo를 재정의했습니다. 

### 14) Chart.js를 이용한 통계 그래프 생성 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/28faf0e4-983d-4f73-b2f4-b9cbf0f20070" width="70%"><br/>
table에 담겨있는 데이터를 JQuery를 이용해 배열 형태로 저장한 후, Chart.js를 이용해 막대그래프와 꺾은선 그래프로 그려냈습니다.

### 15) 필터링 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/8962b8ee-447e-4fab-a688-7c5a25a4f117" width="70%"><br/>
Servlet Filtering을 이용해 로그인을 하지 않을 경우 index 화면 이외의 내부 서비스에 접근할 수 없도록 구현하였습니다.

### 16) 사용자 유형별 세션 저장
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/35c3c8eb-a3b9-4e6d-b74a-822f0f10295d" width="70%"><br/>
세션 저장 시 3PL과 고객 기업 중 어떤 사용자가 로그인을 했는지에 따라 다른 세션에 저장시켜 해당 유형의 사용자가 이용가능한 화면이 보여지도록 구현하였습니다.<br/>
또한 비활성화된 기업은 로그인 화면에서 넘어가지 못하도록 구현하였습니다.

### 17) 페이지네이션 체크박스 onclick 이벤트 issue
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/d203c8cf-33b1-4757-a1dc-84dbb30921de" width="70%"><br/>
부트스트랩을 이용해 페이지네이션 기능이 있는 테이블에서 한 row의 데이터를 체크박스 onclick이벤트를 이용해 가져오려고 할 때, <br/>
첫번 째 페이지네이션 이외의 페이지들은 disable 되어 있는 상태라 데이터가 가져와지지 않은 issue가 있었습니다.<br/>
이벤트를 등록할 시, 페이지가 load된 후의 row 컬럼에 접근하는 것이 아니라 row 컬럼 자체에 onclick 이벤트를 등록하는 것으로 수정하여<br/>
disable 여부 상관업시 row 자체에 이벤트처리가 되어 데이터를 가져오도록 하여 해결할 수 있었습니다.

### 18) Ajax를 이용해 JSON 배열을 서블릿에 보내 파싱하는 로직
<img src="https://github.com/ITEM-FARM/itemFarmProject/assets/49816869/7955f47c-e95a-4eca-b64a-63cf10046b6f" width="70%"><br/>
체크박스로 가져온 데이터를 ajax로 JSON 배열처럼 만들어 서블릿에 보낸 후, 서블릿에서 JSONAraay와 Object로 만들어 원하는 데이터를 얻을 수 있도록 파싱하는 로직입니다.
