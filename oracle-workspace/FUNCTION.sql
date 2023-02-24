/*
    <�Լ� FUNCTION>
    �ڹٷ� ������ �޼ҵ�� ���� ����
    �Ű������� ���޵� ������ �о ����� ����� ��ȯ -> ȣ���ؼ� �� ��.
    
    - ������ �Լ� : N���� ���� �о N���� ����� ����(�� �ึ�� �Լ� ���� �� ��� ��ȣ)
    - �׷� �Լ� : N���� ���� �о 1���� ����� ����(�ϳ��� �׷캰�� �Լ� ���� �� ��� ��ȯ)
    
    ������ �Լ��� �׷� �Լ��� �Բ� ��� �� �� ���� : ��� ���� ������ �ٸ��� ����.
    
*/
------------------------------ < ������ �Լ�> ------------------------------

/*
    LENGTH / LENGTHB
    
    - LENGTH(���ڿ�) : �ش� ���޵� ���ڿ��� ���ڼ� ��ȯ.
    - LENGTHB(���ڿ�) : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ.
    
    ������� ���ڷ� ��ȯ -> NUMBER
    ���ڿ� : ���ڿ� ������ ���ͷ� , ���ڿ��� �ش��ϴ� Į��
    
    �ѱ� : �� -> '��' , '��' , '��' => �ѱ��ڴ� 3BYTE���
    ���� , ���� , Ư������ : �� ���ڴ� 1BYTE���
*/

SELECT LENGTH('����Ŭ!') , LENGTHB('����Ŭ!')
FROM DUAL; --    4                   10
--> ���� ���̺� : ��������̳� �����÷��� ���� �ѹ��� ����ϰ� ������ ����ϴ� ���̺�(DUAL)

-- �̸��ϰ� , ����̸��� Į���� , ���ڼ� , ����Ʈ���ڼ�
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
    - INSTR(���ڿ� , Ư������ , ã����ġ�� ���۰� , ����) : ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ.
    
    ã�� ��ġ�� ���۰� , ������ ���� ����
    ������� NUMBER Ÿ������ ��ȯ.
    
    ã�� ��ġ�� ���۰� (1 / -1)
    1 : �տ������� ã�ڴ�. (������ �⺻��)
    -1 : �ڿ������� ã�ڴ�.
*/

SELECT INSTR('AABAACAABBAA' ,'B') FROM DUAL; -- 3
-- ã�� ��ġ , ������ ���� : �⺻������ �տ������� ù��° ������ ��ġ�� �˷���

SELECT INSTR('AABAACAABBAA' , 'B' , 1) FROM DUAL; -- 3
-- ���� ������ ����� ��ȯ.

SELECT INSTR('AABAACAABBAA' , 'B' , -1) FROM DUAL; -- 10
-- �ڿ������� ù��° ������ ��ġ�� �˷���.

SELECT INSTR('AABAACAABBAA' , 'B' , -1 , 2) FROM DUAL; -- 9
-- �ڿ������� �ι�° ��ġ�ϴ� B�ǰ��� ��ġ���� �տ������� ���� �˷��ذ�.

SELECT INSTR('AABAACAABBAA' , 'B' , -1 , 0) FROM DUAL; -- �����߻�
-- ������ ��� ������ �����Ѱ�� ���� �߻�.

SELECT INSTR(EMAIL , '#') -- ���Ե��� ���� �� '#' �� �־��� ��� 0���� ��ȯ
FROM EMPLOYEE;

/*
    SUBSTR
    
    ���ڿ����� Ư�� ���ڿ��� �����ϴ� �Լ� 
    - SUBSTR(���ڿ� , ó����ġ , ������ ���� ����)
    
    ������� CHARACTERŸ������ ��ȯ(���ڿ�)
    ������ ���� ������ ��������(���������� ���ڿ� ������ ����.)
    ó����ġ�� ������ ���� ���� : �ڿ������� N��° ��ġ�κ��� ���ڸ� �����ϰڴ� ��� ��.
    
*/

SELECT SUBSTR('SHOWMETHEMONEY' , 7) FROM DUAL; -- THEMONEY

