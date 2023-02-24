-- 1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회                    

SELECT 
    emp_name AS "사원명",
    emp_no AS "주민등록번호",
    dept_title AS "부서명", 
    job_name AS "직급"
FROM EMPLOYEE E 
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '전%'
AND SUBSTR(EMP_NO , 8 , 1) IN (2 , 4)
-- SUBSTR(EMP_NO , 1 , 2) = '7'
AND TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1 , 6)) , 'YYYY') BETWEEN 1970 AND 1979;

-- 2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회

SELECT 
    emp_id AS "사원코드",
    emp_name AS "사원명",
    TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(emp_no , 1 , 6)) , 'YYYY') AS "나이",
    dept_title AS "부서명",
    job_name AS "직급명"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(emp_no , 1 , 6)) , 'YYYY') = (
                                                                                                    SELECT 
                                                                                                        MIN(TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(emp_no , 1 , 6)) , 'YYYY'))
                                                                                                    FROM EMPLOYEE
                                                                                                );

-- 3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회

SELECT 
    emp_id AS "사원코드",
    emp_name AS "사원명",
    job_name AS "직급"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

-- 4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회

SELECT 
    emp_name AS "사원명",
    job_name AS "직급명",
    dept_code AS "부서코드",
    dept_title AS "부서명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE DEPT_CODE IN ('D5' , 'D6')
ORDER BY EMP_ID ASC;

-- 5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회

SELECT
    emp_name AS "사원명",
    bonus AS "보너스",
    dept_title AS "부서명",
    local_name AS "지역명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. 사원 명, 직급 명, 부서 명, 지역 명 조회

SELECT 
    emp_name AS "사원명",
    job_name AS "직급명",
    dept_title AS "부서명",
    local_name AS "지역명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- 7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회

SELECT 
    emp_name AS "사원명",
    dept_title AS "부서명",
    local_name AS "지역명",
    national_name AS "국가명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국' , '일본')
AND ENT_YN = 'N';

-- 8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회

SELECT 
    E2.emp_name AS "M.이름",
    E1.dept_code AS "부서코드",
    E1.emp_name AS "E.이름"
FROM EMPLOYEE E1 
JOIN EMPLOYEE E2 ON (E1.DEPT_CODE = E2.DEPT_CODE)
WHERE E1.EMP_NAME != E2.EMP_NAME
ORDER BY E2.EMP_NAME ASC;

-- 9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)

SELECT 
    emp_name AS "사원명",
    job_name AS "직급명",
    TRIM(TO_CHAR(salary  , 'L999,999,999')) || '원' AS "급여"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE NVL(BONUS , 0) = 0 AND E.JOB_CODE IN ('J4' , 'J7');


-- 10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회

SELECT 
    E.*
FROM 
        (
             SELECT 
                 emp_id AS "사번",
                 emp_name AS "이름",
                 dept_title AS "부서명",
                 job_name AS "직급",
                 hire_date AS "입사일",
                 RANK() OVER(ORDER BY ((salary + (salary *  NVL(bonus , 0))) * 12) DESC) AS "순위"
             FROM EMPLOYEE E
             JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
             JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
        ) E
        
WHERE 순위 <= 5;

-- 11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
-- 11-1. JOIN과 HAVING 사용
SELECT
    dept_title AS "부서명",
    TRIM(TO_CHAR(SUM(salary) , 'L999,999,999')) ||'원' AS "부서별 급여합"
FROM DEPARTMENT D
JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (
                        SELECT
                            SUM((salary) * 0.2)
                        FROM EMPLOYEE
                      );
-- 11-2. 인라인 뷰 사용
SELECT
    "부서명",
    "부서별 급여합"
FROM
    (
         SELECT 
             dept_title AS "부서명",
             SUM(salary) AS "부서별 급여합"
         FROM DEPARTMENT
         JOIN EMPLOYEE ON (DEPT_ID = DEPT_CODE)
         GROUP BY DEPT_TITLE
    ) 
WHERE "부서별 급여합" > (
                            SELECT
                                SUM((salary) * 0.2)
                            FROM EMPLOYEE
                      );

                      
-- 12. 부서 명과 부서 별 급여 합계 조회

SELECT 
    dept_title AS "부서명",
    TRIM(TO_CHAR(SUM(salary) , 'L999,999,999')) || '원' AS "부서 별 급여 합"
FROM DEPARTMENT D
RIGHT JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE)
GROUP BY DEPT_TITLE;


--------------------------------------------------------------------------------
-- 12. 부서 명과 부서 별 급여 합계 조회

SELECT --9
    dept_title,
    SUM(SALARY) AS "부서별 급여 합계"
FROM ( --1
        SELECT * --4
        FROM EMPLOYEE --2
        WHERE DEPT_CODE = 'D9' --3
        )E
LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID --5
WHERE DEPT_CODE = 'D9' --6
GROUP BY DEPT_TITLE --7
HAVING SUM(SALARY) >= 2000000 --8
ORDER BY 1; --10


