# DatabaseProgramming
데이터베이스 프로그래밍 수업. 수강신청 프로젝트

<img width="881" alt="image" src="https://github.com/mino0001/DatabaseProgramming/assets/127460529/9de563d5-742e-40f1-afb7-490c3aa7511b">

# 기본 기능

<div>1. main</div>
  <div>1-1. login 상태이면 사용자 ID 출력과 더불어 모든 기능 사용 가능</div>
  <div>1-2. login 상태가 아닐 시 로그인 메시지 출력과 기능 사용 불가</div>
   
<div>2. top</div>
 <div> 2-1. 각 페이지로 이어지는 navbar (login, update, insert, delete, select)</div>
 <div> 2-2. login 상태일 시 로그아웃, logout 상태일 시 로그인 띄우기</div>
     
<div>3. login</div>
  <div>3-1. 로그인 기능</div>
  <div>3-2. 로그인 성공 시 main으로 이동</div>
  <div>3-3. 실패 시 alert</div>
   
<div>4. update</div>
  <div>4-1. login 상태에서 접근 가능</div>
  <div>4-2. 패스워드 수정 시 공란 체크 확인</div>
 <div> 4-3. 패스워드 수정 시 길이 확인</div>
<div>5. insert</div>
 <div> 5-1. login 상태에서 접근 가능</div>
 <div> 5-2. 과목 리스트 출력</div>
 <div> 5-3. InsertEnroll 프로시저를 통해 수강 가능 여부 조회 (정상 작동, 오류 메시지 출력)</div>

<div>6. delete</div>
 <div> 6-1. 신청한 과목 리스트 출력</div>
 <div> 6-2. 삭제를 누르면 삭제 처리</div>
   
<div>7. select</div>
 <div> 7-1. 신청한 과목 리스트 출력</div>
  <div>7-2. 총 신청 과목수와 총 신청학점 출력</div>

# 추가기능

<div>1. update</div>
  <div>1-1. 사용자의 다른 정보(email, address, phone) 변경 가능</div>
  <div>1-2. 기존 비밀번호를 입력받아 DB와 일치해야 변경할 수 있도록 수정</div>
   
<div>2. insert</div>
 <div> 2-1. 재수강 기능 추가 (일정 학점 이하일 시 재수강 가능)</div>
 <div> 2-2. 수강 정원 및 여석 표시</div>
 <div> 2-3. 강의 검색 기능 추가 (강의명, 교수명으로 검색)</div>
 <div> 2-4. 과목번호 분류별 강의 조회 (전공, 교양 필수, 교양 일반)</div>
 <div> 2-5. 수강 신청 가능/불가능 상태 표시 (여석에 따라)</div>
<div>3. select</div>
 <div> 3-1. 연도와 학기별로 수강신청 내역 조회 (최근 5년, 학기별)</div>
 <div> 3-2. 재수강 과목 비고란에 표시</div>
<div>4. style. 전반적으로 통일된 style 적용</div>

# 역할분담

<table>
  <tr>
    <td>이름</td>
    <td>역할</td>
  </tr>
  <tr>
    <td>공동</td>
    <td>기본기능 1, 2, 3, 4, 5</td>
  <tr>
    <td>조은영</td>
    <td>추가기능 1, 2-3, 2-5, 4</td>
  </tr>
  <tr>
    <td>정혜승</td>
    <td>기본기능 6, 추가기능 2-1, 2-2</td>
  </tr>
  <tr>
    <td>조민지</td>
    <td>기본기능 7, 추가기능 2-4, 3</td>
  </tr>
</table>
