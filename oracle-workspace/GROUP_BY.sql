/*
    <GROUP BY ��>
    
    �׷��� ������ ������ ������ �� �ִ� ���� -> �׷��Լ��� ���� ����.
    �ش� ���õ� ���غ��� �׷��� ������ ����.
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
    
    [ǥ����]
    GROUP BY ������ �����̵� Į��.
    
*/

SELECT DEPT_CODE , SUM(SALARY) -- 4
FROM EMPLOYEE -- 1
WHERE 1=1 -- 2
GROUP BY DEPT_CODE -- 3
ORDER BY DEPT_CODE; -- 5

-- D1�μ��� �޿� ����

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- �� �μ��� �����

SELECT DEPT_CODE , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿� ���� �޿����� ������������ �����ؼ� ��ȸ.

SELECT 
    DEPT_CODE,
    SUM(SALARY) AS "�޿�"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
ORDER BY "�޿�" DESC;

-- �� ���޺��� �����ڵ� , �� �޿��� �� , ����� , ���ʽ��� �޴� ����� , ��ձ޿� , �ְ�޿� , �ּұ޿�.
-- JOB�ڵ庰�� �������� ����

SELECT
    
    JOB_CODE AS "�����ڵ�",
    SUM(salary) AS "�� �޿��� ��",
    COUNT(salary) AS "�����",
    COUNT(bonus) AS "���ʽ� �޴� �����",
    FLOOR(AVG(salary)) AS "��ձ޿�",
    MAX(salary) AS "�ְ�޿�",
    MIN(salary) AS "�ּұ޿�"

FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

-- �� �μ��� �μ��ڵ� , ����� , ���ʽ��� �޴� ����� , ����� �ִ� ����� , ��ձ޿�
-- �μ��� ������������

SELECT 
    dept_code AS "�μ��ڵ�",
    COUNT(*) AS "�����",
    COUNT(bonus) AS "���ʽ��� �޴� �����",
    COUNT(manager_id) AS "����� �ִ� �����",
    FLOOR(AVG(salary)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY dept_Code
ORDER BY DEPT_CODE ASC;

-- ���� �� �����
-- SUBSTR(EMP_NO , 8 , 1) == 1 , 2

SELECT 
    DECODE(SUBSTR(emp_no , 8 , 1) , '1' , '����' , '2' , '����') AS "����",
    COUNT(*) AS "�����"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO , 8 , 1);

-- ���� �������� ���� , ��ձ޿� , �����
-- CASE WHEN �������� ���� , ����
-- ��ձ޿��� "��"

SELECT
    CASE WHEN SUBSTR(EMP_NO , 8 , 1) = '1' THEN '����'
         WHEN SUBSTR(EMP_NO , 8 , 1) = '2' THEN '����'
    END AS "����",
    TRIM(TO_CHAR(FLOOR(AVG(salary)) , 'L999,999,999')) || '��' AS "��ձ޿�",
    COUNT(*) || '��' AS "�����"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO , 8 , 1);

-- �� �μ��� ��ձ޿��� 300���� �̻��� �μ��鸸 ��ȸ.

SELECT  
    dept_Code AS "�μ��ڵ�",
    TRIM(TO_CHAR(FLOOR(AVG(salary)) , 'L999,999,999')) || '��' AS "��ձ޿�"
FROM EMPLOYEE
WHERE FLOOR(AVG(SALARY)) >= 3000000
GROUP BY DEPT_CODE; -- ������


/*
    <HAVING
    �׷쿡 ���� ������ �����ϰ��� �Ҷ� ���Ǵ� ����
    (�ַ� �׷��Լ��� ������ ��������) => GROUP BY ���� �Բ� ���δ�.
*/

SELECT  
    dept_Code AS "�μ��ڵ�",
    TRIM(TO_CHAR(FLOOR(AVG(salary)) , 'L999,999,999')) || '��' AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000;

-- �� ���޺��� �� �޿����� 1000���� �̻��� ���� �ڵ� , �޿� ������ȸ.

SELECT 
    job_code AS "�����ڵ�",
    TRIM(TO_CHAR(SUM(salary) , 'L999,999,999')) || '��' AS "�޿���"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;
-- �� ���޺��� �޿� ����� 300���� �̻��� �����ڵ� , ��ձ޿� , ����� , �ְ�޿� , �ּұ޿�

