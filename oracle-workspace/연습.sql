SELECT *
FROM EMPLOYEE;

--------------------------------------------------------------------------------

SELECT 
    emp_name,
    length(emp_name),
    emp_name,
    lengthb(emp_name)
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- INSTR
-- INSTR(문자열 , 특정문자 , 찾을위치의 시작값 , 순번) : 문자열로부터 특정 문자의 위치값 반환.

SELECT 
    email,
    INSTR(email , '@' , 1 )
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- SUBSTR
-- 문자열부터 특정 문자열을 추출하는 함수 
-- UBSTR(문자열 , 처음위치 , 추출할 문자 갯수)

SELECT 
    email,
    SUBSTR(email , 1 , 3)
FROM EMPLOYEE;

SELECT 
    SUBSTR('SHOWMETHEMONEY' , 1 , 4), -- SHOW
    SUBSTR('SHOWMETHEMONEY' , 5 , 2), -- ME
    SUBSTR('SHOWMETHEMONEY' , 7 , 3), -- THE
    SUBSTR('SHOWMETHEMONEY' , 10) -- MONEY
FROM DUAL;

--------------------------------------------------------------------------------

-- 주민등록번호에서 성별 부분을 추출해서 남자(1) 여자(2)를 체크.

SELECT
    emp_name AS "이름",
    SUBSTR(emp_no , 8 , 1) AS "주민등록번호" 
FROM EMPLOYEE;

-- 이메일에서 ID부분만 추출해서 조회

SELECT
    emp_name AS "이름",
    email AS "이메일",
    SUBSTR(email , 1 , INSTR(email , '@')-1) AS "아이디"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 남자 사원들만 조회.

SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = '1'; 
  
--------------------------------------------------------------------------------

/*
    LPAD / RPAD 
     - LPAD/RPAD(문자열 , 최종적으로 반환할 문자의 길이(BYTE) , 덧붙이고자 하는 문자)
     : 제시한 문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열로 반환.
     
*/    

-- 621235-1******

SELECT 
    emp_name AS "이름",
    RPAD(SUBSTR(emp_no , 1 , 8) , 14 , '*') AS "주민등록번호"
FROM EMPLOYEE;


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
    
-- 2단계 : 근무일수에 '일' 추가해주기 , 별칭부여 "근무일수"

    





