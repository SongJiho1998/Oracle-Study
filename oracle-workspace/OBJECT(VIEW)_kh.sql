/*
    OBJECT
    데이터베이스를 이루는 논리적 구조물들
    
    OBJECT종류
    - TABLE , USER , VIEW , SEQUENCE , INDEX , FUNCTION , TRIGGER , PROCEDURE ...
    
    <VIEW 뷰>
    SELECT문을 저장해둘수 있는 객체.
    (자주 쓰일 긴 SELECT문을 VIEW에 저장해두면 매번 긴 SELECT문을 다시 기술할필요가없음.)
    -> 조회용 임시 테이블 같은 존재(실제 데이터가 담겨있지는 않음)
*/

----------------- 실습문제 -----------------
-- '한국'에서 근무하는 사원들의 사번 , 이름 , 부서명 , 급여 , 근무국가명 , 직급명을 조회하시오.
-- 오라클전용구문
SELECT
    EMP_ID AS "사번",
    EMP_NAME AS "이름",
    DEPT_TITLE AS "부서명",
    SALARY AS "급여",
    NATIONAL_NAME AS "근무국가명",
    JOB_NAME AS "직급명"
FROM EMPLOYEE E , DEPARTMENT D , LOCATION L , NATIONAL N , JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.JOB_CODE = J.JOB_CODE
AND N.NATIONAL_NAME = '한국';

-- ANSI구문
SELECT
    EMP_ID AS "사번",
    EMP_NAME AS "이름",
    DEPT_TITLE AS "부서명",
    SALARY AS "급여",
    NATIONAL_NAME AS "근무국가명",
    JOB_NAME AS "직급명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN JOB J USING (JOB_CODE)
WHERE N.NATIONAL_NAME = '한국';

/*
    1. VIEW 생성 방법
    
    [표현법]
    CREATE VIEW 뷰명
    AS 서브쿼리;
    => 뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새롭게 뷰가 생성되고
       기존에 중복된 이름의 뷰가 있다면 해당 그 이름의 뷰를 변경한다. (OR REPLACE는 생략가능)
*/

CREATE VIEW VW_EMPLOYEE
AS SELECT
    EMP_ID AS "사번",
    EMP_NAME AS "이름",
    DEPT_TITLE AS "부서명",
    SALARY AS "급여",
    NATIONAL_NAME AS "근무국가명",
    JOB_NAME AS "직급명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN JOB J USING (JOB_CODE);
-- insufficient privaileges(권한 불충분 에러)
-- 현재 KH계정에 뷰 생성권한이 없어서 에러가 발생한다.

-- 권한부여는 관리자계정에서 가능.
GRANT CREATE VIEW TO KH;

SELECT * 
FROM VW_EMPLOYEE
WHERE 근무국가명 = '일본';

-- 근무지가 러시아이고 사원들의 사번 , 이름 , 직급명 , 보너스
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT
    EMP_ID AS "사번",
    EMP_NAME AS "이름",
    DEPT_TITLE AS "부서명",
    SALARY AS "급여",
    NATIONAL_NAME AS "근무국가명",
    JOB_NAME AS "직급명",
    BONUS AS "보너스"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN JOB J USING (JOB_CODE);

SELECT
    사번 , 
    부서명 , 
    직급명 , 
    보너스
FROM VW_EMPLOYEE;
-- 뷰에 없는 칼럼을 조회해오고자 한다면 새롭게 만들어야함

-- 뷰는 논리적인 가상테이블 => 실질적으로 데이터를 저장하고 있지는 않음.
-- (단순히 쿼리문이 TEXT문구로 저장되어있다.)
-- 참고)뷰 데이터 사전 :  USER_VIEW;

/*
    뷰 컬럼에 별칭부여
    서브쿼리 부분에 SELECT절에 함수나 , 산술연산식이 기술되어 있는경우 반드시! 별칭지정.
*/

-- 사원의 사번 , 이름 , 직급명 , 성별 , 근무년수를 조회할 수 있는 SELECT문을 VIEW로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB 
AS SELECT
    EMP_ID ,
    EMP_NAME ,
    JOB_NAME ,
    DECODE(SUBSTR(EMP_NO , 8 , 1) , '1' , '남' , '3' , '남' , '2' , '여' , '4' , '여') AS "성별",
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);
-- "must name this expression with a column alias"

SELECT
    EMP_NAME,
    성별,
    근무년수
FROM VW_EMP_JOB;
-- 별칭부여하는 또다른 방법(단 , 모든컬럼에 대해서 별칭을 하나하나 다 기술해야함)
CREATE OR REPLACE VIEW VW_EMP_JOB (사번 , 사원명 , 직급명 , 성별 , 근무년수)
AS SELECT
    EMP_ID ,
    EMP_NAME ,
    JOB_NAME ,
    DECODE(SUBSTR(EMP_NO , 8 , 1) , '1' , '남' , '3' , '남' , '2' , '여' , '4' , '여'),
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

SELECT
    사번,
    사원명,
    근무년수
FROM VW_EMP_JOB
WHERE 성별 = '여' AND 근무년수 > 20;

-- CREATE , ALTER , DROP
DROP VIEW VW_EMP_JOB;

SELECT * FROM USER_VIEWS;

-- INSERT , UPDATE , DELETE 

/*
    * 생성된 뷰를 이용해서 DML 사용
    
    주의사항 : 뷰를통해서 조작하게된다면 , 
             실제 데이터가 담겨있는 실질적인 테이블(베이스테이블)에도 변경사항이 적용된다.
*/

