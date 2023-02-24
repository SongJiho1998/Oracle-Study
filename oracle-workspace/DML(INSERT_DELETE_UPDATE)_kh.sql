/*
    DML(DATA MENIPULATION LANGUAGE)
    
    ������ ���� ���
    
    ���̺� ���մ� �����͸� ����(INSERT)�ϰų�
    ������ �����͸� ����(UPDATE)�ϰų�
    ����(DELETE)�ϴ� ����
*/

/*
    1. INSERT : ���̺� ���ο� ���� �߰��ϴ� ����
    
    [ǥ����]
    INSERT INTO �迭
    
    1)�� ��� : INSERT INTO ���̺�� VALUES(��1 , ��2 , ��3)
    => �ش� ���̺� ��� �÷��� ���� �߰��ϰ��� �Ҷ� ����ϴ� ���.
    ���ǻ��� : �÷��� ���� , �ڷ��� , ������ ���缭 VALUES��ȣ�ȿ� ���� �����ؾ���.
    - �����ϰ� ����������� : NOT ENOUGH VALUES ����
    - ���� �� ���� �����ϴ°�� : TOO MANY VALUES ����
*/

-- EMPLOYEE���̺� ������� �߰�
INSERT INTO EMPLOYEE
VALUES (900 , '����ȣ' , '990512-1234567' , 'sung7054@naver.com' , '01038277054' , 'D1' , 'J7' , 'S2' , 5000000 , 0.5 , 200 , 
SYSDATE , NULL , DEFAULT -- DEFAULT������ �־��.                                   
);
-- value too large for column "KH"."EMPLOYEE"."PHONE" (actual: 13, maximum: 12)
-- ���� �������� ���� ũ��(actual) -> �ڷ����� ũ��(maximum)�� ��� �߻�.

SELECT * FROM EMPLOYEE;

/*
    2�� ��� : INSERT INTO ���̺��(Į����1 , Į����2 , Į����3) VALUES (��1 , ��2 , ��3);
    -> �ش� ���̺� "Ư��"Į���� �����ؼ� �� Į���� �߰��� ���� �����ϰ��� �Ҷ� ���.
    
    - �׷��� �� �� ������ �߰��Ǳ� ������ ������ �ȵ� Į���� �⺻������ NULL���� ��.
    - �� , DEFAULT ������ �Ǿ��ִ� ��� �⺻���� ��.
    
    ���ǻ��� : NOT NULL ���������� �ɷ��ִ� Į���� �ݵ�� �����ؼ� ���� ���� �����ؾ���.
             �ٸ� DEFAULT ������ �Ǿ��ִٸ� NOT NULL �̶�� �ص� ���� ���ص� ��.
*/

INSERT INTO EMPLOYEE(EMP_ID , EMP_NAME , EMP_NO , DEPT_CODE , JOB_CODE , SAL_LEVEL , HIRE_DATE)
VALUES (901 , '��ȣ2' , '980831-1234567' , 'D2' , 'J2' , 'S5' , SYSDATE);

/*
    3�� ��� ) INSERT INTO ���̺�� (��������);
    => VALUES()�� ���� ���� �����ϴ� ���� �ƴ϶�
       ���������� ��ȸ�� ������� ��°�� INSERT �ϴ� ����
       �� �������� �ѹ��� INSERT�Ҽ� �ִ�.
*/

CREATE TABLE EMP_01(
    EMP_ID NUMBER , 
    EMP_NAME VARCHAR2(30),
    DAPT_TITLE VARCHAR2(20)
);

-- ��ü ������� ��� , �̸� , �μ����� ��ȸ�� ����� EMP_01���̺� ��°�� �߰�.
SELECT
    emp_id,
    emp_name,
    dept_title
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01
(
   SELECT
        emp_id,
        emp_name,
        dept_title
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

/*
    INSERT ALL �迭
    �� �� �̻��� ���̺� ���� INSERT �� �� ���
    ���� : �׶� ���Ǵ� ���������� �����ؾ��Ѵ�.
    
    1) INSERT ALL   
        INTO ���̺��1 VALUES(�÷��� , �÷��� , ...)
        INTO ���̺��2 VALUES(�÷��� , �÷��� , ,...)
             ��������;
*/

-- ���ο� ���̺� �����
-- ù��° ���̺� : �޿��� 300���� �̻��� ������� ��� , ����� , ���޸� ���������̺�
-- ���̺�� : EMP_ID / EMP_ID , EMP_NAME , JOB_NAME
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(30)
);
-- �ι�° ���̺� : �޿��� 300���� �̻��� ������� ��� , ����� , �μ��� ���������̺�
-- ���̺�� : EMP_DEPT / EMP_ID , EMP_NAME , DEPT_TITLE
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(30)
);

