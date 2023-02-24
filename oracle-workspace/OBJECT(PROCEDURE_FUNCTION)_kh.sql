/*
    <PROCEDURE>
    
    PL/SQL������ �����ؼ� �̿��ϴ� ��ü
    �ʿ��Ҷ����� ���� �ۼ��� PL/SQL���� ���ϰ� ȣ�� �����ϴ�.
    
    ���ν��� �������
    [ǥ����]
    CREATE [OR REPLACE] PROCEDURE ���ν�����[(�Ű�����)]
    IS
    BEGIN
        �������ڵ�
    END;
    
    ���ν��� ������
    EXEC ���ν�����;
*/
-- EMPLOYEE���̺��� ���Į�� , �����͸� ������ COPY���̺� ����.
-- PRO_TEST
CREATE TABLE PRO_TEST
AS SELECT * FROM EMPLOYEE;

SELECT * FROM PRO_TEST;

CREATE PROCEDURE DEL_DATA
IS 
-- ������������ DECALRE
BEGIN
    DELETE FROM PRO_TEST;
    COMMIT;
END;
/

SELECT * FROM USER_PROCEDURES;

EXEC DEL_DATA;                                                                                                                                                

ROLLBACK; -- ������ ���ƿ��� ����.
-- ���ν����� �Ű����� �ֱ�
-- IN : ���ν��� ����� �ʿ��� ���� "�޴�" ����(�ڹٿ��� ������ �Ű������� ����)
-- OUT : ȣ���� ������ �ǵ��� "�ִ�" ����(�����)
CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP( 
EID IN EMPLOYEE.EMP_ID%TYPE ,   
ENAME OUT EMPLOYEE.EMP_NAME%TYPE , 
SAL OUT EMPLOYEE.SALARY%TYPE , 
BONUS OUT EMPLOYEE.SALARY%TYPE
)
IS 
BEGIN
    SELECT
        EMP_NAME,
        SALARY,
        BONUS
        INTO ENAME , SAL , BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = EID;
END;
/

-- �Ű������� �ִ� ���ν��� ����;
VAR EMP_NAME VARCHAR2(20);
VAR SALARY NUMBER;
VAR BONUS NUMBER;
-- VAR : ����Ŭ �󿡼� ������ �����Ҷ�(����Ҷ�)
EXEC PRO_SELECT_EMP(200 , :EMP_NAME ,:SALARY , :BONUS);

PRINT EMP_NAME;
PRINT SALARY;
PRINT BONUS;

/*
    ���ν��� ����
    1. ó���ӵ��� ����(ȿ�������� �ۼ��ߴٴ� �����Ͽ�)
    2. �뷮 �ڷ�ó���� ������
    EX) DB���� ��뷮�� �����͸� SELECT������ �޾ƿͼ� �ڹٿ��� �۾��� �ϴ°�� VS
        DB���� ��뷮�����͸� SELECT�� �� �ڹٷ� �ѱ��� �ʰ� ���� ó���ϴ°�� , DB���� ó���ϴ°�
        ������ �� ����.(�ڹٷ� ������ �ѱ涧 ��Ʈ��ũ���߻�)
        
    ���ν��� ����.
    1. DB�ڿ��� ���� ����ϱ� ������ DB�� ���ϸ� �ְ� ��.(�����ϸ�ȵ�)
    2. ������ ���鿡�� �ڹ��� �ҽ��ڵ� , ����Ŭ �ڵ带 ���ÿ� ��������ϱ� ��ƴ�.
    
    ����) 
    �ѹ��� ó���Ǵ� �����ͷ��� ���� ������ �䱸�ϴ� ó���� ��ü�� �ڹٺ��ٴ� DB�󿡼� 
    ó���ϴ°��� �������鿡���� �������̰� , �ҽ�����(��������)���鿡���� �ڹٷ� ó���ϴ°� �� ����.
*/

--------------------------------------------------------------------------------

/*
    <FUNCTION>
    ���ν����� ���������� ���� ����� ��ȯ(����)������ ����.
    
    FUNCTION �������
    [ǥ����]
    CREATE [OR REPLACE] FUNCTION ���ν�����[(�Ű�����)]
    RETURN �ڷ���
    IS
    [DECLARE]
    REGIN
        ����κ�
    [EXCEPTION]
    END;
    /
*/
CREATE OR REPLACE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN VARCHAR2
IS
    RESULT VARCHAR2(1000);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_STR);
    RESULT := '<' || V_STR || '>';
    
    RETURN RESULT;
END;
/

SELECT MYFUNC('����ȣ') FROM DUAL;

-- EMP_ID�� ���޹޾Ƽ� ������ ����ؼ� ������ִ� �Լ� �����.
CREATE OR REPLACE FUNCTION MY_SAL_FUNC(SVL_STR NUMBER)
RETURN NUMBER
IS
    RESULT NUMBER;
BEGIN
    RESULT := (SVL_STR * 12);
    
    RETURN RESULT;
END;
/

SELECT 
    MY_SAL_FUNC
    (
    (
    SELECT
    SALARY + (SALARY * NVL(BONUS,0))
    FROM EMPLOYEE
    WHERE EMP_ID = &���
    )
    ) AS ����
FROM DUAL;

-- ������ ����
CREATE OR REPLACE FUNCTION CALC_SALARY(EID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    SAL NUMBER;
    BONUS NUMBER;
BEGIN
    SELECT 
        SALARY, 
        BONUS
        INTO SAL , BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = EID;
    
    RETURN SAL + (SAL * NVL(BONUS,0)) * 12;   
END;
/

SELECT 
    CALC_SALARY(&���) -- CALC_SALARY(EMP_ID)
FROM DUAL;

--------------------------------------------------------------------------------
------------------------------------ <����> ------------------------------------- 
CREATE OR REPLACE FUNCTION MY_SAL_FUNCS(SAL_STR NUMBER)
RETURN NUMBER
IS
   RESULT NUMBER;
BEGIN
    RESULT := (SAL_STR * 12);
    
    RETURN RESULT;
END;
/


SELECT
    MY_SAL_FUNCS((
        SELECT
            ((SALARY * NVL(BONUS , 0)) + SALARY)
        FROM EMPLOYEE
        WHERE EMP_ID = &���
    )) AS "����"
FROM DUAL;
























