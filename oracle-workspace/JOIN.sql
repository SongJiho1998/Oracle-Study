/*
    <JOIN>
    
    �ΰ� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ���� => SELECT�� �̿�
    ��ȸ ����� �ϳ��� �����(RESULT SET)���� ����.
    
    JOIN�� �ϴ� ����?
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����.
    ��������� ������̺� , ���������� �������̺� , ��� -> �ߺ��� �ּ��Ͻ�Ű������.
    => �� , JOIN ������ �̿��ؼ� ������ ���̺� ���� "����"�� �ξ ���� ��ȸ�ؾ���.
    => �� , ������ JOIN�� �ϴ°��� �ƴ϶� ���̺� ���� "�����"�� �ش�Ǵ� Į���� ��Ī���Ѽ� ��ȸ�ؾ���.
    
    ������ �з� : JOIN�� ũ�� "����Ŭ ���뱸��"�� ANSI(�̱� ���� ǥ�� ��ȸ)�������� ��������.
    
    ����� �з�
            ����Ŭ ���� ����               |               ANSI ����(����Ŭ + �ٸ� DBMS)
            �����(EQUAL JOIN)          |          ��������(INNER JOIN) -> JOIN USING/ON
            ---------------------------------------------------------------------------------
            ��������                      |          �ܺ�����(OUTER JOIN) -> JOIN USING
            LEFT OUTER JOIN              |          ���� �ܺ�����(LEFT OUTER JOIN)
            RIGHT OUTER JOIN             |          ������ �ܺ� ����(RIGHT OUTER JOIN)
                                                   ��ü �ܺ� ����(FULL OUTER JOIN) : ����Ŭ���� ���Ұ�.
    -------------------------------------------------------------------------------------------------------
            ī�׽þ� ��(CARTESIAN PRODUCT)  |         ���� ����(CROSS JOIN)
    -----------------------------------------------------------------------------------------------------------------
            ��ü ����(SELF JOIN)
            �񵿱� ����(NON EQUAL JOIN)
    ---------------------------------------------------------------------------------------------------------------------
                                ���� ����(���̺� 3���̻� ����)
*/

--SELECT *
--FROM EMPLOYEE , DEPARTMENT
--WHERE DEPT_CODE = DEPT_ID;

-- ������̺��� �μ� ����� �˰�������?
-- 1�ܰ� ������̺��� �μ��ڵ� ��ȸ
SELECT
    emp_id,
    emp_name,
    dept_code
FROM EMPLOYEE;

SELECT 
    dept_id,
    dept_title
FROM DEPARTMENT;

-- ��ü ������� ��� , ����� , �����ڵ������ �˶� ���� ����� �˾Ƴ����� �Ѵٸ�?
SELECT
    emp_id,
    emp_name,
    jOb_code
FROM EMPLOYEE;

SELECT
    job_code,
    job_name
FROM JOB;

--> ������ ���ؼ� ������� �ش�Ǵ� Į���鸸 ����� ��Ī��Ű�� �ϳ��� RESULTSET���� ��ȸ����������.


/*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
    �����Ű���� �ϴ� Į���� ���� "��ġ�ϴ� ��鸸" ���εǼ� ��ȸ.
    (== ��ġ���� �ʴ� ������ ������� ����)
    => ����񱳿����� = ("��ġ�Ѵ�"��� ������ ������)
    
    [ǥ����]
    �����(����Ŭ����)
    SELECT ��ȸ�ϰ����ϴ� �÷���� ����
    FROM �����ϰ����ϴ� ���̺��� ����
    WHERE ������ Į���� ���� ������ ����( = )
    
    ��������(ANSI����) : ON ����
    SELECT ��ȸ�ϰ����ϴ� Į����鳪��
    FROM �����ϰ����ϴ� ���̺�� 1�� ����
    JOIN �����ϰ����ϴ� ���̺�� 1���� ���� ON (������ �÷��� ���� ������ ���� (=))
    
    �������� (ANSI����) : USING ���� => �� , ������ Į������ �����Ѱ�쿡�� ��.
    SELECT ��ȸ�ϰ��� �ϴ� Į����� ����
    FROM �����ϰ����ϴ� ���̺�� 1��������
    JOIN ������ ���̺�� 1���� ���� USING(������ Į���� 1������)
    
    + ���࿡ ������ Į������ �����ѵ� USING������ ������� �ʴ°�� �ݵ��,
    ��������� ���̺�� OR ���̺��� ��Ī�� �ۼ��ؼ� ������̺��� Į������ �˷������.
    
*/

