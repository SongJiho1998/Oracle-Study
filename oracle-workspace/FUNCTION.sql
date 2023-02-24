/*
    <함수 FUNCTION>
    자바로 따지면 메소드와 같은 존재
    매개변수로 전달된 값들을 읽어서 계산한 결과를 반환 -> 호출해서 쓸 것.
    
    - 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴(매 행마다 함수 실행 후 결과 반호)
    - 그룹 함수 : N개의 값을 읽어서 1개의 결과를 리턴(하나의 그룹별로 함수 실행 후 결과 반환)
    
    단일행 함수와 그룹 함수는 함께 사용 할 수 없음 : 결과 행의 갯수가 다르기 때문.
    
*/
------------------------------ < 단일행 함수> ------------------------------

/*
    LENGTH / LENGTHB
    
    - LENGTH(문자열) : 해당 전달된 문자열의 글자수 반환.
    - LENGTHB(문자열) : 해당 전달된 문자열의 바이트 수 반환.
    
    결과값은 숫자로 반환 -> NUMBER
    문자열 : 문자열 형식의 리터럴 , 문자열에 해당하는 칼럼
    
    한글 : 김 -> 'ㄱ' , 'ㅣ' , 'ㅁ' => 한글자당 3BYTE취급
    영문 , 숫자 , 특수문자 : 한 글자당 1BYTE취급
*/

SELECT LENGTH('오라클!') , LENGTHB('오라클!')
FROM DUAL; --    4                   10
--> 가상 테이블 : 산술연산이나 가상컬럼등 값을 한번만 출력하고 싶을때 사용하는 테이블(DUAL)

-- 이메일과 , 사원이름을 칼럼값 , 글자수 , 바이트글자수
SELECT 
    email,
    length(email),
    lengthb(email),
    emp_name,
    length(emp_name),
    lengthb(emp_name)
FROM EMPLOYEE;


/*
    INSTR
    - INSTR(문자열 , 특정문자 , 찾을위치의 시작값 , 순번) : 문자열로부터 특정 문자의 위치값 반환.
    
    찾을 위치의 시작값 , 순번은 생략 가능
    결과값은 NUMBER 타입으로 반환.
    
    찾을 위치의 시작값 (1 / -1)
    1 : 앞에서부터 찾겠다. (생략시 기본값)
    -1 : 뒤에서부터 찾겠다.
*/

SELECT INSTR('AABAACAABBAA' ,'B') FROM DUAL; -- 3
-- 찾을 위치 , 순번을 생략 : 기본적으로 앞에서부터 첫번째 글자의 위치를 알려줌

SELECT INSTR('AABAACAABBAA' , 'B' , 1) FROM DUAL; -- 3
-- 위와 동일한 결과값 반환.

SELECT INSTR('AABAACAABBAA' , 'B' , -1) FROM DUAL; -- 10
-- 뒤에서부터 첫번째 글자의 위치를 알려줌.

SELECT INSTR('AABAACAABBAA' , 'B' , -1 , 2) FROM DUAL; -- 9
-- 뒤에서부터 두번째 위치하는 B의값의 위치값을 앞에서부터 세서 알려준것.

SELECT INSTR('AABAACAABBAA' , 'B' , -1 , 0) FROM DUAL; -- 오류발생
-- 범위를 벗어난 순번을 제시한경우 오류 발생.

SELECT INSTR(EMAIL , '#') -- 포함되지 않은 값 '#' 을 넣어준 경우 0으로 반환
FROM EMPLOYEE;

/*
    SUBSTR
    
    문자열부터 특정 문자열을 추출하는 함수 
    - SUBSTR(문자열 , 처음위치 , 추출할 문자 갯수)
    
    결과값은 CHARACTER타입으로 반환(문자열)
    추출한 문자 갯수는 생략가능(생략했을떄 문자열 끝까지 추출.)
    처음위치는 음수로 제시 가능 : 뒤에서부터 N번째 위치로부터 문자를 추출하겠다 라는 뜻.
    
*/