CREATE VIEW VW_JOB
AS SELECT  * 
FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- 뷰에 INSERT
INSERT INTO VW_JOB
VALUES('J8' , '인턴');

-- 베이스테이블인 JOB에도 값이 INSERT 되었음.
-- VW_JOB 뷰에 JOB_CODE = J8인 JOB_NAME = '알바'로 업데이트
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

/*
    DML 이 가능한 경우 : 서브쿼리를 이용해서 기존의 테이블을 별도의 처리없이 복제하고자 할 경우.
    
    DML 이 안되는 경우 : 한번의 처리가 들어간 경우 불가능.
*/
-- 1) 뷰에 정의되어 있지 않은 컬럼을 조작하는경우.
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

-- INSERT
INSERT INTO VW_JOB(JOB_CODE , JOB_NAME)
VALUES ('J8' , '인턴'); -- 에러

-- UPDATE 
UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';

-- 2) 뷰에 정의되어있지 않은 칼럼중에 베이스테이블 상에 NOT NULL 제약조건이 정의된 경우.
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

-- INSERT
INSERT INTO VM_JOB
VALUES('인턴'); -- JOB 테이블에 (NULL , '인턴')이 삽입되려고 했다(에러_

-- UPDATE (성공)
UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_NAME = '사원';

ROLLBACK;

-- DELETE(원래라면 삭제시 FOREING KEY 제약조건이 걸려있고 , 자식테이블에서 참조한다면 에러발생)
DELETE FROM VW_JOB
WHERE JOB_NAME = '부장';

-- 3) 산술연산식 또는 함수를 통해서 정의되어 있는 뷰의경우.
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    (SALARY * 12) AS "연봉"
FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;

-- INSERT
INSERT INTO VW_EMP_SAL VALUES(400 , '지호' , 3000000 , 36000000);
-- virtual column not allowed here(가상칼럼은 INSERT시 사용할수없다)

-- UPDATE
UPDATE VW_EMP_SAL
SET SALARY = 8000000
-- 연봉 = 96000000
-- WHERE EMP_ID = '202';
WHERE 연봉 = 96000000; -- 즉 값자체를 추가하는것은 불가능하나 , 해당칼럼은 조건절에서는 사용가능하다.

-- 4) 그룹함수혹은 GROUP BY 절이 포함된경우. 
CREATE OR REPLACE VIEW VW_GRUOPDEPT
AS SELECT 
    DEPT_CODE,
    SUM(SALARY) AS "합계",
    FLOOR(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM VW_GRUOPDEPT;

-- INSERT
INSERT INTO VW_GROUPDEPT VALUES('D3' , 8000000 , 4000000); -- 에러
-- UPDATE , DELETE 모두 에러가남.
UPDATE VW_GRUOPDEPT
SET DEPT_CODE = 'D0'
WHERE 합계 = 6986240;

-- 5) DISTINCT 구문이 포함된 경우.
CREATE OR REPLACE VIEW VW_DP_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DP_JOB;

-- INSERT , UPDATE , DELETE 뭘하든 에러남.


-- 6) JOIN을 이용해서 여러테이블을 매칭시켜놓은경우. 
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM VW_JOINEMP;

-- INSERT
INSERT INTO VW_JOINEMP
VALUES(300 , '지호' , '총무부'); -- 에러
-- cannot modify more than one base table through a join view

-- 이름변경시
UPDATE VW_JOINEMP
SET EMP_NAME = '송지호'
WHERE EMP_ID = 200;

SELECT * FROM VW_JOINEMP;

-- 부서 변경시
UPDATE VW_JOINEMP
SET DEPT_TITLE = '회계부'
WHERE EMP_ID = 200; -- 에러
-- cannot modify a column which maps to a non key-preserved table

-- DELETE 

DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE = '총무부';

ROLLBACK;

-- VIEW에서 사용 가능한 옵션들
-- 1. OR REPLACE

-- 2. FORCE/NOFORCE옵션 : 실제테이블이 없어도 VIEW를 먼저 생성할수 있게 해주는 옵션.
-- CREATE OR REPLACE NOFORCE (기본값).
CREATE FORCE VIEW V_FORCETEST
AS SELECT A , B , C FROM NOTHINGTEST;

SELECT * FROM V_FORCETEST; -- 에러발생

CREATE TABLE NOTHINGTEST(
    A NUMBER,
    B NUMBER,
    C NUMBER
);

SELECT * FROM V_FORCETEST; -- 에러X

-- 3. WITH CHECK OPTION 
-- SELECT문의 WHERE절에서 사용한 컬럼ㅇ르 수정하지 못하게 하는 옵션.
CREATE OR REPLACE NOFORCE VIEW V_CHECKOPTION
AS SELECT EMP_ID , EMP_NAME , SALARY , DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;

SELECT * FROM V_CHECKOPTION;

UPDATE V_CHECKOPTION 
SET DEPT_CODE = 'D6' 
WHERE EMP_ID = 215;
-- view WITH CHECK OPTION where-clause violation

UPDATE V_CHECKOPTION 
SET SALARY = 8000000 
WHERE EMP_ID = 215; -- 성공

ROLLBACK;

-- 4) WITH READ ONLY
-- VIEW 자체를 수정하지 못하게 차단하는 옵션.
CREATE OR REPLACE VIEW V_READ
AS SELECT EMP_ID , EMP_NAME , SALARY , DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH READ ONLY;

UPDATE V_READ 
SET SALARY = 0
WHERE DEPT_CODE = 215;

UPDATE V_READ 
SET SALARY = 0;
-- cannot perform a DML operation on a read-only view



























