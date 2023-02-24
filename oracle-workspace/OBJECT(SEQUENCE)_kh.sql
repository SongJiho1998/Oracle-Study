/*
    <������ SEQUENCE>
    
    �ڵ����� ��ȣ�� �߻������ִ� ��Ȱ�� �ϴ� ��ü(�ڵ���ȣ �ο���)
    �������� �ڵ����� ���������� �߻�������(���ӵ� ���ڷ�)
    
    EX) ������ȣ , ȸ����ȣ , ��� , �Խñ۹�ȣ ��.
    -> ���������� ��ġ�� �ʴ� ���ڷ� ä���Ҷ� ����� ������.
    
    1. ��������ü ��������
    [ǥ����]
    CREATE SEQUENCE ��������
    START WITH ���ۼ��� => �������� , �ڵ����� �߻���ų ������(DEFAULT���� 1)
    INCREMENT BY ������ => �������� , �ѹ� ������ �����Ҷ����� � �����Ұ��� ����(DEFAULT���� 1)
    MAXVALUE �ִ밪 => �������� , �ִ밪 ����
    MINVALUE �ּҰ� => �������� , �ּҰ� ����
    CYCLE/NOCYCLE => �������� , ���� ���� ���θ� ����
    CACHE ����Ʈũ�� / NOCACHHE => �������� ĳ�ø޸� ���� ���� ĳ�� �⺻���� 20BYTE -(�⺻������ NOCACHHE �� �⺻��)
    
    * ĳ�ø޸�
    �������κ��� �̸� �߻��� ������ �����ؼ� �����صδ� ����.
    �Ź� ȣ���Ҷ����� ������ ��ȣ�� �����ϴ°ͺ��� ĳ�ø޸𸮿� �̸� �����Ȱ����� ������ ���� �ξ�
    ������ ��밡��. BUT, ������ ����� �����ӽ� ������ ������ ������ ���󰡱⶧���� ��뿡 �����ؾ���.
*/

CREATE SEQUENCE SEQ_TEST;

-- ���� ������ ������ �����ϰ� �ִ� �������� ���� ���� Ȯ��.
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. ������ ��� ����.
    ��������.CURRVAL : ���� �������� ��(���������� ���������� �߻��� NEXTVAL��)
    ��������.NEXTVAL : ���� �������� ����������Ű�� , �� ������ �������� ��
                      == ��������.CURRVAL + INCREMENT BY  ����ŭ ������ ��.
    
    �� , ������ ���� �� ù NEXTVAL�� START WITH�� ������ ���۰����� �߻���.
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- �����߻�
-- �������� �����ǰ��� NEXTVAL�� �ѹ��̶� �������� �ʴ��̻� CURRVAL�� �����Ҽ� ����.

SELECT SEQ_EMPNO.NEXTVAL -- 300
FROM DUAL;

SELECT SEQ_EMPNO.CURRVAL --300
FROM DUAL;

SELECT SEQ_EMPNO.NEXTVAL -- 305
FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL -- 310
FROM DUAL;

SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER : ���� ��Ȳ���� ���� NEXTVAL���� �����ü� �ִ� ��.

SELECT SEQ_EMPNO.NEXTVAL 
FROM DUAL;
-- ������ NEXTVALUE���� �ʰ��߱� ������ �����߻�.

SELECT SEQ_EMPNO.CURRVAL -- ������ ���� �� �н��ϰ� �����ȳ� 310���� ���� �����ȳ��� 310 ���.
FROM DUAL;

/*
    3. ������ ����
    [ǥ����]
    ALTER SEQUENCE �������̸�
    INCREMENT BY ������ => �������� , �ѹ� ������ �����Ҷ����� � �����Ұ��� ����(DEFAULT���� 1)
    MAXVALUE �ִ밪 => �������� , �ִ밪 ����
    MINVALUE �ּҰ� => �������� , �ּҰ� ����
    CYCLE/NOCYCLE => �������� , ���� ���� ���θ� ����
    CACHE ����Ʈũ�� / NOCACHHE => �������� ĳ�ø޸� ���� ���� ĳ�� �⺻���� 20BYTE -(�⺻������ NOCACHHE �� �⺻��)
    
    => START WITH�� ����Ұ� => ��¥ �ٲٰ� ������ �����ϰ� �ٽ� �����ؾߵ�.
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL -- 310
FROM DUAL;
-- �߰��� �������� ����Ǿ����� CURRVAL�� �״�� �����ȴ�.
SELECT SEQ_EMPNO.NEXTVAL -- 320
FROM DUAL;

-- SEQUENCE�����ϱ�
DROP SEQUENCE SEQ_EMPNO;

--------------------------------------------------------------------------------
-- �Ź� ���ο� ����� �߻��Ǵ� �ó��� ����(�������� : SEQ_EID)
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 400;

-- ����� �߰��ɶ� ������ INSERT��
INSERT INTO EMPLOYEE(EMP_ID , EMP_NAME , EMP_NO , JOB_CODE , SAL_LEVEL , HIRE_DATE)
VALUES (SEQ_EID.NEXTVAL , '����ȣ' , '123456-7891234' , 'J1' , 'S1' , SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID , EMP_NAME , EMP_NO , JOB_CODE , SAL_LEVEL , HIRE_DATE)
VALUES (SEQ_EID.NEXTVAL , '����ȣ2' , '123456-7891234' , 'J2' , 'S2' , SYSDATE);




















