SELECT SUBSTR('SHOWMETHEMONEY' , 7) FROM DUAL; -- THEMONEY

SELECT SUBSTR('SHOWMETHEMONEY' , 5 , 2) FROM DUAL; -- ME

SELECT SUBSTR('SHOWMETHEMONEY' , -8 , 3) FROM DUAL; -- THE

SELECT SUBSTR('SHOWMETHEMONEY' , -5) FROM DUAL; -- MONEY

-- 주민등록번호에서 성별 부분을 추출해서 남자(1) 여자(2)를 체크.
SELECT 
    emp_name,
    SUBSTR(emp_no , 8 , 1) AS "성별" 
FROM EMPLOYEE;

-- 이메일에서 ID부분만 추출해서 조회
SELECT 
    emp_name,
    SUBSTR(email , 1 , INSTR(email , '@') -1) AS "ID" 
FROM EMPLOYEE;

-- 남자 사원들만 조회.
SELECT * 
FROM  EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = '1';

/*
    LPAD / RPAD 
     - LPAD/RPAD(문자열 , 최종적으로 반환할 문자의 길이(BYTE) , 덧붙이고자 하는 문자)
     : 제시한 문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열로 반환.
     
*/

SELECT LPAD(EMAIL , 16)
FROM EMPLOYEE;

SELECT RPAD(EMAIL , 20)
FROM EMPLOYEE;

SELECT 
    emp_name,
    RPAD(SUBSTR(EMP_NO ,1 , 8 )  , 14 , '*') AS "주민등록번호" 
FROM EMPLOYEE;

-- 621235-1******
-- 1단계 : SUBSTR함수를 이용해서 주민번호 앞 8자리만 추출.
SELECT 
    emp_name,
    SUBSTR(emp_no , 1 , 8) AS 주민번호
FROM EMPLOYEE;
-- 2단계 : RPAD함수를 중첩해서 주민번호뒤에 *붙이기
SELECT 
    emp_name,
    RPAD(SUBSTR(EMP_NO ,1 , 8 )  , 14 , '*') AS 주민번호
FROM EMPLOYEE;

------------------------------ < 연습 > ------------------------------

SELECT
    emp_id,
    emp_name,
    RPAD(SUBSTR(EMP_NO , 1 ,8) , 14 , '*') AS "주민등록번호"
FROM EMPLOYEE;

SELECT
    emp_id AS "사원번호",
    RPAD(SUBSTR(EMP_NAME , 1, 2) , 5 , '*') AS "이름" ,
    RPAD(SUBSTR(EMP_NO , 1 ,8) , 14 , '*') AS "주민등록번호",
    SUBSTR(RPAD(SUBSTR(PHONE , 1 , 8) , 11 , '*'), 1, 3) || '-' || SUBSTR(RPAD(SUBSTR(PHONE , 1 , 8) , 11 , '*'), 4, 4) || '-'|| SUBSTR(RPAD(SUBSTR(PHONE , 1 , 8) , 11 , '*'), 8) AS "핸드폰번호"
FROM EMPLOYEE;

SELECT 
    REPLACE('가나다 라마바 사아자 차카타 파하' , '라마바' , '가나다') AS "REPLACE 연습",
    UPPER('abcdefghijklmnopqrstuvwxyz') AS "UPPER 연습" 
    
FROM DUAL;

/*
    LTRIM/RTRIM
    
    - LTRIM/RTRIM(문자열 , 제거시키고자하는 문자)
    : 문자열의 왼쪽 또는 오른쪽에서 제거시키고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환.
    
    결과값은 CHARACTER 형태로 나옴. 제거시키고자 하는 문자 생략 가능(DEFAULT ' ')
    
*/

SELECT LTRIM('      K   H      ')
FROM DUAL;

SELECT RTRIM('      K   H      ')
FROM DUAL;

SELECT LTRIM('0001230456000' , '0')
FROM DUAL;

SELECT RTRIM('0001230456000' , '0')
FROM DUAL;