SELECT 
    job_code AS "�����ڵ�",
    TRIM(TO_CHAR(AVG(salary) , 'L999,999,999')) || '��' AS "��ձ޿�",
    COUNT(*) || '��' AS "�����",
    TRIM(TO_CHAR(MAX(salary) , 'L999,999,999')) || '��' AS "�ְ�޿�",
    TRIM(TO_CHAR(MIN(salary) , 'L999,999,999')) || '��' AS "�ּұ޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING AVG(SALARY) >= 3000000;


-- �� �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ.

SELECT 
    dept_code,
    COUNT(bonus)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-- �� �μ��� ��� �޿��� 350���� ������ �μ����� ��ȸ.

SELECT 
    dept_code,
    TRIM(TO_CHAR(FLOOR(AVG(salary)) , 'L999,999,999'))  || '��' AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) <= 3500000;


--------------------------------------------------------------------------------

/*
    <SELECT�� ���� �� �������>
    5. SELECT ��ȸ�ϰ��� �ϴ� �÷���帣 ���� / * / ���ͷ� / �������� / �Լ��� AS ��Ī
    1. FROM ��ȸ�ϰ��� �ϴ� ���̺�� / DUAL(�������̺�)
    2. WHERE ���ǽ�(�׷��Լ� X)
    3. GROUP BY �׷� ���ؿ� �ش��ϴ� Į���� / �Լ���
    4. HAVING �׷��Լ��Ŀ� ���� ���ǽ�
    6. ORDER BY [���ı��ؿ� �ش��ϴ� �÷��� / ��Ī / �÷��� ����] [ASC / DESC] [NULLS FIRST / NULLS LAST]
*/

--------------------------------------------------------------------------------

/*
    <���� ������ SET OPERATOR>
    
    ���� ���� �������� ������ �ϳ��� ���������� ����� ������.
    
    - UNION(������) : �� �������� ������ ������� ���� �� �ߺ��Ǵ� �κ��� �ѹ��� ���� �ߺ��� �����Ѱ� => OR
    - UNION ALL : �� �������� ������ ������� ���� �� �ߺ� ���Ÿ� ���� ���� ��.
                  => ������ + ������
    - INTERSECT(������) : �� �������� ������ ������� �ߺ��� �κ� => AND
    - MINUS(������) : ���� ������ ��������� ���� ������ ������� �� ������ �κ�.
                     -> ���� ������ ����� - ������1
                     
    �������� : �� �������� ����� ���ļ� �Ѱ��� ���̺�� ������� �ϱ� ������ 
              �� �������� SELECT�� �κ��� ���ƾ��Ѵ� -> �� , ��ȸ�� Į���� �����ؾ���.
*/

-- 1. UNION : �� �������� ������ ������� �������� �ߺ��� ��������.

-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ(��� , ����� , �μ��ڵ� , �޿�) 

-- �μ��ڵ尡 D5�� ����鸸 ��ȸ
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6�� ��ȸ.

-- �޿��� 300���� �ʰ��� �����
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY >= 3000000; -- 8���� �μ��ڵ尡 D5�� ����� 2�� ����.

-- UNION �� ��� --
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION

SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ
-- �����ڵ尡 J6�̰ų� �Ǵ� �μ��ڵ尡 D1�� �������ȸ
SELECT 
    emp_id,
    emp_name,
    dept_code,
    salary    
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D5' OR SALARY > 3000000) -- 12��

UNION
--INTERSECT
--UNION ALL

SELECT 
    emp_id,
    emp_name,
    dept_code,
    salary    
FROM EMPLOYEE
WHERE (JOB_CODE = 'J6' OR DEPT_CODE = 'D1'); -- 7��


-- 2. UNION ALL : �������� ��������� ���ؼ� �����ִ� ������(�ߺ����Ÿ� ����!)

-- �����ڵ尡 J6�̰ų� �Ǵ� �μ��ڵ尡 D1�� ����� ��ȸ(��� , ����� , �μ��ڵ� , �����ڵ�)

-- 1. �ߺ����������ʰ� , ��ü�����ȸ
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' -- 6���� ����� ��� ���� �μ��ڵ尡 D1�� ����� 2

UNION ALL

SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'; -- 3���ְ� J6�� ����� 2��

-- 3. INTERSECT : ������ , ���� ��������� �ߺ��� ������� ��ȸ(AND)
-- 2. �ߺ��� ����� ��ȸ.
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' -- 6���� ����� ��� ���� �μ��ڵ尡 D1�� ����� 2

INTERSECT 

SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'; -- 3���ְ� J6�� ����� 2��

-- 4. MINUS : ������ , �������� ����� ���� ���� ����� �� ������.

SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' -- 6���� ����� ��� ���� �μ��ڵ尡 D1�� ����� 2

MINUS

SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'; -- 3���ְ� J6�� ����� 2��






