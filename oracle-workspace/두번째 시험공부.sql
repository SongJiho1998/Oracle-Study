-- EMPLOYEE테이블에서 JOB코드가 J1이거나 J3이거나
-- SALARY가 200만원이상이고 , BONUS가 있고, 남자인 사원의
-- EMP_NAME , EMP_NO , DEPT_CODE , SALARY를 조회.

SELECT 
    EMP_NAME,
    EMP_NO,
    DEPT_CODE,
    SALARY
FROM EMPLOYEE
WHERE (JOB_CODE = 'J3' OR DEPT_CODE = 'J1') AND SALARY > 2000000
AND NVL(BONUS , 0);

-- 문제점을 찾고
-- 1) JOB_CODE = 'J3'이여야 하는데 DEPT_CODE = 'J3'이라고 되있음
-- 2) 200만원 이상이라고 했는데 > 라고 표현 -> SALARY >= 2000000
-- 3) 남자인 사원을 알려주는 코드가 없음 -> SUBSTR(EMP_NO , 8 , 1) IN('1' , '3')
-- 4) 보너스가 있고 -> BONUS IS NOT NULL

-- 문제점을 해결하는 코드를 
SELECT 
    EMP_NAME,
    EMP_NO,
    DEPT_CODE,
    SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3' , 'J1')
AND SALARY >= 2000000
AND SUBSTR(EMP_NO , 8 , 1) IN ('1' , '3')
-- ADD SUBSTR(EMP_NO , 8 , 1) = 1;
-- ADD NVL(BONUS , 0) != 0
AND BONUS IS NOT NULL;
    
--------------------------------------------------------------------------------
-- 1. 계정이 생성되지 않는 케이스.
-- 2. 계정생성은 완료했지만 , 접속이 안되는 케이스.
-- 3. 계정접속까지는 했는데 , 테이블 생성이 안되는 케이스.
CREATE USER 사용자이름 IDENTIFIED BY 비밀번호;
-- 현재 계정을 만든상태.

-- 접속하려고하면 오류가 날거에요.

-- 오류를 해결하려면 어떤 조치를 취해야되나 ?
--> 접속할수 있는 권한을 추가해주면됨.
-- - [표현법]GREANT 권한1 , 권한2 ... TO 계정명;
-- GRANT CONNECT , RESOURCE TO Kh;
    
------- 문제해결 시나리오 ---------------------------------------------------------

-- 서술형 공부 키워드위주 --
-- 1. RANK() OVER VS DENSE_RANK()의 차이점과 각 매서드에대해 서술하시오.
-- 2. DENSE_RANK() OVER
-- 3. SELECT가뭔지 DML이뭔지 DDL이뭔지 TCL(Transaction Control Language) : 트랜젝션 제어 , ROLLBACK , COMMIT? 이뭔지?                              
-- 4. 오라클전용구문으로 작성된 쿼리문 -> ANSI 구문으로 변경. 
-- 5. 특정 테이블 특정 칼럼에 제약조건을 추가하시오.
-- 6. SELECT문이란?
-- 7. PRIMARY KEY ?? <- 제약조건들 전부. + 폴인키 , 낫널 등
-- 8. INNER JOIN이란?
-- 9. OUTER JOIN이란?
-- 10. CHAR 와 VARCHAR2의 차이점
-- 11. DATA DICTIONARY란?
--> 다양한 객체들의 정보를 정보를 저장하고있는 시스템 테이블
--> 데이터 사전에는 데이터베이스의 데이터를 제외한 모든 정보가 있고 , 이것의 내용을 변경하는 권한은 시스템에만 있음.
--> 읽기전용테이블로서 조회만 가능.
-- 12. 문자열데이터 (221225) -> 2022년 12월 25일로 표현할 수 있도록 형변환 함수를 이용해라.
-- 13. NVARCHAR --> 문자를 셀때 문자의 갯수자체를 길이로 취급하는 함수. 유니코드를 지원하기위한 자료형 
--     NVARCAHR(50) - '민' --> 1
-- 14. DDL create문이란 ? DML delete문이란? ,DML UPDATE , DML INSERT문이란? -> 어떤역활하는지 어떤 특징이 있는지
-- 15. NVL함수란? , NVL함수 활용하여 쿼리문 작성.
-- 16. CHAR(2000) <- 이건 무슨뜻인가?
-- 17. 컬럼의 자료형중 NUMBER(5 , 1) <- 무엇을 의미하는가?
--     NUMBER(5 , 1) - 5글자짜리에 소수점 첫번째 짜리까지 허용
--                   - 최대 5자리 , 소수점 1자리를 허용함.

--------------------------------------------------------------------------------

