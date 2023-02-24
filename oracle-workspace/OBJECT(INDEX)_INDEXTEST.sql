-- PK 제약조건 없음.

SELECT * FROM USER_MOCK_DATA;
SELECT COUNT(*) 
FROM USER_MOCK_DATA; -- 50000

-- ID컬럼 검색 22222
SELECT *
FROM USER_MOCK_DATA
WHERE ID = '22222'; -- OPTION : FULL , CARDINALITY : 5 , COST : 136

-- EMAIL검색
-- kbresland@comsenz.com
SELECT
    *
FROM USER_MOCK_DATA
WHERE EMAIL = 'kbresland0@comsenz.com'; -- OPTION : FILL , CARDINALITY : 5 , COST : 136

-- GENDER를 통해 조회
SELECT
    *
FROM USER_MOCK_DATA
WHERE GENDER = 'Male'; -- OPTION : FULL , CARDINALITY : 24548 , COST : 137

-- first_name칼럼에 like연산
SELECT
    *
FROM USER_MOCK_DATA
WHERE FIRST_NAME LIKE 'R%'; -- OPTIONS : FULL , CARDINALITY : 2937 , COST : 137

-- 제약조건추가 PK
ALTER TABLE USER_MOCK_DATA
ADD CONSTRAINT PK_USER_MOCK_DAD_ID PRIMARY KEY(ID);

-- 제약조건추가 UNIQUE(EMAIL)
ALTER TABLE USER_MOCK_DATA
ADD CONSTRAINT PK_USER_MOCK_DADA_EMAIL UNIQUE(EMAIL);

SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;

-- 컬럼 ID 검색.
SELECT *
FROM USER_MOCK_DATA
WHERE ID = '22222'; -- OPTION : UNIQUE SCAN , CARDINALITY : 1 , COST : 1

-- 이메일을 통해 검색.
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
    인덱스 장점
    1) WHERE절에 인덱스 칼럼을 사용시 훨씬 빠르게 연산 가능하다.
    2) ORDER BY연산을 사용할 필요가 없음(이미정렬되어있다.)
    참고) ORDER BY절은 메모리를 맣ㄴ이 잡아먹는 작업임
    3) MIN , MAX값을 찾을때 연산속도가 매우빠름(정렬되어있기 때문)
    
    인덱스의 단점
    1) DML에 취약함
    2) INDEX를 이용한 INDEX-SCAN보다 단순한 FULLSCAN이 더 유리할때가 있음.
    3) 인덱스가 많을수록 저장공간을 잡아먹음.
    
*/
















































 