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
-- INSTR(���ڿ� , Ư������ , ã����ġ�� ���۰� , ����) : ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ.

SELECT 
    email,
    INSTR(email , '@' , 1 )
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- SUBSTR
-- ���ڿ����� Ư�� ���ڿ��� �����ϴ� �Լ� 
-- UBSTR(���ڿ� , ó����ġ , ������ ���� ����)

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

-- �ֹε�Ϲ�ȣ���� ���� �κ��� �����ؼ� ����(1) ����(2)�� üũ.

SELECT
    emp_name AS "�̸�",
    SUBSTR(emp_no , 8 , 1) AS "�ֹε�Ϲ�ȣ" 
FROM EMPLOYEE;

-- �̸��Ͽ��� ID�κи� �����ؼ� ��ȸ

SELECT
    emp_name AS "�̸�",
    email AS "�̸���",
    SUBSTR(email , 1 , INSTR(email , '@')-1) AS "���̵�"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- ���� ����鸸 ��ȸ.

SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = '1'; 
  
--------------------------------------------------------------------------------

/*
    LPAD / RPAD 
     - LPAD/RPAD(���ڿ� , ���������� ��ȯ�� ������ ����(BYTE) , �����̰��� �ϴ� ����)
     : ������ ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ.
     
*/    

-- 621235-1******

SELECT 
    emp_name AS "�̸�",
    RPAD(SUBSTR(emp_no , 1 , 8) , 14 , '*') AS "�ֹε�Ϲ�ȣ"
FROM EMPLOYEE;


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
    
-- 2�ܰ� : �ٹ��ϼ��� '��' �߰����ֱ� , ��Ī�ο� "�ٹ��ϼ�"

    





