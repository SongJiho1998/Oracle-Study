-- PK �������� ����.

SELECT * FROM USER_MOCK_DATA;
SELECT COUNT(*) 
FROM USER_MOCK_DATA; -- 50000

-- ID�÷� �˻� 22222
SELECT *
FROM USER_MOCK_DATA
WHERE ID = '22222'; -- OPTION : FULL , CARDINALITY : 5 , COST : 136

-- EMAIL�˻�
-- kbresland@comsenz.com
SELECT
    *
FROM USER_MOCK_DATA
WHERE EMAIL = 'kbresland0@comsenz.com'; -- OPTION : FILL , CARDINALITY : 5 , COST : 136

-- GENDER�� ���� ��ȸ
SELECT
    *
FROM USER_MOCK_DATA
WHERE GENDER = 'Male'; -- OPTION : FULL , CARDINALITY : 24548 , COST : 137

-- first_nameĮ���� like����
SELECT
    *
FROM USER_MOCK_DATA
WHERE FIRST_NAME LIKE 'R%'; -- OPTIONS : FULL , CARDINALITY : 2937 , COST : 137

-- ���������߰� PK
ALTER TABLE USER_MOCK_DATA
ADD CONSTRAINT PK_USER_MOCK_DAD_ID PRIMARY KEY(ID);

-- ���������߰� UNIQUE(EMAIL)
ALTER TABLE USER_MOCK_DATA
ADD CONSTRAINT PK_USER_MOCK_DADA_EMAIL UNIQUE(EMAIL);

SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;

-- �÷� ID �˻�.
SELECT *
FROM USER_MOCK_DATA
WHERE ID = '22222'; -- OPTION : UNIQUE SCAN , CARDINALITY : 1 , COST : 1

-- �̸����� ���� �˻�.
SELECT
    *
FROM USER_MOCK_DATA
WHERE EMAIL = 'kbresland0@comsenz.com';  -- OPTION : UNIQUE SCAN , CARDINALITY : 1 , COST : 1



CREATE INDEX UQ_USER_MOCK_DATA_GENDER ON USER_MOCK_DATA(GENDER);

SELECT 
    * 
FROM USER_MOCK_DATA
WHERE GENDER = 'Male'; -- OPTION : RANGE SCAN  , CARDINALRY : 201 , COST : 59

CREATE INDEX UQ_USER_MOCK_DATA_FIRST_NAME ON USER_MOCK_DATA(FIRST_NAME);

SELECT * FROM 
USER_MOCK_DATA
WHERE FIRST_NAME LIKE 'R%'; -- OPTION : RACGE SCAN , CARDINALITY : 453 , COST : 3

/*
    �ε��� ����
    1) WHERE���� �ε��� Į���� ���� �ξ� ������ ���� �����ϴ�.
    2) ORDER BY������ ����� �ʿ䰡 ����(�̹����ĵǾ��ִ�.)
    ����) ORDER BY���� �޸𸮸� �Ĥ��� ��ƸԴ� �۾���
    3) MIN , MAX���� ã���� ����ӵ��� �ſ����(���ĵǾ��ֱ� ����)
    
    �ε����� ����
    1) DML�� �����
    2) INDEX�� �̿��� INDEX-SCAN���� �ܼ��� FULLSCAN�� �� �����Ҷ��� ����.
    3) �ε����� �������� ��������� ��Ƹ���.
    
*/
















































 