SELECT SUBSTR('SHOWMETHEMONEY' , 5 , 2) FROM DUAL; -- ME

SELECT SUBSTR('SHOWMETHEMONEY' , -8 , 3) FROM DUAL; -- THE

SELECT SUBSTR('SHOWMETHEMONEY' , -5) FROM DUAL; -- MONEY

-- �ֹε�Ϲ�ȣ���� ���� �κ��� �����ؼ� ����(1) ����(2)�� üũ.
SELECT 
    emp_name,
    SUBSTR(emp_no , 8 , 1) AS "����" 
FROM EMPLOYEE;

-- �̸��Ͽ��� ID�κи� �����ؼ� ��ȸ
SELECT 
    emp_name,
    SUBSTR(email , 1 , INSTR(email , '@') -1) AS "ID" 
FROM EMPLOYEE;

-- ���� ����鸸 ��ȸ.
SELECT * 
FROM  EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = '1';

/*
    LPAD / RPAD 
     - LPAD/RPAD(���ڿ� , ���������� ��ȯ�� ������ ����(BYTE) , �����̰��� �ϴ� ����)
     : ������ ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ.
     
*/

SELECT LPAD(EMAIL , 16)
FROM EMPLOYEE;

SELECT RPAD(EMAIL , 20)
FROM EMPLOYEE;

SELECT 
    emp_name,
    RPAD(SUBSTR(EMP_NO ,1 , 8 )  , 14 , '*') AS "�ֹε�Ϲ�ȣ" 
FROM EMPLOYEE;

-- 621235-1******
-- 1�ܰ� : SUBSTR�Լ��� �̿��ؼ� �ֹι�ȣ �� 8�ڸ��� ����.
SELECT 
    emp_name,
    SUBSTR(emp_no , 1 , 8) AS �ֹι�ȣ
FROM EMPLOYEE;
-- 2�ܰ� : RPAD�Լ��� ��ø�ؼ� �ֹι�ȣ�ڿ� *���̱�
SELECT 
    emp_name,
    RPAD(SUBSTR(EMP_NO ,1 , 8 )  , 14 , '*') AS �ֹι�ȣ
FROM EMPLOYEE;

------------------------------ < ���� > ------------------------------

SELECT
    emp_id,
    emp_name,
    RPAD(SUBSTR(EMP_NO , 1 ,8) , 14 , '*') AS "�ֹε�Ϲ�ȣ"
FROM EMPLOYEE;

SELECT
    emp_id AS "�����ȣ",
    RPAD(SUBSTR(EMP_NAME , 1, 2) , 5 , '*') AS "�̸�" ,
    RPAD(SUBSTR(EMP_NO , 1 ,8) , 14 , '*') AS "�ֹε�Ϲ�ȣ",
    SUBSTR(RPAD(SUBSTR(PHONE , 1 , 8) , 11 , '*'), 1, 3) || '-' || SUBSTR(RPAD(SUBSTR(PHONE , 1 , 8) , 11 , '*'), 4, 4) || '-'|| SUBSTR(RPAD(SUBSTR(PHONE , 1 , 8) , 11 , '*'), 8) AS "�ڵ�����ȣ"
FROM EMPLOYEE;

SELECT 
    REPLACE('������ �󸶹� ����� ��īŸ ����' , '�󸶹�' , '������') AS "REPLACE ����",
    UPPER('abcdefghijklmnopqrstuvwxyz') AS "UPPER ����" 
    
FROM DUAL;

/*
    LTRIM/RTRIM
    
    - LTRIM/RTRIM(���ڿ� , ���Ž�Ű�����ϴ� ����)
    : ���ڿ��� ���� �Ǵ� �����ʿ��� ���Ž�Ű���� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ.
    
    ������� CHARACTER ���·� ����. ���Ž�Ű���� �ϴ� ���� ���� ����(DEFAULT ' ')
    
*/

SELECT LTRIM('      K   H      ')
FROM DUAL;

SELECT RTRIM('      K   H      ')
FROM DUAL;

SELECT LTRIM('0001230456000' , '0')
FROM DUAL;

