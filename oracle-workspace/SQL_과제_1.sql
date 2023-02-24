--1. JOB ���̺��� ��� ���� ��ȸ
SELECT *
FROM JOB;
--2. JOB ���̺��� ���� �̸� ��ȸ
SELECT
    job_name
FROM JOB;
--3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT *
FROM DEPARTMENT;
--4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT 
    emp_name AS "������",
    email AS "�̸���",
    SUBSTR(phone, 1, 3) || '-' || SUBSTR(phone, 4, 4) || '-'|| SUBSTR(phone, 8) AS "��ȭ��ȣ",
    hire_date AS "�����"
FROM EMPLOYEE;
--5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT
    hire_date AS "�����",
    emp_name AS "�̸�",
    TRIM(TO_CHAR(salary , 'L999,999,999')) || '��' AS "����"
FROM EMPLOYEE;
--6. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT 
    emp_name AS "�̸�",
    TRIM(TO_CHAR((salary * 12) , 'L999,999,999') || '��') AS "����",
    TRIM(TO_CHAR((((salary * NVL(bonus , 0)) +  salary) * 12) , 'L999,999,999') || '��') AS "�Ѽ��ɾ�",
    TRIM(TO_CHAR(((((salary * NVL(bonus , 0)) +  salary ) * 12) - ((salary * 12) * 0.03)) , 'L999,999,999') || '��') AS "�Ǽ��ɾ�"
FROM EMPLOYEE;
--7. EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT 
    emp_name AS "�̸�",
    TRIM(TO_CHAR(salary , 'L999,999,999'))  || '��' AS "����",
    hire_date AS "�����",
    SUBSTR(phone, 1, 3) || '-' || SUBSTR(phone, 4, 4) || '-'|| SUBSTR(phone, 8) AS "����ó"
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';
--8. EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT
    emp_name AS "�̸�",
    TRIM(TO_CHAR(salary , 'L999,999,999'))  || '��' AS "����",
      TRIM(TO_CHAR(((((salary * NVL(bonus , 0)) +  salary ) * 12) - ((salary * 12) * 0.03)) , 'L999,999,999') || '��') AS "�Ǽ��ɾ�",
    hire_date AS "�����"
FROM EMPLOYEE
WHERE (((salary * NVL(bonus , 0)) +  salary ) * 12) - ((salary * 12) * 0.03) >= 50000000;
    
--9. EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';
--10. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� ��
-- ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT 
    emp_name AS "�̸�",
    dept_code AS "�μ��ڵ�",
    hire_date AS "�����"
FROM EMPLOYEE
WHERE DEPT_CODE IN('D9' , 'D5') AND HIRE_DATE < '02/01/01';
--11. EMPLOYEE���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
--12. EMPLOYEE���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT 
    emp_name AS "�̸�"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
--13. EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT 
    emp_name AS "�̸�",
    SUBSTR(phone, 1, 3) || '-' || SUBSTR(phone, 4, 4) || '-'|| SUBSTR(phone, 8) AS "����ó"
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';
--14. EMPLOYEE���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
-- ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (INSTR(EMAIL , '_' , 1) -1) = 4 AND DEPT_CODE IN ('D9' , 'D6') AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' AND SALARY >= 2700000;
--15. EMPLOYEE���̺��� ��� ��� ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
SELECT
--EXTRACT(YEAR FROM SYSDATE),
--EXTRACT(MONTH FROM SYSDATE),
--EXTRACT(DAY FROM SYSDATE)
    emp_name,
    TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1, 6)) , 'YYYY"��"') AS "����",
    TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1, 6)) , 'MM"��"') AS "����",
    TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1, 6)) , 'DD"��"') AS "����"
FROM EMPLOYEE;
--16. EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
SELECT
    emp_name,
    RPAD(SUBSTR(EMP_NO , 1 , 7) , 14 , '*') AS "�ֹε�Ϲ�ȣ"
FROM EMPLOYEE;
--17. EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- (��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)
SELECT 
    emp_name AS "�����",
    ABS(FLOOR(hire_date - sysdate)) AS "�ٹ��ϼ�1",
    FLOOR(sysdate - hire_date) AS "�ٹ��ϼ�2"
FROM EMPLOYEE;
--18. EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID , 2) = '1';
--19. EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(hire_date) , 'YYYY') >= 20;
--20. EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000' �������� ǥ��)
SELECT
    emp_name AS "�����",
    TRIM(TO_CHAR(salary , 'L999,999,999')) || '��' AS "�޿�"
FROM EMPLOYEE;
--21. EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
-- (��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)
SELECT
    emp_name AS "������",
    dept_code AS "�μ��ڵ�",
    TO_CHAR(TO_DATE(SUBSTR(emp_no , 1, 6)) , 'YY"��" MM"��" DD"��"') AS "�������",
    (TO_CHAR(TO_DATE(sysdate) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(emp_no , 1, 6)) , 'YYYY')) || '��' AS "����"
FROM EMPLOYEE;
--22. EMPLOYEE���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�� ��ȹ��, D9�� �����η� ó��
-- (��, �μ��ڵ� ������������ ����)
SELECT 
    emp_name AS "�̸�",
    CASE WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
         WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
         WHEN DEPT_CODE = 'D9' THEN '������'
    END AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5' , 'D6' , 'D9')
ORDER BY DEPT_CODE ASC;
--23. EMPLOYEE���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�, 
-- �ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
SELECT
    emp_name AS "�����",
    SUBSTR(emp_no , 1 , 6) AS "�ֹι�ȣ ���ڸ�",
    SUBSTR(emp_no , 8) AS "�ֹι�ȣ ���ڸ�",
    TO_NUMBER(SUBSTR(emp_no , 1 , 6)) + TO_NUMBER(SUBSTR(emp_no , 8)) AS "(���ڸ� + ���ڸ�)"
FROM EMPLOYEE
WHERE EMP_ID = 201;
--24. EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� ��ȸ
SELECT
    TRIM(TO_CHAR(SUM(((salary * NVL(bonus , 0)) + salary) * 12) , 'L999,999,999')) || '��' AS "���ʽ�����(����)"
FROM EMPLOYEE
WHERE dept_code = 'D5';
--25. EMPLOYEE���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
-- ��ü ���� ��, 2001��, 2002��, 2003��, 2004��
SELECT 
    COUNT(*) || '��' AS "��ü ���� ��",
    COUNT(DECODE(TO_CHAR(hire_date,'yyyy'),'2001',1)) || '��' AS "2001��",
    COUNT(DECODE(TO_CHAR(hire_date,'yyyy'),'2002',1)) || '��' AS "2002��",
    COUNT(DECODE(TO_CHAR(hire_date,'yyyy'),'2003',1)) || '��' AS "2003��",
    COUNT(DECODE(TO_CHAR(hire_date,'yyyy'),'2004',1)) || '��' AS "2004��"
FROM EMPLOYEE;