-- ����Ŭ ���뱸��

-- 1) ��ü ������� ��� , ����� , �μ��ڵ� , �μ������ �˾ƺ���.
-- FROM ���� ��ȸ�ϰ����ϴ� ���̺���� , �� �̿��ؼ� �����ϰ�
-- WHERE ���� ��Ī��ų �÷��� ���� ������ ����
SELECT 
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ���� �ʴ� �����͵��� ��ȸ���� ����(NULL)
--> �ΰ� �̻��� ���̺��� �����Ҷ� ��ġ�ϴ°��� ���� ���� ������� ���ܵǾ���.

SELECT 
    emp_id,
    emp_name,
    e.job_code,
    job_name
FROM EMPLOYEE e , JOB j --> �� ���̺��� ��Ī�� �ٿ��� ����ϴ� ����� ����.
WHERE e.JOB_CODE = j.JOB_CODE;
-- colum ambiguously defined -> Ȯ���� � ���̺��� Į�������� �� ����������.


-- ANSI����.
-- FROM�� �ڿ� �������̺��� 1���� ����.
-- �� �ڿ� JOIN ������ ���� ��ȸ�ϰ����ϴ� ���̺� ��� , ���� ��Ī��ų �÷��� ���� ���ǵ� ���� ���.
-- USING ���� / ON ����.

SELECT 
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- INNER�� ��������.

SELECT 
    emp_id,
    emp_name,
    job_code,
    job_name
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
-- UNSING���� : �÷Ÿ��� ������ ��쿡�� ��� ���� , ������ �÷��� �ϳ������ָ� �˾Ƽ� ��Ī������(AMBIGUIOUSLY �߻�X)

SELECT
    emp_id,
    emp_name,
    E.job_code,
    job_name
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

-- [����] �ڿ�����(NATURAL JOIN) : ����� ����� �ϳ�
-- => ������ Ÿ�԰� �̸��� ���� Į���� ���� �������� �̿��ϴ� ���.
SELECT  
    emp_id,
    emp_name,
    job_code,
    job_name
FROM EMPLOYEE
NATURAL JOIN JOB;
-- �ΰ��� ���̺��� �����ߴµ� �����Ե� �ΰ��� ���̺� ��ġ�ϴ� Į���� �� �ϳ� �����ϰ� �����ؼ� ������.
-- -> �ڿ������� �����ν� �˾Ƽ� ��Ī�Ǽ� ���ε�.

-- ������ �븮�� ������� ������ ��ȸ(��� , ����� , ���� , ���޸�).
SELECT
    emp_id,
    emp_name,
    salary,
    job_name
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '�븮';

-- ANSI �������� ���.
SELECT
    E.emp_id,
    E.emp_name,
    E.salary,
    J.job_name
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '�븮';

-- USING �������� ���.
SELECT
    emp_id,
    emp_name,
    salary,
    job_name
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

--------------------------------------------------------------------------------