SELECT RTRIM('0001230456000' , '0')
FROM DUAL;

--- ���ϰ������ ---
-- ���ԵǴ� ���ڰ� ������ ���� ������� ����
SELECT LTRIM('123123KH123' , '123')
FROM DUAL;

SELECT LTRIM('123123KH123' , '132')
FROM DUAL;

SELECT LTRIM('123123KH123' , '312')
FROM DUAL;

--------------------------------------------------------------------------------

SELECT LTRIM('ACABACCKH' , 'ABC')
FROM DUAL; -- ���Ž�Ű���� �ϴ� ���ڿ��� ������ �����ִ°� �ƴ϶� ���� �ϳ��ϳ��� �� �����ϸ� �����ִ� ����.

/*
    TRIM
    
    - TRIM(BOTH/LEADING/TRAILING '���Ž�Ű���� �ϴ� ����' FROM '���ڿ�')
    : ���ڿ� ����, ����, ���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ� ��ȯ.
    
    ������� CHARACTER Ÿ�Թ�ȯ BOTH/LEADING/TRAILING�� ���� ���� (DEFAULT BOTH)
    
*/

SELECT TRIM('     K H     ')
FROM DUAL;

SELECT TRIM('Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL; -- �տ��� ����

SELECT TRIM(TRAILING 'Z' FROM  'ZZZZZZZZZZKHZZZZZZZZZZ')
FROM DUAL; -- �ڿ��� ����

-- LEADING == LTRIM
-- TRAILING == RTRIM


/*
    LOWER/UPPER/INITCAP
    
    - LOWER(���ڿ�)
    : ���ڸ� ���� �ҹ��ڷ� ����.
    
    - UPPER(���ڿ�)
    : ���ڸ� ���� �빮�ڷ� ����.
    
    - INITCAP(���ڿ�)
    : �� �ܾ��� �ձ��ڸ� �빮�ڷ� ����.
    
*/

SELECT LOWER('Welcom to B class!') , UPPER('Welcom to B class!') , INITCAP('Welcom to B class!')
FROM DUAL;


/*
    CONCAT
    
    - CONCAT(���ڿ� , ���ڿ�2)
    : ���޵� ���ڿ� �ΰ��� �ϳ��� ���ڿ��� ���ļ� ��ȯ
    
*/

SELECT CONCAT('������' , 'ABC')
FROM DUAL;

SELECT '������' || 'ABC'
FROM DUAL;

SELECT CONCAT(CONCAT('������' , 'ABC') , 'DEF')
FROM DUAL; -- CONCAT�� �ΰ��� ���ڿ��� ����.

/*
    REPLACE
    -REPLACE(���ڿ� , ã������ , �ٲܹ���)
    : ���ڿ��κ��� ã�����ڸ� ã�Ƽ� �ٲܹ��ڷ� �ٲ� ���ڿ��� ��ȯ.
    
*/

SELECT REPLACE('����� ������ ���ﵿ' , '���ﵿ' , '�Ｚ��')
FROM DUAL;

SELECT 
    emp_name,
    email,
    replace(email , 'kh.or.kr' , 'iei.or.kr') AS new_email
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    <���ڿ� ���õ� �Լ�>
    
    ABS
    
    - ABS(���밪�� ���� ����) : ���밪�� �����ִ� �Լ�.
    
*/

-- 10 , -10 => 10

SELECT ABS(-10)
FROM DUAL;

SELECT ABS(-10.9)
FROM DUAL;

/*
    MOD
    - MOD(���� , ������) : �� ���� ���� ���������� ��ȯ���ִ� �Լ� (�ڹ��� %)
*/

SELECT MOD(10 , 3)
FROM DUAL; -- 1

SELECT MOD(-10 , 3)
FROM DUAL; -- 1

SELECT MOD(10.9 , 3)
FROM DUAL; -- 1.9

/*
    ROUND
    
    - ROUND(�ݿø��ϰ��� �ϴ� �� , �ݿø� �ϰ��� �ϴ� ��ġ) : �ݿø� ó�����ִ� �Լ�.
    
    �ݿø��� ��ġ : �Ҽ��� �������� �Ʒ� N��° ������ �ݿø��ϰڴ�.
                  ��������(�⺻���� 0 , => �Ҽ��� ù��°���� �ݿø��ϰڴ�.)
                  
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
-- �Ҽ��� �Ʒ��� �ƴ϶� ���� �ڸ������� ��� ����.


/*
    CEIL
    
    - CEIL(�ø�ó���Ҽ���) : �Ҽ��� �Ʒ��� ���� ������ �ø� ó�����ִ� �Լ�.
    
*/

SELECT CEIL(123.456)
FROM DUAL; -- 124

SELECT CEIL(456.001)
FROM DUAL; -- 457


/*
    FLOOR
    
    - FLOOR(����ó���ϰ��� �ϴ� ����) : �Ҽ��� �Ʒ��� ���� ������ ����ó���ϴ� �Լ�.
    
*/

SELECT FLOOR(123.954)
FROM DUAL; -- 123

SELECT FLOOR(207.68)
FROM DUAL; -- 207

-- 1�ܰ� : �� �������� �ٹ��ϼ� ���ϱ� ��, �Ҽ��� �Ʒ� ������.

SELECT  
    emp_name AS "�̸�",
    floor(sysdate - hire_date) AS "�ٹ��ϼ�" 
FROM EMPLOYEE;
    
-- 2�ܰ� : �ٹ��ϼ��� '��' �߰����ֱ� , ��Ī�ο� "�ٹ��ϼ�"

SELECT 
    emp_name AS "�̸�",
    concat(floor(sysdate - hire_date) , '��') AS "�ٹ��ϼ�" 
FROM EMPLOYEE;

--- ������ ����� ���� ---

SELECT 
    emp_name AS "�̸�",
    concat(floor(sysdate - hire_date) , '��') AS "�ٹ��ϼ�" 
FROM EMPLOYEE
WHERE ENT_YN !  = 'Y';


/*
    TRUNC
    - TRUNC(����ó���Ҽ��� , ��ġ) : ��ġ�� ���� ������ ���� ó���� ���ִ� �Լ�.
    
    ��ġ �������� , ������ DEFAULT = 0 => FLOOR
    
*/

SELECT TRUNC(123.786)
FROM DUAL; -- 123

SELECT TRUNC(123.789 , 1)
FROM DUAL; -- 123.7

SELECT TRUNC(123.789 , -1)
FROM DUAL; -- 120

--------------------------------------------------------------------------------

/*
    <��¥ ���� �Լ�>
    DATE Ÿ�� : �⵵ , �� , �� , �� , �� , �� �� �ִ� �ڷ���.

    SYSDATE : ���� �ý��� ��¥�� ��ȯ    
*/

-- 1. MONTHS_BETWEEN(DATE 1 , DATE 2) : �� ��¥������ �������� ��ȯ(NUMBERŸ�� ��ȯ)
-- DATE2 �� �� �̷��� ��� ������ ����.

-- �� ������ �ٹ��ϼ� , �ٹ� ������

SELECT 
    emp_name,
    floor(sysdate - hire_date) AS "�ٹ��ϼ�",
    abs(floor(months_between(hire_date , sysdate))) AS "�ٹ�������"
FROM EMPLOYEE;

SELECT 
    emp_name,
    floor(sysdate - hire_date) AS "�ٹ��ϼ�",
    floor(months_between(sysdate , hire_date)) AS "�ٹ�������"
FROM EMPLOYEE;

-- 2. ADD MONTHS(DATE , NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ �������� ���� ��¥ ��ȯ(������� DATE Ÿ��)

SELECT ADD_MONTHS(SYSDATE , 12)
FROM DUAL;

-- ��ü ������� 1�� �ټ��� (== �Ի��Ϸκ��� 1�ֳ�)

SELECT 
    emp_name AS "�̸�",
    add_months(hire_date , 12) AS "1�� �ټ���"
FROM EMPLOYEE;

-- 3. NEXT_DAY(DATE , ����(���� , ����)) : Ư�� ��¥���� ���� ����� �ش� ������ ã�Ƽ� ��ȯ.(DATE��ȯ)

SELECT NEXT_DAY(SYSDATE , '�����')
FROM DUAL;

SELECT NEXT_DAY(SYSDATE , '��')
FROM DUAL;

SELECT NEXT_DAY(SYSDATE , 7) -- 1. �Ͽ��� , 2. ������ , 3ȭ���� ... 7. �����
FROM DUAL;

-- �� ����
-- DDL
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT NEXT_DAY(SYSDATE , 'SATURDAY') -- ���� ���õ� �� �ѱ����̱� ������ ������ �߻���.
FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;


-- 4. LAST_DAY(DATE) : �ش� Ư����¥ ���� ������ ��¥�� ���ؼ� ��ȯ(DATE ��ȯ)

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- �̸� , �Ի��� , �Ի��� ���� ������ ��¥ ��ȸ.
SELECT 
    emp_name AS "�̸�",
    hire_date AS "�Ի���",
    last_day(hire_date)
FROM EMPLOYEE;

-- 5. EXTRACT : �⵵ , �� , ���� ������ �����ؼ� ��ȯ(������� NUMBER)

/*
    - EXTRACT(YEAR FROM ��¥) : Ư����¥�κ��� �⵵�� ����.
    - EXTRACT(MONTH FROM ��¥) : Ư����¥�κ��� ���� ����.
    - EXTRACT(DAY FROM ��¥) : Ư�� ��¥�κ��� �ϸ� ����.
    
    90/02/06
    
*/

SELECT 

    EXTRACT(YEAR FROM SYSDATE),
    EXTRACT(MONTH FROM SYSDATE),
    EXTRACT(DAY FROM SYSDATE)
FROM DUAL;
-- 2022 - 8 - 22

-- 1�ܰ� : ����� , �Ի� �⵵ , �Ի� �� , �Ի��� ��ȸ.
-- 2�ܰ� : �Ի�⵵ , �Ի�� , �Ի��� �������� �������� ����.

SELECT 
    emp_name AS "�̸�",
    extract(year from hire_date) AS "�Ի�⵵",
    extract(month from hire_date) AS "�Ի��",
    extract(day from hire_date) AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵" , "�Ի��" , "�Ի���"; -- ASC

--------------------------------------------------------------------------------

/*
    <����ȯ �Լ�>
    
    NUMBER/DATE => CHARACTER
    
    - TO_CHAR(NUMBER/DATE , ����)
    : ������ �Ǵ� ��¥�������͸� ������ Ÿ������ ��ȯ(���˿� ���缭)
    
*/

SELECT TO_CHAR(123)
FROM DUAL;

SELECT TO_CHAR(1234 , '00000')
FROM DUAL; -- 1234 -> '01234' : ��ĭ�� 0���� ä��

SELECT TO_CHAR(1234 , '99999')
FROM DUAL; -- 1234 = '1234' : ��ĭ�� ' '���� ä��.

SELECT TO_CHAR(1234 , 'L00000')
FROM DUAL; -- L : LOCAL => ���� ������ ������ ȭ�����.
-- 1234 => '\01234'

SELECT TO_CHAR(1234 , 'L99999')
FROM DUAL; -- 1234 -> \ 1234

SELECT TO_CHAR(1234 , 'L99,999')
FROM DUAL;

-- �޿������� 3�ڸ����� , �� ��� Ȯ��

SELECT 
    emp_name,
    TO_CHAR(salary , 'L999,999,999') AS "�޿�"
FROM EMPLOYEE;
    
-- ��¥�� ���ڿ� ����
SELECT TO_CHAR(SYSDATE)
FROM DUAL;

SELECT TO_CHAR(SYSDATE , 'YYYY-MM-DD')
FROM DUAL; -- 2022-08-22

SELECT TO_CHAR(SYSDATE , 'YYYY/MM/DD')
FROM DUAL; -- 2022/08/22

-- �� �� �� : HH:MI:SS
-- PM ���� / AM ����
SELECT TO_CHAR(SYSDATE , 'PM HH:MI:SS')
FROM DUAL; -- ���� 05:53:12

-- ��,��,�� 24�ð� ����
SELECT TO_CHAR(SYSDATE , 'HH24:MI:SS')
FROM DUAL; -- 24�ð� �������� ǥ������ -- 17:54:34

SELECT TO_CHAR(SYSDATE , 'MON DY, YYYY')
FROM DUAL; -- �� ��(����) , 2022 - 8�� ��, 2022
-- �� �� , 2022 : MON - MONTH , DY - DAY ��� , �� ����

SELECT TO_CHAR(SYSDATE , 'YYYY'),
       TO_CHAR(SYSDATE , 'RRRR'),
       TO_CHAR(SYSDATE , 'YY'),
       TO_CHAR(SYSDATE , 'RR'),
       TO_CHAR(SYSDATE , 'YEAR')
FROM DUAL;

-- YY �� RR�� ������
-- R�� ROUND����
-- YY : ���ڸ��� ������ (�⵵20)�� ����
-- RR : 50��������� ������ 20�� �ٰ� , ũ�� 19�� ���� -> 1989 / (20)49 

SELECT TO_CHAR(SYSDATE , 'MM'),
       TO_CHAR(SYSDATE , 'MON'),
       TO_CHAR(SYSDATE , 'MONTH'),
       TO_CHAR(SYSDATE , 'RM')
FROM DUAL;

SELECT TO_CHAR(SYSDATE , 'D'),
       TO_CHAR(SYSDATE , 'DD'),
       TO_CHAR(SYSDATE , 'DDD')
FROM DUAL;
-- D : 1���� �������� �Ͽ��Ϻ��� ��ĥ°�� �˷��ִ� ����(1-�Ͽ��� , 2-������)
-- DD : 1�� �������� 1�Ϻ��� ��ĥ°���� �˷��ִ� ����.
-- DDD : 1�� �������� 1�Ϻ��� ��ĥ°���� �˷��ִ� ����.

SELECT TO_CHAR(SYSDATE , 'DY'),
       TO_CHAR(SYSDATE , 'DAY')
FROM DUAL; -- ������ �ֳ� ���� ����.

-- 1�ܰ� : ����� , �Ի��� 0000�� 00�� 00�� (��)���� AS ��Ī "�Ի���"

SELECT 
    emp_name AS "�̸�",
    TO_CHAR(HIRE_DATE , 'YYYY"��" MM"��" DD"��" DAY') AS "�Ի���"
FROM EMPLOYEE
-- 2�ܰ� : �Ի����� 2010�⵵ �̻��� ����� ���.
WHERE HIRE_DATE >= '10/01/01';
--WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2010;


/*
    NUMBER/CHARACTER -> DATE
    - TO_DATE(NUMBER/CHARACTER , ����) : ������ �Ǵ� ������ �����͸� ��¥������ ��ȯ.
    
*/

SELECT TO_DATE(20220821)
FROM DUAL; -- 22/08/21

SELECT TO_DATE('20220821')
FROM DUAL; -- 22/08/21

SELECT TO_DATE(000101)
FROM DUAL; -- ���� 

SELECT TO_DATE('000101')
FROM DUAL; -- 00/01/01
-- 0���� �����ϴ� �⵵�� �ݵ�� Ȧ����ǥ�� ��� ���ڿ��� �ٷ�� ��.

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
    
    - TO_NUMBER(CHARACTER , ����) : ������ �����͸� ���������� ��ȯ
*/

-- �ڵ�����ȯ ����(���ڿ� => ����)
SELECT '123' + '123'
FROM DUAL; -- 246

SELECT TO_NUMBER('123') + TO_NUMBER('123')
FROM DUAL; -- 246

SELECT '10,000,000' + '550,000'
FROM DUAL; -- ����(,)�� ���ԵǾ��־ �ڵ� ����ȯ�� �ȵ�.

SELECT TO_NUMBER('10,000,000' , '99,999,999') + TO_NUMBER('550,000' , '999,999')
FROM DUAL; -- 10550000 : ����ȯ �� �� ���������� �����.

SELECT TO_NUMBER('0123')
FROM DUAL; -- 123 (���� 0�� ������)

--------------------------------------------------------------------------------

/*
    <NULL ó�� �Լ�>
    
    -- NVL(�÷Ÿ� , �ش��÷����� NULL�� ��� ��ȯ�� ��ȯ��)
    -- �ش��÷����� ������ ���(NULL�� �ƴҰ��) ������ �÷����� ��ȯ.
    -- �ش��÷����� �������� �������(NULL�ϰ��) ���� ������ Ư������ ��ȯ.
    
*/

-- ����� , ���ʽ� , ���ʽ������� ��� 0���� ���.

SELECT 
    emp_name,
    NVL(bonus , 0) AS "���ʽ�"
FROM EMPLOYEE;
    
SELECT 
    emp_name,
    (salary + (salary * NVL(bonus , 0) )) * 12 AS "���ʽ����Կ���"
FROM EMPLOYEE;

-- ������ , �μ��ڵ� (���°�� '����') ��ȸ.
SELECT 
    emp_name,
    NVL(dept_code , '����') AS "�μ��ڵ�"
FROM EMPLOYEE;

-- NVL2(�÷��� , �����1 , �����2)
-- �ش�Į������ NULL�� �ƴ� ��� ����� 1��ȯ.
-- �ش�Į������ NULL�� ��� ����� 2��ȯ.

-- ���ʽ��� �ִ� ����� '���ʽ� ����' , '���ʽ� ����' AS "���ʽ�����"

SELECT 
    emp_name,
    bonus,
    NVL2(bonus , '���ʽ� ����' , '���ʽ� ����') AS "���ʽ� ����"
FROM EMPLOYEE;


-- NULLIF(�񱳴��1 , �񱳴��2) : �����
-- �ΰ��� ������ ��� NULL��ȯ.
-- �ΰ��� �������� ������� �񱳴��1 ��ȯ.

SELECT NULLIF('123' , '123')
FROM DUAL; -- NULL

SELECT NULLIF('123' , '456')
FROM DUAL; -- 123

-- �����Լ� : DECODE => SWITCH��.
-- �����Լ� ģ�� : CASE WHEN THEN ���� => IF��.


/*

    <�����Լ�>
    
    - DECODE(�񱳴�� , ���ǰ�1 , �����1 , ���ǰ�2 , �����2 ... , ���ǰ�N , �����N)
    
    �񱳴�󿡴� �÷��� , �������(����� ����) , �Լ��� �� �� �ִ�.
    
*/

-- ��� , ����� , �ֹε�Ϲ�ȣ , �ֹε�Ϲ�ȣ�κ��� ���� �ڸ��� ����(1 , 3 : ���� , 2 , 4 : ����)
SELECT 
    emp_id,
    emp_name,
    emp_no,
    DECODE(SUBSTR(emp_no , 8 , 1) , '1' , '��' , '3' , '��' , '2' , '��' , '4' , '��') AS "����"
FROM EMPLOYEE;


-- �������� �޿��� �λ���Ѽ� ��ȸ
-- �����ڵ尡 'J7'�� ����� �޿��� 10%�λ��ؼ� ��ȸ.
-- �����ڵ尡 'J6'�� ����� �޿��� 15%�λ��ؼ� ��ȸ.
-- �����ڵ尡 'J5'�� ����� �޿��� 20%�λ��ؼ� ��ȸ.
-- �׿� �����ڵ��� ����� �޿��� 5%�λ��ؼ� ��ȸ.
-- ����� , �����ڵ� , ������ �޿� , ���� �� �޿�

SELECT 
    emp_name AS "�����",
    job_code AS "�����ڵ�",
    salary AS "���� �� �޿�",
    DECODE(job_code , 'J7' , (salary * 1.1) , 'J6' ,  (salary * 1.15) , 'J5' , (salary * 1.2),(salary * 1.05))AS "������ �޿�"
FROM EMPLOYEE;


/*
    CASE WHEN TEHN ����
    - DECODE �����Լ��� ���ϸ� DECODE�� �ش� ���ǰ˻� �� ����񱳸� ����.
      CASE WHEN THEN ������ ��� Ư�� ������ �� ������� ���� ����.
      
    [ǥ����]
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         WHEN ���ǽ�N THEN �����N
         ELSE �����
    END
*/

-- ��� , ����� , �ֹε�Ϲ�ȣ , �ֹε�Ϲ�ȣ�κ��� �����ڸ� �����ؼ� (1,3 ��) (2,4 ��)

SELECT 
    emp_id,
    emp_name,
    emp_no,
    CASE WHEN SUBSTR(EMP_NO , 8 , 1) IN(1,3) THEN '��'
         WHEN SUBSTR(EMP_NO , 8 , 1) IN(2,4) THEN '��'
    END AS "����"
FROM EMPLOYEE;


SELECT 
    emp_name AS "�����",
    job_code AS "�����ڵ�",
    salary AS "���� �� �޿�",
    CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
         WHEN JOB_CODE = 'J6' THEN SALARY*1.5
         WHEN JOB_CODE = 'J5' THEN SALARY*1.2
         ELSE SALARY*1.05
         
    END AS "������ �޿�"
FROM EMPLOYEE;

-- ����� , �޿� , �޿����
-- �޿���� SALARY���� 500���� �ʰ��ϰ�� '���'
-- 500�������� 350���� �ʰ��ϰ�� '�߱�'
-- 350���� �����ϰ�� '�ʱ�'

SELECT 
    emp_name,
    salary,
    CASE WHEN SALARY > 5000000 THEN '���'
         WHEN SALARY > 3500000 THEN '�߱�'
         ELSE '�ʱ�'
    END AS "�޿����"
FROM EMPLOYEE;

---------------------------------- <�׷� �Լ�> ----------------------------------

-- �׷��Լ� : �����͵��� ��(SUM) , ���(AVG)

/*
    N���� ���� �о 1���� ����� ��ȯ(�ϳ��� �׷캰�� �Լ� ������ ��ȯ)
*/

-- 1. SUM(����Ÿ�� �÷�) : �ش� Į�������� �� �հ踦 ��ȯ���ִ� �Լ�.

SELECT SUM(SALARY)
FROM EMPLOYEE;

-- �μ��ڵ尡 'D5'�� ������� �� �հ�

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- ���� ������� �� �޿� �հ�.
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = 1;

-- 2. AVG(����Ÿ�����÷�) : �ش�Į�������� ����� ���ؼ� ��ȯ.

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ANYŸ��) : �ش��÷����߿� ���� ���� �� ��ȯ
-- 4. MAX(ANYŸ��) : �ش��÷����߿� ���� ū �� ��ȯ

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

-- 5. COUNT(*/ �÷��̸�(DISTINCT Į���̸�) : ��ȸ�� ���� ������ ���� ��ȯ.
-- COUNT(*) : ��ȸ����� �ش��ϴ� ������� �� ���� ��ȯ
-- COUNT(�÷��̸�) : ������ �ش� �÷����� NULL �ƴѰ͸� ���� ������ ���� ��ȯ.
-- COUNT(DISTINCT �÷��̸�) : ������ �ش� �÷����� �ߺ����� ������� �ϳ��θ� ���� ��ȯ . NULL���� X.

-- ��ü ������� ���� ��ȸ

SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� ������� ��ȸ

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = 2;

-- �μ���ġ�� �Ϸ�� �����
-- DEPT_CODE�� NULL�� �ƴ� ���

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- �μ� ��ġ�� �Ϸ�� ���� �����

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = 2;

-- ����� �ִ� ��� ��.

SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

-- ���� ������� �����ִ� �μ��� ����

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

-- ���� ������� ��ȿ�� ������ ����

SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ , �μ��ڵ� , ������� , ���� ��ȸ.
-- (�� , ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ��ϰ�,
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���.

SELECT 
    emp_name AS "�̸�" ,
    dept_code AS "�μ��ڵ�" ,
    TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1 , 6)), 'YYYY"�� "MM"�� "DD"��"') AS "�������",
    TO_CHAR(TO_DATE(SYSDATE) , 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(EMP_NO , 1 , 6)), 'YYYY') || '��' AS "����"

FROM EMPLOYEE;