-- �޿��� 300���� �̻��� ������� ��� , ����� , ���޸� , �μ����� ��ȸ
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE SALARY >= 3000000;

-- 
INSERT ALL
INTO EMP_JOB VALUES(EMP_ID , EMP_NAME , JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID , EMP_NAME , DEPT_TITLE)
     SELECT
        EMP_ID,
        EMP_NAME,
        JOB_NAME,
        DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE)
    WHERE SALARY >= 3000000;

/*
    2) INSERT ALL
        WHEN ����1 THEN 
            INTO ���̺��1 VALUES(Į���� , Į����)
        WHEN ����2 THEN
            INTO ���̺��2 VALUES(Į���� , Į����)
            
        ��������
*/

-- ������ ����ؼ� �� ���̺� �� INSERT
-- ���ο� �׽�Ʈ�� ���̺� ����
-- 2010�⵵ �������� ������ �Ի��� ������� ��� , ����� , �Ի��� , �޿��� ��� ���̺�(EMP_OLD)
CREATE TABLE EMP_OLD
AS SELECT
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

-- 2010�⵵ �������� ���Ŀ� �Ի��� ������� ��� , ����� , �Ի��� , �޿��� ��� ���̺�(EMP_NEW)

CREATE TABLE EMP_NEW
AS SELECT
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

-- 1) �������� �κ�
-- 2010�� ���� , ����
SELECT 
    EMP_ID,
    EMP_NAME,
    HIRE_DATE,
    SALARY
FROM EMPLOYEE
WHERE HIRE_DATE < '2010/01/01'; -- EMP_OLD
-- WHERE HIRE_DATE >= '2010/01/01' -- EMP_NEW

INSERT ALL 
     WHEN HIRE_DATE < '2010/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID , EMP_NAME , HIRE_DATE , SALARY)
     WHEN HIRE_DATE >= '2010/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID , EMP_NAME , HIRE_DATE , SALARY) 
     
     SELECT
--        EMP_ID,
--        EMP_NAME,
--        HIRE_DATE,
--        SALARY
        * -- *�ε� ���ð� ������.
     FROM EMPLOYEE;


/*
    2. UPDATE
    
    ���̺� ��ϵ� ������ �����͸� "����"�ϴ� ����.
    
    [ǥ����]
    UPDATE ���̺��
    SET �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�, ... -- �������� �÷������� ���ú��� ����(,�� �����ؾ���)
    WHERE ����; -- WHERE�� ���� �����ϳ� , ������ "���" ���� �����Ͱ� �� ����Ǿ����.
*/

-- ���纻 ���̺� ���� �� �۾�.
CREATE TABLE DEPT_COPY
AS SELECT * 
FROM DEPARTMENT;

-- DEPT_COPY���̺��� D9�μ��� �μ����� ������ȹ������ ����.
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9'; -- ������ ���ܽ� 9������ ��� ������Ʈ��.
-- ��ü ���� ��� DEPT_TITLE�� ������ȹ������ �����Ǿ���.

ROLLBACK; -- ������׿� ���ؼ� �ǵ����� ��ɾ� : ROLLBACK;

SELECT * FROM DEPT_COPY;

-- WHERE���� ���ǿ����� 1�� Ȥ�� �������� ���� ���ÿ� ������ �����ϴ�.

-- ���纻���̺� 
-- EMPLOYEE���̺�κ��� EMP_ID , EMP_NAME , DEPT_CODE , SALARY , BONUS(������ ����)
-- EMP_SALARY
CREATE TABLE EMP_SALARY
AS SELECT
        EMP_ID,
        EMP_NAME,
        DEPT_CODE,
        SALARY,
        BONUS
    FROM EMPLOYEE;

-- 1) EMP_SALARY ���̺��� ���ö ����� �޿��� 10000000�������� ����.
UPDATE EMP_SALARY
    SET SALARY = 10000000
    WHERE EMP_NAME = '���ö';

-- 2) EMP_SALARY ���̺��� ������ ����� �޿��� 7000000 , ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
    SET SALARY = 7000000,
        BONUS = 0.2
    WHERE EMP_NAME = '������';

-- 3) ��ü ����� �޿��� ������ �޿��� 20% �λ��� �ݾ� ����.
UPDATE EMP_SALARY
    SET SALARY = ((SALARY * 0.2) + SALARY);

