-- 1. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ                    

SELECT 
    emp_name AS "�����",
    emp_no AS "�ֹε�Ϲ�ȣ",
    dept_title AS "�μ���", 
    job_name AS "����"
FROM EMPLOYEE E 
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '��%'
AND SUBSTR(EMP_NO , 8 , 1) IN (2 , 4)
-- SUBSTR(EMP_NO , 1 , 2) = '7'
AND TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1 , 6)) , 'YYYY') BETWEEN 1970 AND 1979;

-- 2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ

SELECT 
    emp_id AS "����ڵ�",
    emp_name AS "�����",
    TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(emp_no , 1 , 6)) , 'YYYY') AS "����",
    dept_title AS "�μ���",
    job_name AS "���޸�"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(emp_no , 1 , 6)) , 'YYYY') = (
                                                                                                    SELECT 
                                                                                                        MIN(TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(emp_no , 1 , 6)) , 'YYYY'))
                                                                                                    FROM EMPLOYEE
                                                                                                );

-- 3. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ

SELECT 
    emp_id AS "����ڵ�",
    emp_name AS "�����",
    job_name AS "����"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

-- 4. �μ��ڵ尡 D5�̰ų� D6�� ����� ��� ��, ���� ��, �μ� �ڵ�, �μ� �� ��ȸ

SELECT 
    emp_name AS "�����",
    job_name AS "���޸�",
    dept_code AS "�μ��ڵ�",
    dept_title AS "�μ���"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE DEPT_CODE IN ('D5' , 'D6')
ORDER BY EMP_ID ASC;

-- 5. ���ʽ��� �޴� ����� ��� ��, �μ� ��, ���� �� ��ȸ

SELECT
    emp_name AS "�����",
    bonus AS "���ʽ�",
    dept_title AS "�μ���",
    local_name AS "������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. ��� ��, ���� ��, �μ� ��, ���� �� ��ȸ

SELECT 
    emp_name AS "�����",
    job_name AS "���޸�",
    dept_title AS "�μ���",
    local_name AS "������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- 7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ

SELECT 
    emp_name AS "�����",
    dept_title AS "�μ���",
    local_name AS "������",
    national_name AS "������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('�ѱ�' , '�Ϻ�')
AND ENT_YN = 'N';

-- 8. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ

SELECT 
    E2.emp_name AS "M.�̸�",
    E1.dept_code AS "�μ��ڵ�",
    E1.emp_name AS "E.�̸�"
FROM EMPLOYEE E1 
JOIN EMPLOYEE E2 ON (E1.DEPT_CODE = E2.DEPT_CODE)
WHERE E1.EMP_NAME != E2.EMP_NAME
ORDER BY E2.EMP_NAME ASC;

-- 9. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ���� ��, �޿� ��ȸ(NVL �̿�)

SELECT 
    emp_name AS "�����",
    job_name AS "���޸�",
    TRIM(TO_CHAR(salary  , 'L999,999,999')) || '��' AS "�޿�"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE NVL(BONUS , 0) = 0 AND E.JOB_CODE IN ('J4' , 'J7');


-- 10. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ

SELECT 
    E.*
FROM 
        (
             SELECT 
                 emp_id AS "���",
                 emp_name AS "�̸�",
                 dept_title AS "�μ���",
                 job_name AS "����",
                 hire_date AS "�Ի���",
                 RANK() OVER(ORDER BY ((salary + (salary *  NVL(bonus , 0))) * 12) DESC) AS "����"
             FROM EMPLOYEE E
             JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
             JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
        ) E
        
WHERE ���� <= 5;

-- 11. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ
-- 11-1. JOIN�� HAVING ���
SELECT
    dept_title AS "�μ���",
    TRIM(TO_CHAR(SUM(salary) , 'L999,999,999')) ||'��' AS "�μ��� �޿���"
FROM DEPARTMENT D
JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (
                        SELECT
                            SUM((salary) * 0.2)
                        FROM EMPLOYEE
                      );
-- 11-2. �ζ��� �� ���
SELECT
    "�μ���",
    "�μ��� �޿���"
FROM
    (
         SELECT 
             dept_title AS "�μ���",
             SUM(salary) AS "�μ��� �޿���"
         FROM DEPARTMENT
         JOIN EMPLOYEE ON (DEPT_ID = DEPT_CODE)
         GROUP BY DEPT_TITLE
    ) 
WHERE "�μ��� �޿���" > (
                            SELECT
                                SUM((salary) * 0.2)
                            FROM EMPLOYEE
                      );

                      
-- 12. �μ� ��� �μ� �� �޿� �հ� ��ȸ

SELECT 
    dept_title AS "�μ���",
    TRIM(TO_CHAR(SUM(salary) , 'L999,999,999')) || '��' AS "�μ� �� �޿� ��"
FROM DEPARTMENT D
RIGHT JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE)
GROUP BY DEPT_TITLE;


--------------------------------------------------------------------------------
-- 12. �μ� ��� �μ� �� �޿� �հ� ��ȸ

SELECT --9
    dept_title,
    SUM(SALARY) AS "�μ��� �޿� �հ�"
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


