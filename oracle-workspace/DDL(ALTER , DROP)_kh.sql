/*
    DDL : ������ ���� ���
    
    ��ü���� ���Ӱ� ����(CREATE) , �����ϰ� , �����ϴ� ����.
    
    1. ALTER
    ��ü�� ������ �����ϴ� ����.
    
    <���̺����>
    [ǥ����]
    ALATER TABLE ���̺�� �����ҳ���;
    
    -- �����ҳ���
    1) Į���߰� / ���� / ����
    2) �������� �߰� / ���� => ������ �Ұ�(�����ϰ����Ѵٸ� ���� �� ������ �߰�)
    3) ���̺�� / Į���� / �������Ǹ� ����
*/

-- 1) Į�� �߰� / ���� / ����
-- 1-1) Į�� �߰� (ADD) : ADD �߰��� Į���� �ڷ��� DEFAULT �⺻��. (�� , DEFAULT�⺻���� ��������)                                                                             

SELECT * FROM DEPT_COPY;

-- CNAME Į�� �߰�.
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- ���ο� Į���� ��������� �⺻������ NULL������ ä����.

-- LNAME Į���߰� DEFAULT ����.
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
-- ���ο� Į�� �߰��ϰ� �⺻������ �ѱ����� ä����.

-- 1-2) Į�� ����(MODIFY)
--      Į���� �ڷ��� ���� : MODIFY �������÷��� �ٲٰ����ϴ� �ڷ���
--      DEFAULT �� ���� : MODIFY �������÷��� DEFAULT �ٲٰ����ϴ� �⺻��.

-- DEPT_COPY���̺��� DEPT_IDĮ���� �ڷ����� CHAR(3)���� ����.
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- ���� �����ϰ��� �ϴ� Į���� �̹� ����ִ� ���� ������ �ٸ� Ÿ�����δ� ������ �Ұ����ϴ�.
-- DEPT_COPY���̺��� DEPT_IDĮ���� �ڷ����� NUMBER ����.
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- column to be modified must be empty to change datatype
-- ���� �����ϰ����ϴ� �÷��� �̹� ����ִ� ���� ��ġ�ϴ� Į���̰ų� Ȥ�� �����ִ�Į�� , �׸��� �� ū ����Ʈ�� �ڷ������θ�
-- ���氡����.

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1);
-- cannot decrease column length because some value is too big

--> ���� -> ���� (X) / ���ڿ����� ������ ���(X) / ���ڿ����� ������ Ȯ��(O)

-- �ѹ��� ������ Į�� �ڷ��� �����ϱ�
-- DEPT_TITLE�� ������Ÿ���� VARCAHR2(40)����
-- LOCATION_ID�� ������Ÿ���� VARCARH2(2)�� 
-- LNAMEĮ���� �⺻���� '�̱�'
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';

ROLLBACK;
-- 1-3) Į�� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ� Į����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

-- DEPT_COPY2 DEPT_ID ����.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

-- DDL���� ������ �Ұ����ϴ�.
ROLLBACK;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- ���� : cannot drop all columns in a table
-- ���̺� �ּ� �Ѱ��� Į���� �����ؾ���.
/*
    2)�������� �߰� / ����
    2-2) �������� �߰�
    
    - PRIMARY KEY : ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ADD FOREIGN KEY(�÷���) PEFERENCES ���������̺��[(������ �÷���)]
    
    - UNIQUE : ADD UNIQUE(�÷���)
    - CHECK : ADD CHECK(�÷��� ���� ����);
    - NOT NULL : MDOIFY �÷��� NOT NULL;
    
    ������ �������Ǹ� �ο��ϰ��� �Ѵٸ�
    CONSTRAINT �������Ǹ� �տ��ٰ� ���̸��.
    -> CONSTRAINT �������Ǹ��� ������������.
    -> ���ǻ��� : ���� ������ ������ �̸����� �ο��ؾ���.
*/

-- DEPT_COPY���̺�κ���
-- DEPT_ID�÷��� PRIMARY_KEY ���������߰�.
-- DEPT_TITLE �÷��� UNIQUE ���������߰�
-- LNAMEĮ���� NOT NULL �������� �߰�.
ALTER TABLE DEPT_COPY
ADD PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME NOT NULL;

/*
    2-2) �������� ����
    
    PRIMARY KEY , FOREING KEY , UNIQUE , CHECK : DROP CONSTRAINT �������Ǹ�;
    NOT NULL : MODIFY �÷��� NULL;
*/

-- DEPT_COPY���̺�κ��� PK�� �ش��ϴ� ���������� ����.
ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007197;

-- DEPT_COPY���̺�κ��� UNIQUE�� �ش��ϴ� ���������� ����
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ;

-- NOT NULL�������� ����.
ALTER TABLE DEPT_COPY MODIFY LNAME NULL;

-- 3) Į���� / �������Ǹ� / ���̺�� ����

-- 3-1) Į���� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���.
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- DEPT_COPY�� SYS_C007194���������� DEPT_COPY_DI_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007194 TO DEPT_COPY_DI_NN;

-- 3-3) ���̺�� ���� : RENAME �������̺�� TO �ٲ����̺��.
--                           �������̺�� ���� ����.(ALTER TABLE���� ��������Ƿ� ���������ϴ�)
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------

/*
    2. DROP
    ��ü�� �����ϴ� ����.
    
    [ǥ����]
    DROP TABLE �����ϰ����ϴ� ���̺��̸�;
*/
-- EMP_NEW ���̺� ����
DROP TABLE EMP_NEW;

-- �θ����̺� �����ϴ� ��쿡 ���� �׽�Ʈ.
-- 1. DEPT_TEST�� DEPT_ID�� PRIMARY KEY �������� �߰�.
ALTER TABLE DEPT_TEST
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);
-- 2. EMPLOYEE_COPY3�� �ܷ�Ű (DEPT_CODE)�� �߰� (�ܷ�Ű �̸� : ECOPY_FX)
-- �̶� �θ����̺��� DEPT_TEST���̺� , DEPT_ID�� ����.
ALTER TABLE EMPLOYEE_COPY3 
ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST;
-- �θ����̺����.(���� ���� ����)
DROP TABLE DEPT_TEST;
-- unique/primary keys in table referenced by foreign keys

-- �θ����̺�����ϴ� ���
-- 1) �ڽ����̺��� ���� �������� �θ����̺� �����Ѵ�.
DROP TABLE �ڽ����̺�;
DROP TABLE �θ����̺�;

-- 2) �θ����̺� �����ϵ� , �¹����ִ� �ܷ�Ű �������ǵ� �Բ� �����Ѵ�.
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;