-- 1. �μ��� �λ�������� ������� ��� , ����� , ���ʽ��� ��ȸ.
--> ����Ŭ���뱸��
SELECT
    emp_id,
    emp_name,
    bonus
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '�λ������';
--> ANSI����
SELECT
    emp_id,
    emp_name,
    bonus
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';
-- 2. �μ��� �ѹ��ΰ� �ƴ� ������� ��� , ����� , �޿� , �Ի�����ȸ.
--> ����Ŭ���뱸��
SELECT
    emp_id,
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_ID != '�ѹ���';
--> ANSI����
SELECT
    emp_id,
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_ID != '�ѹ���';
-- 3. ���ʽ��� �޴� ������� ��� , ����� , ���ʽ� , �μ��� ��ȸ
--> ����Ŭ���뱸��
SELECT
    emp_id,
    emp_name,
    bonus,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND NOT BONUS IS NULL;

--> ANSI����
SELECT
    emp_id,
    emp_name,
    bonus,
    dept_title
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE NOT BONUS IS NULL;
-- 4. �Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ� , �μ��� , �����ڵ� , ������(LOCAL_NAME)��ȸ
SELECT * FROM DEPARTMENT; -- LOCATION_ID
SELECT * FROM LOCATION; -- LOCATION_CODE
--> ����Ŭ���뱸��
SELECT 
    dept_id,
    dept_title,
    local_code,
    local_name
FROM DEPARTMENT , LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;
--> ANSI����
SELECT 
    dept_id,
    dept_title,
    local_code,
    local_name
FROM DEPARTMENT 
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


-- ����� / �������� : ��ġ���� ���� ���� ���ܵǰ� ��ȸ����.

--------------------------------------------------------------------------------

-- ��ü ������� ����� , �޿� , �μ���
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- DEPT_CODE�� NULL�� �θ��� ����� ��ȸ���� ����.

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    
    ���̺��� JOIN�ÿ� "��ġ���� �����൵" ���Խ�����.
    �� , �ݵ�� LEFT / RIGHT�� �����ؾ��Ѵ�. => ������ �Ǵ� ���̺��� �������ش�.
    
    ��ġ�ϴ��� + �����̵Ǵ� ���̺��� �������� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ������.
*/

-- 1) LEFT OUTER JOIN : �� ���̺��߿� ���� ����� ���̺��� �������� JOIN.
--                      �� , ���� �Ǿ��� ���� ���� ����� ���̺��� �����ʹ� ������ ��ȸ.

-- ANSI����
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- EMPLOYEE���̺��� �������� ��ȸ�߱� ������ , EMPLOYEE�� �����ϴ� �����ʹ� ��ġ�ϵ� ��ġ���� �ʵ� �� ��ȸ�ϰԲ��Ѵ�.

-- ����Ŭ ���뱸��
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- ���� �������� ���� ���̺��� �÷Ÿ��� �ƴ� , �ݴ� ���̺��� �÷��� (+)�� �ٿ��ش�.

-- 2) RIGHT OUTER JOIN : �� ���̺��� ������ ����� ���̺��� �������̺� ��ڴ�.
--                       �� , �����Ǿ��� ������ ����� ���̺����ʹ� ��� �������ڴ�.


-- ANSI ����

SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ����Ŭ ���뱸��
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL OUTER JOIN : �� ���̺��� ��� ���� ��ȸ
-- ��ġ�ϴ� ��� + LEFT OUTER JOIN ���� ���Ӱ� �߰����� + RIGHT OUTER JOIN ���� ���Ӱ� �߰��� ���


-- ANSI
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ����Ŭ ���뱸��
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);
-- ����Ŭ���뱸�� ������ FULL OUTER JOIN�� ���Ұ�

/*
    3. ī�׽þ��� ��(CARTESIAN PRODUCT) / ��������(CROSS JOIN)
    
    ��� ���̺��� �� ����� ���μ��� ���ε� ������ ��ȸ��(������)
    �� ���̺� ����� ��� ������ ����� ������ ��µ�.
    
    --> ���� N�� , M���� ���� ���� �����͵��� ī�׽þȰ��ǰ���� N*M��
    --> ��� ����� ���� �� ������ ��ȸ�ϰڴ�.
    --> ����� �����͸� ���(�������� ������ ����)
*/

SELECT 
    emp_name,
    dept_title
FROM EMPLOYEE , DEPARTMENT; -- 23 * 9 = 207�� ��ȸ.