SELECT * FROM EMP_SALARY;

/*
    UPDATE �ÿ� �������� ���
    ���������� ������ ��������� ������ �����κ��� �����ϰڴ�.
    
    - CREATE �ÿ� �������� ��� : ���������� ������ ����� ���̺� ���鶧 �־�����ڴ�.
    - INSERT �ÿ� �������� ��� : ���������� ������ ����� �ش� ���̺� �����ϰڴ�.
    
    [ǥ����]
    UPDATE ���̺��
    SET �÷��� = (��������)
    WHERE ����; -- ��������.
*/

-- EMP_SALARY ���̺� ����ȣ ����� �μ��ڵ带 ������ ����� �μ��ڵ�� ����.
-- ����ȣ ����� �μ��ڵ� = D1 , ������ ����� �μ��ڵ� = D9
SELECT
    DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

UPDATE EMP_SALARY
SET DEPT_CODE = (
                    SELECT
                        DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������'
                    )
WHERE EMP_NAME = '����ȣ';

SELECT * FROM EMP_SALARY;

-- ���� ����� �޿��� , ���ʽ��� ����� ����� �޿��� ���ʽ� ������ ����.
-- ������ ���߿� �������� (���Ұ� 1 , ���Ұ� 2) = (���Ұ� 1 , ���Ұ� 2)
UPDATE EMP_SALARY 
SET (SALARY , BONUS) = (
                            SELECT
                                SALARY,
                                BONUS
                            FROM EMP_SALARY
                            WHERE EMP_NAME = '�����'
)
WHERE EMP_NAME = '����';

-- ������Ʈ ���ǻ��� : UPDATE�Ҷ��� �ش�Į���� ���������� �ؼ��ؾ��Ѵ�.


-- EMPLOYEE���̺��� ������ ����� ����� 200���� ����.
UPDATE EMPLOYEE
SET EMP_ID = 200
WHERE EMP_NAME = '������'; -- PK�������� ����.

-- 200���� ����� NULL�� ����
UPDATE EMPLOYEE
SET EMP_ID = NULL -- NOT NULL �������� ����.
WHERE EMP_ID = 200;

-- ��� ��������� Ȯ������ ��ɾ� : COMMIT;
COMMIT;


/*
    4. DELETE
    
    ���̺� ��ϵ� �����͸� "��"������ �����ϴ� ����.
    
    [ǥ����]
    DELETE FROM ���̺��
    WHERE ���� ; -- WHERE �������� . ������ "���"�� ����.
*/

-- EMPLOYEE���̺��� ����� ����
DELETE FROM EMPLOYEE;
-- ���빰���� �������������� ���̺� ��ü�� �������� �ƴ�.
SELECT * FROM EMPLOYEE;

ROLLBACK; -- �ѹ�� ���������� "Ŀ��"�� �������� ���ư���. 

-- EMPLOYEE���̺�κ��� ����ȣ , ��ȣ2 ����� ������ �����
DELETE EMPLOYEE
WHERE (EMP_NAME = '����ȣ' OR EMP_NAME = '��ȣ2');

-- WHERE �������� ���� �������� �����ɼ� ����

COMMIT;

-- DEPARTMENT ���̺�κ��� DEPT_ID�� D1�κμ� ����.
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- ���࿡ EMPLOYEE���̺��� DEPT_CODE�÷����� �ܷ�Ű�� �����ϰ� ������쿡
-- ������ ���� �ʾ�������. ������ �Ǿ��ٴ� ���� �� , �ܷ�Ű�� ����ϰ� ���� �ʴ�.

ROLLBACK;

/*
    TRUNCATE : ���̺��� ��ü ���� ��� �����Ҷ� ����ϴ� ����(����)
               DELETE�������� ����ӵ��� ����.
               ������ �������� �Ұ�.
               ROLLBACK�� �Ұ�����.
               
    [ǥ����]
    TRUNCATE TABLE ���̺��;
    
    DELETE ������ ��
        TRUNCATE TABLE ���̺��       |       DELETE FROM ���̺��
    ----------------------------------------------------------------------------
        ������ ���� ���� �Ұ�(WHERE X)  |       Ư�� ���� ���� ����(WHERE O)
        ����ӵ��� ����(���������)      |        ����ӵ��� ����
        ROLLBACK �Ұ�                |       ROLLBACK ����
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY; -- �߷Ƚ��ϴ�. ��� ǥ�� . �ѹ�Ұ�.