--- 동일결과나옴 ---
-- 포함되는 문자가 있으면 순서 상관없이 제거
SELECT LTRIM('123123KH123' , '123')
FROM DUAL;

SELECT LTRIM('123123KH123' , '132')
FROM DUAL;

SELECT LTRIM('123123KH123' , '312')
FROM DUAL;

--------------------------------------------------------------------------------

SELECT LTRIM('ACABACCKH' , 'ABC')
FROM DUAL; -- 제거시키고자 하는 문자열을 통으로 지워주는게 아니라 문자 하나하나가 다 존재하면 지워주는 원리.

/*
    TRIM
    
    - TRIM(BOTH/LEADING/TRAILING '제거시키고자 하는 문자' FROM '문자열')
    : 문자열 양쪽, 왼쪽, 뒤쪽에 있는 특정 문자를 제거한 나머지 문자열 반환.
    
    결과값음 CHARACTER 타입반환 BOTH/LEADING/TRAILING은 생략 가능 (DEFAULT BOTH)
    
*/

SELECT TRIM('     K H     ')
FROM DUAL;

SELECT TRIM('Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL; -- 앞에꺼 제거

SELECT TRIM(TRAILING 'Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL; -- 뒤에꺼 제거

-- LEADING == LTRIM
-- TRAILING == RTRIM


/*
    LOWER/UPPER/INITCAP
    
    - LOWER(문자열)
    : 문자를 전부 소문자로 변경.
    
    - UPPER(문자열)
    : 문자를 전부 대문자로 변경.
    
    - INITCAP(문자열)
    : 각 단어의 앞글자만 대문자로 변경.
    
*/

SELECT LOWER('Welcom to B class!') , UPPER('Welcom to B class!') , INITCAP('Welcom to B class!')
FROM DUAL;


/*
    CONCAT
    
    - CONCAT(문자열 , 문자열2)
    : 전달된 문자열 두개를 하나의 문자열로 합쳐서 반환
    
*/

SELECT CONCAT('가나다' , 'ABC')
FROM DUAL;

SELECT '가나다' || 'ABC'
FROM DUAL;

SELECT CONCAT(CONCAT('가나다' , 'ABC') , 'DEF')
FROM DUAL; -- CONCAT은 두개의 문자열만 가능.

/*
    REPLACE
    -REPLACE(문자열 , 찾을문자 , 바꿀문자)
    : 문자열로부터 찾을문자를 찾아서 바꿀문자로 바꾼 문자열을 반환.
    
*/

SELECT REPLACE('서울시 강남구 역삼동' , '역삼동' , '삼성동')
FROM DUAL;

SELECT 
    emp_name,
    email,
    replace(email , 'kh.or.kr' , 'iei.or.kr') AS new_email
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    <숫자와 관련된 함수>
    
    ABS
    
    - ABS(절대값을 구할 숫자) : 절대값을 구해주는 함수.
    
*/

-- 10 , -10 => 10

SELECT ABS(-10)
FROM DUAL;

SELECT ABS(-10.9)
FROM DUAL;

/*
    MOD
    - MOD(숫자 , 나눌값) : 두 수를 나눈 나머지값을 반환해주는 함수 (자바의 %)
*/

SELECT MOD(10 , 3)
FROM DUAL; -- 1

SELECT MOD(-10 , 3)
FROM DUAL; -- 1

SELECT MOD(10.9 , 3)
FROM DUAL; -- 1.9

/*
    ROUND
    
    - ROUND(반올림하고자 하는 수 , 반올림 하고자 하는 위치) : 반올림 처리해주는 함수.
    
    반올림할 위치 : 소숫점 기준으로 아래 N번째 수에서 반올림하겠다.
                  생략가능(기본값은 0 , => 소숫점 첫번째에서 반올림하겠다.)
                  
*/

SELECT ROUND(123.456)
FROM DUAL; -- 123

SELECT ROUND(123.456 , 0)
FROM DUAL; -- 123

SELECT ROUND(123.456 , 1)
FROM DUAL; -- 123.5

SELECT ROUND(123.456 , -1)
FROM DUAL; -- 120

SELECT ROUND(123.456 , -2)
FROM DUAL; -- 100 
-- 소수점 아래가 아니라 정수 자리에서도 사용 가능.


/*
    CEIL
    
    - CEIL(올림처리할숫자) : 소수점 아래의 수를 무조건 올림 처리해주는 함수.
    
*/

SELECT CEIL(123.456)
FROM DUAL; -- 124

SELECT CEIL(456.001)
FROM DUAL; -- 457


/*
    FLOOR
    
    - FLOOR(버림처리하고자 하는 숫자) : 소수점 아래의 수를 무조건 버림처리하는 함수.
    
*/

SELECT FLOOR(123.954)
FROM DUAL; -- 123

SELECT FLOOR(207.68)
FROM DUAL; -- 207

-- 1단계 : 각 직원별로 근무일수 구하기 단, 소수점 아래 버리기.

SELECT  
    emp_name AS "이름",
    floor(sysdate - hire_date) AS "근무일수" 
FROM EMPLOYEE;
    
-- 2단계 : 근무일수에 '일' 추가해주기 , 별칭부여 "근무일수"

SELECT 
    emp_name AS "이름",
    concat(floor(sysdate - hire_date) , '일') AS "근무일수" 
FROM EMPLOYEE;

--- 퇴직한 사람은 빼기 ---

SELECT 
    emp_name AS "이름",
    concat(floor(sysdate - hire_date) , '일') AS "근무일수" 
FROM EMPLOYEE
WHERE ENT_YN !  = 'Y';


/*
    TRUNC
    - TRUNC(버림처리할숫자 , 위치) : 위치가 지정 가능한 버림 처리를 해주는 함수.
    
    위치 생략가능 , 생략시 DEFAULT = 0 => FLOOR
    
*/

SELECT TRUNC(123.786)
FROM DUAL; -- 123

SELECT TRUNC(123.789 , 1)
FROM DUAL; -- 123.7

SELECT TRUNC(123.789 , -1)
FROM DUAL; -- 120

--------------------------------------------------------------------------------

/*
    <날짜 관련 함수>
    DATE 타입 : 년도 , 월 , 일 , 시 , 분 , 초 다 있는 자료형.

    SYSDATE : 현재 시스템 날짜를 반환    
*/

-- 1. MONTHS_BETWEEN(DATE 1 , DATE 2) : 두 날짜사이의 개월수를 반환(NUMBER타입 반환)
-- DATE2 가 더 미래일 경우 음수가 나옴.

-- 각 직원별 근무일수 , 근무 개월수

SELECT 
    emp_name,
    floor(sysdate - hire_date) AS "근무일수",
    abs(floor(months_between(hire_date , sysdate))) AS "근무개월수"
FROM EMPLOYEE;

SELECT 
    emp_name,
    floor(sysdate - hire_date) AS "근무일수",
    floor(months_between(sysdate , hire_date)) AS "근무개월수"
FROM EMPLOYEE;

-- 2. ADD MONTHS(DATE , NUMBER) : 특정 날짜에 해당 숫자만큼 개월수를 더한 날짜 반환(결과값은 DATE 타입)

SELECT ADD_MONTHS(SYSDATE , 12)
FROM DUAL;

-- 전체 사원들의 1년 근속일 (== 입사일로부터 1주년)

SELECT 
    emp_name AS "이름",
    add_months(hire_date , 12) AS "1년 근속일"
FROM EMPLOYEE;

-- 3. NEXT_DAY(DATE , 요일(문자 , 숫자)) : 특정 날짜에서 가장 가까운 해당 요일을 찾아서 반환.(DATE반환)

SELECT NEXT_DAY(SYSDATE , '토요일')
FROM DUAL;

SELECT NEXT_DAY(SYSDATE , '금')
FROM DUAL;

SELECT NEXT_DAY(SYSDATE , 7) -- 1. 일요일 , 2. 월요일 , 3화요일 ... 7. 토요일
FROM DUAL;

-- 언어를 변경
-- DDL
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT NEXT_DAY(SYSDATE , 'SATURDAY') -- 현재 세팅된 언어가 한국어이기 때문에 에러가 발생함.
FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;


-- 4. LAST_DAY(DATE) : 해당 특정날짜 달의 마지막 날짜를 구해서 반환(DATE 반환)

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- 이름 , 입사일 , 입사한 날의 마지막 날짜 조회.
SELECT 
    emp_name AS "이름",
    hire_date AS "입사일",
    last_day(hire_date)
FROM EMPLOYEE;

-- 5. EXTRACT : 년도 , 월 , 일의 정보를 추출해서 반환(결과값은 NUMBER)

/*
    - EXTRACT(YEAR FROM 날짜) : 특정날짜로부터 년도만 추출.
    - EXTRACT(MONTH FROM 날짜) : 특정날짜로부터 월만 추출.
    - EXTRACT(DAY FROM 날짜) : 특정 날짜로부터 일만 추출.
    
    90/02/06
    
*/

SELECT 

    EXTRACT(YEAR FROM SYSDATE),
    EXTRACT(MONTH FROM SYSDATE),
    EXTRACT(DAY FROM SYSDATE)
FROM DUAL;
-- 2022 - 8 - 22

-- 1단계 : 사원명 , 입사 년도 , 입사 월 , 입사일 조회.
-- 2단계 : 입사년도 , 입사월 , 입사일 기준으로 오름차순 정렬.

SELECT 
    emp_name AS "이름",
    extract(year from hire_date) AS "입사년도",
    extract(month from hire_date) AS "입사월",
    extract(day from hire_date) AS "입사일"
FROM EMPLOYEE
ORDER BY "입사년도" , "입사월" , "입사일"; -- ASC

--------------------------------------------------------------------------------

/*
    <형변환 함수>
    
    NUMBER/DATE => CHARACTER
    
    - TO_CHAR(NUMBER/DATE , 포맷)
    : 숫자형 또는 날짜형데이터를 문자형 타입으로 변환(포맷에 맞춰서)
    
*/

SELECT TO_CHAR(123)
FROM DUAL;

SELECT TO_CHAR(1234 , '00000')
FROM DUAL; -- 1234 -> '01234' : 빈칸은 0으로 채움

SELECT TO_CHAR(1234 , '99999')
FROM DUAL; -- 1234 = '1234' : 빈칸은 ' '으로 채움.

SELECT TO_CHAR(1234 , 'L00000')
FROM DUAL; -- L : LOCAL => 현재 설정된 나라의 화폐단위.
-- 1234 => '\01234'

SELECT TO_CHAR(1234 , 'L99999')
FROM DUAL; -- 1234 -> \ 1234

SELECT TO_CHAR(1234 , 'L99,999')
FROM DUAL;

-- 급여정보를 3자리마다 , 로 끊어서 확인

SELECT 
    emp_name,
    TO_CHAR(salary , 'L999,999,999') AS "급여"
FROM EMPLOYEE;
    
-- 날짜를 문자열 변경
SELECT TO_CHAR(SYSDATE)
FROM DUAL;

SELECT TO_CHAR(SYSDATE , 'YYYY-MM-DD')
FROM DUAL; -- 2022-08-22

SELECT TO_CHAR(SYSDATE , 'YYYY/MM/DD')
FROM DUAL; -- 2022/08/22

-- 시 분 초 : HH:MI:SS
-- PM 오후 / AM 오전
SELECT TO_CHAR(SYSDATE , 'PM HH:MI:SS')
FROM DUAL; -- 오후 05:53:12

-- 시,분,초 24시간 형식
SELECT TO_CHAR(SYSDATE , 'HH24:MI:SS')
FROM DUAL; -- 24시간 기준으로 표현해줌 -- 17:54:34

SELECT TO_CHAR(SYSDATE , 'MON DY, YYYY')
FROM DUAL; -- 월 월(요일) , 2022 - 8월 월, 2022
-- 월 월 , 2022 : MON - MONTH , DY - DAY 몇월 , 몇 요일

SELECT TO_CHAR(SYSDATE , 'YYYY'),
       TO_CHAR(SYSDATE , 'RRRR'),
       TO_CHAR(SYSDATE , 'YY'),
       TO_CHAR(SYSDATE , 'RR'),
       TO_CHAR(SYSDATE , 'YEAR')
FROM DUAL;

-- YY 와 RR의 차이점
-- R은 ROUND약자
-- YY : 앞자리에 무조건 (년도20)이 붙음
-- RR : 50년기준으로 작으면 20이 붙고 , 크면 19가 붙음 -> 1989 / (20)49 

SELECT TO_CHAR(SYSDATE , 'MM'),
       TO_CHAR(SYSDATE , 'MON'),
       TO_CHAR(SYSDATE , 'MONTH'),
       TO_CHAR(SYSDATE , 'RM')
FROM DUAL;

SELECT TO_CHAR(SYSDATE , 'D'),
       TO_CHAR(SYSDATE , 'DD'),
       TO_CHAR(SYSDATE , 'DDD')
FROM DUAL;
-- D : 1주일 기준으로 일요일부터 며칠째인 알려주는 포맷(1-일요일 , 2-월요일)
-- DD : 1달 기준으로 1일부터 며칠째인지 알려주는 포맷.
-- DDD : 1년 기준으로 1일부터 며칠째인지 알려주는 포맷.

SELECT TO_CHAR(SYSDATE , 'DY'),
       TO_CHAR(SYSDATE , 'DAY')
FROM DUAL; -- 요일이 있냐 없냐 차이.

-- 1단계 : 사원명 , 입사일 0000년 00월 00일 (월)요일 AS 별칭 "입사일"

SELECT 
    emp_name AS "이름",
    TO_CHAR(HIRE_DATE , 'YYYY"년" MM"월" DD"일" DAY') AS "입사일"
FROM EMPLOYEE
-- 2단계 : 입사일이 2010년도 이상인 사원만 출력.
WHERE HIRE_DATE >= '10/01/01';
--WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2010;


/*
    NUMBER/CHARACTER -> DATE
    - TO_DATE(NUMBER/CHARACTER , 포맷) : 숫자형 또는 무자형 데이터를 날짜형으로 반환.
    
*/

SELECT TO_DATE(20220821)
FROM DUAL; -- 22/08/21

SELECT TO_DATE('20220821')
FROM DUAL; -- 22/08/21

SELECT TO_DATE(000101)
FROM DUAL; -- 오류 

SELECT TO_DATE('000101')
FROM DUAL; -- 00/01/01
-- 0으로 시작하는 년도는 반드시 홀따음표로 묶어서 문자열로 다뤄야 함.

SELECT TO_DATE('20100101' , 'YYYYMMDD')
FROM DUAL; -- 10/01/01

SELECT TO_DATE('041030 143021' , 'YYMMDD HH24:MI:SS')
FROM DUAL; -- 04/10/30

SELECT TO_DATE('980630' , 'YYMMDD')
FROM DUAL; -- (20)98/06/30

SELECT TO_DATE('19980630' , 'YYYYMMDD')
FROM DUAL; -- (19)98/06/30


/*
    CHARACTER => NUMBER
    
    - TO_NUMBER(CHARACTER , 포맷) : 문자형 데이터를 숫자형으로 변환
*/

-- 자동형변환 예시(문자열 => 숫자)
SELECT '123' + '123'
FROM DUAL; -- 246

SELECT TO_NUMBER('123') + TO_NUMBER('123')
FROM DUAL; -- 246

SELECT '10,000,000' + '550,000'
FROM DUAL; -- 문자(,)가 포함되어있어서 자동 형변환이 안됨.

SELECT TO_NUMBER('10,000,000' , '99,999,999') + TO_NUMBER('550,000' , '999,999')
FROM DUAL; -- 10550000 : 형변환 한 후 산술연산까지 진행됨.

SELECT TO_NUMBER('0123')
FROM DUAL; -- 123 (앞의 0은 없애줌)

--------------------------------------------------------------------------------

/*
    <NULL 처리 함수>
    
    -- NVL(컬렴명 , 해당컬럼값이 NULL일 경우 반환할 반환값)
    -- 해당컬럼값이 존재할 경우(NULL이 아닐경우) 기존의 컬럼값이 반환.
    -- 해당컬럼값이 존재하지 않을경우(NULL일경우) 내가 제시한 특정값을 반환.
    
*/

-- 사원명 , 보너스 , 보너스가없는 경우 0으로 출력.

SELECT 
    emp_name,
    NVL(bonus , 0) AS "보너스"
FROM EMPLOYEE;
    
SELECT 
    emp_name,
    (salary + (salary * NVL(bonus , 0) )) * 12 AS "보너스포함연봉"
FROM EMPLOYEE;

-- 사원명과 , 부서코드 (없는경우 '없음') 조회.
SELECT 
    emp_name,
    NVL(dept_code , '없음') AS "부서코드"
FROM EMPLOYEE;

-- NVL2(컬럼명 , 결과값1 , 결과값2)
-- 해당칼럼값이 NULL이 아닐 경우 결과값 1반환.
-- 해당칼럼값이 NULL일 경우 결과값 2반환.

-- 보너스가 있는 사원은 '보너스 있음' , '보너스 없음' AS "보너스유무"

SELECT 
    emp_name,
    bonus,
    NVL2(bonus , '보너스 있음' , '보너스 없음') AS "보너스 유무"
FROM EMPLOYEE;


-- NULLIF(비교대상1 , 비교대상2) : 동등비교
-- 두값이 동일할 경우 NULL반환.
-- 두값이 동일하지 않을경우 비교대상1 반환.

SELECT NULLIF('123' , '123')
FROM DUAL; -- NULL

SELECT NULLIF('123' , '456')
FROM DUAL; -- 123

-- 선택함수 : DECODE => SWITCH문.
-- 선택함수 친구 : CASE WHEN THEN 구문 => IF문.


/*

    <선택함수>
    
    - DECODE(비교대상 , 조건값1 , 결과값1 , 조건값2 , 결과값2 ... , 조건값N , 결과값N)
    
    비교대상에는 컬럼명 , 산술연산(결과는 숫자) , 함수가 들어갈 수 있다.
    
*/

-- 사번 , 사원명 , 주민등록번호 , 주민등록번호로부터 성별 자리를 추출(1 , 3 : 남자 , 2 , 4 : 여자)
SELECT 
    emp_id,
    emp_name,
    emp_no,
    DECODE(SUBSTR(emp_no , 8 , 1) , '1' , '남' , '3' , '남' , '2' , '여' , '4' , '여') AS "성별"
FROM EMPLOYEE;


-- 직원들의 급여를 인상시켜서 조회
-- 직급코드가 'J7'인 사원은 급여를 10%인상해서 조회.
-- 직급코드가 'J6'인 사원은 급여를 15%인상해서 조회.
-- 직급코드가 'J5'인 사원은 급여를 20%인상해서 조회.
-- 그외 직급코드인 사원은 급여를 5%인상해서 조회.
-- 사원명 , 직급코드 , 변경전 급여 , 변경 후 급여

SELECT 
    emp_name AS "사원명",
    job_code AS "직급코드",
    salary AS "변경 전 급여",
    DECODE(job_code , 'J7' , (salary * 1.1) , 'J6' ,  (salary * 1.15) , 'J5' , (salary * 1.2),(salary * 1.05))AS "변경후 급여"
FROM EMPLOYEE;


/*
    CASE WHEN TEHN 구문
    - DECODE 선택함수와 비교하면 DECODE는 해당 조건검사 시 동등비교만 수행.
      CASE WHEN THEN 구문의 경우 특정 조건을 내 마음대로 제시 가능.
      
    [표현법]
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         WHEN 조건식N THEN 결과값N
         ELSE 결과값
    END
*/

-- 사번 , 사원명 , 주민등록번호 , 주민등록번호로부터 성별자리 추출해서 (1,3 남) (2,4 여)

SELECT 
    emp_id,
    emp_name,
    emp_no,
    CASE WHEN SUBSTR(EMP_NO , 8 , 1) IN(1,3) THEN '남'
         WHEN SUBSTR(EMP_NO , 8 , 1) IN(2,4) THEN '여'
    END AS "성별"
FROM EMPLOYEE;


SELECT 
    emp_name AS "사원명",
    job_code AS "직급코드",
    salary AS "변경 전 급여",
    CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
         WHEN JOB_CODE = 'J6' THEN SALARY*1.5
         WHEN JOB_CODE = 'J5' THEN SALARY*1.2
         ELSE SALARY*1.05
         
    END AS "변경후 급여"
FROM EMPLOYEE;

-- 사원명 , 급여 , 급여등급
-- 급여등급 SALARY값이 500만원 초과일경우 '고급'
-- 500만원이하 350만원 초과일경우 '중급'
-- 350만원 이하일경우 '초급'

SELECT 
    emp_name,
    salary,
    CASE WHEN SALARY > 5000000 THEN '고급'
         WHEN SALARY > 3500000 THEN '중급'
         ELSE '초급'
    END AS "급여등급"
FROM EMPLOYEE;

---------------------------------- <그룹 함수> ----------------------------------

-- 그룹함수 : 데이터들의 합(SUM) , 평균(AVG)

/*
    N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행결과 반환)
*/

-- 1. SUM(숫자타입 컬럼) : 해당 칼럼값들의 총 합계를 반환해주는 함수.

SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 부서코드가 'D5'인 사원들의 총 합계

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 남자 사원들의 총 급여 합계.
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = 1;

-- 2. AVG(숫자타입의컬럼) : 해당칼럼값들의 평균을 구해서 반환.

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ANY타입) : 해당컬럼값중에 가장 작은 값 반환
-- 4. MAX(ANY타입) : 해당컬럼값중에 가장 큰 값 반환

SELECT MIN(SALARY) , MIN(EMP_NAME) , MAX(EMAIL) , MAX(HIRE_DATE)
FROM EMPLOYEE;

SELECT MAX(SALARY) , MIN(EMP_NAME) , MAX(EMAIL) , MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT
    emp_name,
    email,
    hire_date
FROM EMPLOYEE
ORDER BY EMAIL;

-- 5. COUNT(*/ 컬럼이름(DISTINCT 칼럼이름) : 조회된 행의 갯수를 세서 반환.
-- COUNT(*) : 조회결과에 해당하는 모든행을 다 세서 반환
-- COUNT(컬럼이름) : 제시한 해당 컬럼값이 NULL 아닌것만 행의 갯수를 세서 반환.
-- COUNT(DISTINCT 컬럼이름) : 제시한 해당 컬럼값이 중복값이 있을경우 하나로만 세서 반환 . NULL포함 X.

-- 전체 사원수에 대해 조회

SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자 사원수만 조회

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = 2;

-- 부서배치가 완료된 사원수
-- DEPT_CODE가 NULL이 아닌 사원

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 부서 배치가 완료된 여자 사원수

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = 2;

-- 사수가 있는 사원 수.

SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

-- 현재 사원들의 속해있는 부서의 개수

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

-- 현재 사원들의 유효한 직급의 개수

SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명 , 부서코드 , 생년월일 , 나이 조회.
-- (단 , 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게하고,
-- 나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산.

SELECT 
    emp_name AS "이름" ,
    dept_code AS "부서코드" ,
    TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1 , 6)), 'YYYY"년 "MM"월 "DD"일"') AS "생년월일",
    TO_CHAR(TO_DATE(SYSDATE) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1 , 6)), 'YYYY') || '살' AS "나이"

FROM EMPLOYEE;