-- ANSI ����
SELECT
    emp_name,
    dept_title
FROM EMPLOYEE
CROSS JOIN DEPARTMENT; -- 23 * 9 = 207�� ��ȸ.

-- ī�׽þ��� ���� ��� : WHERE���� ����ϴ� ���� ������ �߸��Ǿ��ų� , �ƿ� ������� �߻���.

/*
    4. �� ����(NON EQUAL JOIN)
    '=' (��ȣ) �� ������� �ʴ� ���ι� -> �ٸ� �� �����ڸ� �Ἥ �����ϰڴ�.( > , < , >= , <= , BETWEEN A AND B)
    => ������ Į�� ������ ��ġ�ϴ� ��찡 �ƴ϶� "����"�� ���ԵǴ� ��� ��Ī�ؼ� ��ȸ�ϰڴ�.
    
    EX) ����� = > '=' ���� ��ġ�ϴ� ��츸 ��ȸ
        ������ = > '=' �� �ƴ� �ٸ� �񱳿����ڵ�� '����'�� ���ԵǴ� ��츦 ��ȸ.
        
    
*/

-- ����� , �޿�
SELECT 
    emp_name,
    salary
FROM EMPLOYEE;

-- SAL_GRADE���̺� ��ȸ
SELECT * 
FROM SAL_GRADE;

-- ����� , �޿� , �޿����
--> ����Ŭ ���뱸��.
SELECT 
    emp_name,
    salary,
    S.sal_level
FROM EMPLOYEE E , SAL_GRADE S 
-- WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;


-- ANSI����
SELECT 
    emp_name,
    salary,
    e.sal_level
FROM EMPLOYEE e
--JOIN SAL_GRADE ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- USING������ �����(����� '=')������ �÷����� ������ ��츸 ��밡���ϴ�. -> �� ������ ON ������ ����Ѵ�.

/*
    5. ��ü����(SELF JOIN)
    
    ���� ���̺��� �����ϴ� ���
    �� , �ڱ� �ڽ��� ���̺�� �ٽ� ������ �ΰڴ�.
    => ��ü �����ǰ�� ���̺� �ݵ�� ��Ī�� �ٿ�����Ѵ�.(���� �ٸ� ���̺��ΰ�ó�� ���ν�Ű�� ����)
*/
SELECT * FROM EMPLOTEE E; -- ��������� ������ ����� ���̺�
SELECT * FROM EMPLOYEE M; -- ��������� ������ ����� ���̺�

-- ����Ŭ����
-- ����� ��� , ����� , ����ǻ�� , �����
SELECT
    E.emp_id AS "���",
    E.emp_name AS "�����",
    E.manager_id AS "����ǻ��",
    M.emp_name AS "�����"
FROM EMPLOYEE E , EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-- ANSI����
SELECT
    E.emp_id AS "���", 
    E.emp_name AS "�����",
    E.manager_id AS "������",
    M.emp_name AS "�����"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

/*
    <���� JOIN>
    3�� �̻��� ���̺��� �����ؼ� ��ȸ�ϰڴ�.
    => ���μ����� �߿�.
*/
-- ��� , ����� , �μ��� , ���޸�
SELECT * FROM EMPLOYEE; -- EMP_ID , EMP_NAME , DEPT_CODE , JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB; -- JOB_CODE

-- ����Ŭ����
SELECT
    emp_id AS "���",
    emp_name AS "�����",
    dept_title AS "�μ���",
    job_name AS "���޸�"
FROM EMPLOYEE E , DEPARTMENT , JOB J
WHERE E.DEPT_CODE = DEPT_ID(+) AND E.JOB_CODE = J.JOB_CODE(+);

-- ANSI����
SELECT
    emp_id AS "���",
    emp_name AS "�����",
    dept_title AS "�μ���",
    job_name AS "���޸�"
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT ON (E.DEPT_CODE = DEPT_ID)
LEFT OUTER JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);







