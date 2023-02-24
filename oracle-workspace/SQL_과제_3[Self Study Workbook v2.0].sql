-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" 
--    ���� ǥ���ϵ��� �Ѵ�.

SELECT
    DEPARTMENT_NAME AS "�а���",
    CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.

SELECT
    DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;

-- 3."������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
--    ���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
--    ã�� ������ ����) 

SELECT
    STUDENT_NAME AS "STUDENT_NAME"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�'
AND SUBSTR(STUDENT_SSN , 8 , 1) IN ('2' , '4')
AND ABSENCE_YN = 'Y';

-- 4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ���
--    �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�

SELECT
    STUDENT_NAME AS "STUDENT_NAME"
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

--WHERE SUBSTR(STUDENT_NO , 1 , 3) = 'A513'; 
-- 5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.

SELECT
    DEPARTMENT_NAME AS "DEPARTMENT_NAME",
    CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� ��
--    ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.

SELECT
    PROFESSOR_NAME AS "PROFESSOR_NAME"
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO IS NULL;

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�. 
--    ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.

SELECT
    STUDENT_NAME
FROM TB_STUDENT 
WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
--    ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�

SELECT
    CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.

SELECT
    CATEGORY
FROM TB_DEPARTMENT
GROUP BY CATEGORY
ORDER BY CATEGORY ASC;

-- 10. 02 �й� ���� �����ڵ��� ������ ������� �Ѵ�. ������ ������� ������ ��������
--     �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.

SELECT
    STUDENT_NO,
    STUDENT_NAME,
    STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N'
AND STUDENT_ADDRESS LIKE '%����%'
AND EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002;

-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
-- ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
-- ǥ�õǵ��� �Ѵ�.)

SELECT
    STUDENT_NO AS "�й�",
    STUDENT_NAME AS "�̸�",
    TO_CHAR(TO_DATE(ENTRANCE_DATE) , 'YYYY-MM-DD') AS "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY  TO_CHAR(TO_DATE(ENTRANCE_DATE) , 'YYYY-MM-DD') ASC;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. �� ������
-- �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
-- ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)

SELECT 
    PROFESSOR_NAME AS "PROFESSOR_NAME",
    PROFESSOR_SSN AS "PROFESSOR_SSN"
FROM TB_PROFESSOR
WHERE NOT PROFESSOR_NAME LIKE '___';

-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
-- �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
-- 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ����������
-- ����Ѵ�.)

SELECT
    PROFESSOR_NAME AS "�����̸�",
    TO_CHAR(TO_DATE(SUBSTR(SYSDATE , 1 , 2) , 'RR') , 'YYYY') - TO_NUMBER(19 || SUBSTR(PROFESSOR_SSN , 1 , 2)) AS "����" 
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN , 8 , 1) IN ('1' , '3')
ORDER BY "����" ASC;

-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
-- ?�̸�? �� �������� �Ѵ�. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)

SELECT
    SUBSTR(PROFESSOR_NAME , 2) AS "�̸�"
FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? �̶�, 
-- 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.

SELECT  
    STUDENT_NO AS "STUDENT_NO",
    STUDENT_NAME AS "STUDENT_NAME"
FROM TB_STUDENT
WHERE  TO_CHAR(TO_DATE(ENTRANCE_DATE) , 'YYYY') - 
EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN , 1 , 2) , 'RR')) > 19;

-- 6. 2020 �� ũ���������� ���� �����ΰ�?

SELECT
    TO_CHAR(TO_DATE('2020/12/25') ,'day') AS "2020�� ũ��������"
FROM DUAL;

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
--    �� �� ���� �ǹ��ұ�? �� TO_DATE('99/10/11','RR/MM/DD'), 
--    TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?

SELECT
    TO_CHAR(TO_DATE('99/10/11','YY/MM/DD') , 'YYYY"��"MM"��"DD"��"') AS "ù��° ���", -- YY : ���ڸ��� ������ 20�� ����.
    TO_CHAR(TO_DATE('49/10/11','YY/MM/DD') , 'YYYY"��"MM"��"DD"��"') AS "�ι�° ���",
    TO_CHAR(TO_DATE('99/10/11','RR/MM/DD') , 'YYYY"��"MM"��"DD"��"' )AS "����° ���", -- RR : 50�� �������� ������20 , ũ�� 19 
    TO_CHAR(TO_DATE('49/10/11','RR/MM/DD') , 'YYYY"��"MM"��"DD"��"') AS "�׹�° ���"  --       EX) 2049 / 1949 
FROM DUAL;

-- 8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
-- ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.

SELECT
    STUDENT_NO AS "STUDENT_NO",
    STUDENT_NAME AS "STUDENT_NAME"
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO , 1 , 1) != 'A';

-- 9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
--    �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
--    �ڸ������� ǥ���Ѵ�.

SELECT
    ROUND(AVG(POINT) , 1) AS "����"
FROM TB_GRADE 
LEFT JOIN TB_STUDENT USING(STUDENT_NO)
WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
--     ��µǵ��� �Ͻÿ�.

SELECT 
    DEPARTMENT_NO AS "�а���ȣ",
    COUNT(DEPARTMENT_NO) AS "�л���"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
--     �ۼ��Ͻÿ�.

SELECT
    COUNT(*) AS "COUNT(*)"
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
--     �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
--     �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.

SELECT  
    SUBSTR(TERM_NO , 1 , 4) AS "�⵵",
    ROUND(AVG(POINT) , 1) AS "�⵵ �� ����"
FROM  TB_GRADE
GROUP BY SUBSTR(TERM_NO , 1 , 4) , STUDENT_NO
HAVING STUDENT_NO = 'A112113';

-- 13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
--     �ۼ��Ͻÿ�. 

SELECT
    DEPARTMENT_NO AS "�а��ڵ��",
    COUNT(DECODE(ABSENCE_YN , 'Y' , 'Y')) AS "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;

-- 14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. � SQL 
--     ������ ����ϸ� �����ϰڴ°�?

SELECT  
    STUDENT_NAME AS "�����̸�",
    COUNT(STUDENT_NAME) AS "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) > 1 -- �̸��� 1���� ũ�ٸ� ���� �̸��� �Ѹ� �̻� �ִٴ� ��
ORDER BY STUDENT_NAME ASC;

-- 15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
--     ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
--     ǥ���Ѵ�.)

SELECT 
    NVL(SUBSTR(TERM_NO , 1 , 4) , ' ') AS "�⵵", -- NVL()�� NULL �ϰ�� ' '(��ĭ)���� ����
    NVL(SUBSTR(TERM_NO , 5) , ' ') AS "�б�", -- NVL()�� NULL �ϰ�� ' '(��ĭ)���� ����
    ROUND(AVG(POINT) , 1) AS "����"
FROM TB_GRADE
GROUP BY ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5)) , STUDENT_NO
HAVING STUDENT_NO = 'A112113'
ORDER BY SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5) ASC;

--------------------------------------------------------------------------------
-- [Additional SELECT - Option]

-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--    ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT
    STUDENT_NAME AS "�л� �̸�",
    STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC; -- ORDER BY 1; �� �ص���.
-- 2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT
    STUDENT_NAME AS "STUDENT_NAME",
    STUDENT_SSN AS "STUDENT_SSN"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;
-- 3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�, 
--    �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
--    "������ �ּ�" �� ��µǵ��� �Ѵ�.
SELECT
    STUDENT_NAME AS "�л��̸�",
    STUDENT_NO AS "�й�",
    STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO , 1 , 1) = '9'
AND STUDENT_ADDRESS LIKE '���%' OR STUDENT_ADDRESS LIKE '������%'
ORDER BY STUDENT_NAME ASC;
-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
--    �ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
--    ������ ����)

SELECT
    PROFESSOR_NAME AS "PROFESSOR_NAME",
    PROFESSOR_SSN AS "PROFESSOR_SSN"
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN ASC;
-- 5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�. ������
--    ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
--    �ۼ��غ��ÿ�.
SELECT
    STUDENT_NO AS "STUDENT_NO",
    TO_CHAR(POINT , '0.00') AS "POINT"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE SUBSTR(TERM_NO , 1 , 4) = '2004' AND SUBSTR(TERM_NO , 5) = '02' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC , STUDENT_NO ASC;
-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL 
--    ���� �ۼ��Ͻÿ�.
SELECT
    STUDENT_NO AS "STUDENT_NO",
    STUDENT_NAME AS "STUDENT_NAME",
    DEPARTMENT_NAME AS "DEPARTMENT_NAME"
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY SUBSTR(STUDENT_NAME , 2 , 2) ASC;
-- 7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT  
    CLASS_NAME AS "CLASS_NAME",
    DEPARTMENT_NAME AS "DEPARTMENT_NAME"
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);
-- 8. ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
--    �ۼ��Ͻÿ�.
SELECT 
    CLASS_NAME AS "CLASS_NAME",
    PROFESSOR_NAME AS "PROFESSOR_NAME"
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP USING(CLASS_NO)
JOIN TB_PROFESSOR P ON (CP.PROFESSOR_NO = P.PROFESSOR_NO)
ORDER BY C.DEPARTMENT_NO , CLASS_NAME ASC;
-- 9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�. �̿�
--      �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT 
    CLASS_NAME AS "CLASS_NAME",
    PROFESSOR_NAME AS "PROFESSOR_NAME"
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP USING(CLASS_NO)
JOIN TB_PROFESSOR P ON (CP.PROFESSOR_NO = P.PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '�ι���ȸ';
-- 10. �������а��� �л����� ������ ���Ϸ��� �Ѵ�. �����а� �л����� "�й�", "�л� �̸�", 
--      "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
--      �ݿø��Ͽ� ǥ���Ѵ�.)

SELECT 
    STUDENT_NO AS "�й�",
    STUDENT_NAME AS "�л� �̸�",
    "��ü ����"
FROM (
    SELECT
        STUDENT_NO,
        ROUND(AVG(POINT) , 1) AS "��ü ����"
    FROM TB_GRADE
    GROUP BY STUDENT_NO
)
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE DEPARTMENT_NO = '059'
ORDER BY STUDENT_NO ASC;

-- 11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
--     ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
--     �ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
--     ��µǵ��� �Ѵ�.

SELECT
    DEPARTMENT_NAME AS "�а��̸�",
    STUDENT_NAME AS "�л��̸�",
    PROFESSOR_NAME AS "���������̸�"
FROM TB_DEPARTMENT D
JOIN TB_STUDENT S ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- 12. 2007 �⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ�
--     SQL ������ �ۼ��Ͻÿ�.

SELECT
    STUDENT_NAME AS "STUDENT_NAME",
    TERM_NO AS "TERM_NAME"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE SUBSTR(TERM_NO , 1 , 4) = '2007'
AND CLASS_NO = 'C2604100'
ORDER BY STUDENT_NAME ASC;

-- 13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
--     �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT
    CLASS_NAME AS "CLASS_NAME",
    DEPARTMENT_NAME AS "DEPARTMENT_NAME"
FROM TB_CLASS 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
WHERE CATEGORY = '��ü��'
AND PROFESSOR_NO IS NULL
ORDER BY DEPARTMENT_NO ASC , CLASS_NAME ASC;

-- 14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. �л��̸���
--     �������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
--     ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
--     ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.

SELECT
    STUDENT_NAME AS "�л��̸�",
    NVL(PROFESSOR_NAME , '�������� ������') AS "��������"
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY STUDENT_NO ASC;

-- 15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
--     �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT
    STUDENT_NO AS "�й�",
    STUDENT_NAME AS "�̸�",
    DEPARTMENT_NAME AS "�а� �̸�",
    "��ü ����"
FROM (
    SELECT
        STUDENT_NO,
        ROUND(AVG(POINT) , 8) AS "��ü ����"
    FROM TB_GRADE
    GROUP BY STUDENT_NO
    HAVING ROUND(AVG(POINT) , 8) >= 4.0
    ORDER BY "��ü ����" DESC
)
JOIN TB_STUDENT USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE ABSENCE_YN = 'N'
ORDER BY STUDENT_NO ASC;

-- 16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.

SELECT
    CLASS_NO AS "CLASS_NO",
    CLASS_NAME AS "CLASS_NAME",
    "AVG(POINT)"
FROM (
        SELECT
            CLASS_NO,
            ROUND(AVG(POINT) ,8)  AS "AVG(POINT)"
        FROM TB_GRADE
        GROUP BY CLASS_NO
        ORDER BY AVG(POINT) ASC
)
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�'
AND CLASS_TYPE = '��������'
ORDER BY CLASS_NO ASC;

-- 17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ�
--     SQL ���� �ۼ��Ͻÿ�.

SELECT 
    STUDENT_NAME AS "STUDENT_NAME",
    STUDENT_ADDRESS AS "STUDENT_ADDRESS"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '038';

-- 18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ����
--     �ۼ��Ͻÿ�.

SELECT
    STUDENT_NO AS "STUDENT_NO",
    STUDENT_NAME AS "STUDENT_NAME"
FROM (
            SELECT
                STUDENT_NO,
                AVG(POINT) AS "POINT"
            FROM TB_GRADE
            GROUP BY STUDENT_NO
            ORDER BY "POINT" DESC
)
JOIN TB_STUDENT USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�'
AND ROWNUM = 1
ORDER BY POINT DESC;

-- 19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������
--     �ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
--     "��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ���
--     �Ѵ�.

SELECT
    DEPARTMENT_NAME AS "�迭 �а���",
    ROUND(AVG(POINT) , 1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE CATEGORY = '�ڿ�����'
AND CLASS_TYPE LIKE '%����%'
GROUP BY DEPARTMENT_NAME
ORDER BY "�迭 �а���" ASC;

---[DDL]---
--------------------------------------------------------------------------------

-- 1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺���
--    �ۼ��Ͻÿ�.

CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

SELECT * FROM TB_CATEGORY;

DROP TABLE TB_CATEGORY;

-- 2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.

CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

SELECT * FROM TB_CLASS_TYPE;

-- 3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
--    (KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������
--    �˾Ƽ� ������ �̸��� ����Ѵ�.)

ALTER TABLE TB_CATEGORY 
ADD PRIMARY KEY(NAME);

-- 4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.

ALTER TABLE TB_CLASS_TYPE
MODIFY NAME NOT NULL;

-- 5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
--    NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.

ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10);

ALTER TABLE TB_CLASS_TYPE
MODIFY NAME VARCHAR2(20);

-- ALTER TABLE TB_CLASS_TYPE
-- MODIFY NO VARCHAR2(10)
-- MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR(20);

-- 6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ�
--    ���� ���·� �����Ѵ�.
--    (ex. CATEGORY_NAME)

ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;

-- 7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ����
--    �����Ͻÿ�.
--    Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )

ALTER TABLE TB_CATEGORY 
RENAME CONSTRAINT SYS_C007278 TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C007277 TO PK_CLASS_TYPE_NAME;

-- 8. ������ ���� INSERT ���� �����Ѵ�.

INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;

-- 9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ�
--   ������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
--   FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )

ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY 
FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

-- 10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� �Ѵ�. 
--     �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.

CREATE VIEW VW_�л��Ϲ����� 
AS SELECT 
        STUDENT_NO AS "�й�",
        STUDENT_NAME AS "�л��̸�",
        STUDENT_ADDRESS AS "�ּ�"
    FROM TB_STUDENT;

SELECT * FROM VW_�л��Ϲ�����;

-- VIEW ���� ���༭ ��������
-- 4. KH ������ �並 ������ �� �ִ� CREATE VIEW ���� �ο�
--    GRANT CREATE VIEW TO KH; ���ֱ�.

-- 11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�. 
--     �̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
--     �̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT 
--     ���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
CREATE VIEW VW_�������
AS SELECT 
    STUDENT_NAME AS "�л��̸�",
    DEPARTMENT_NAME AS "�а��̸�",
    NVL(PROFESSOR_NAME , '������������') AS "���������̸�"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON (PROFESSOR_NO = COACH_PROFESSOR_NO)
ORDER BY DEPARTMENT_NAME ASC;

-- 12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
CREATE VIEW VW_�а����л���
AS SELECT
    DEPARTMENT_NAME AS "DEPARTMENT_NAME",
    COUNT(*) || '��' AS "STUDENT_COUNT"
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME ASC; 
SELECT * FROM VW_�а����л���;
-- 13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
--     �̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�

UPDATE VW_�л��Ϲ����� 
SET �л��̸� = '����ȣ'
WHERE �й� = 'A213046' ;
SELECT * FROM VW_�л��Ϲ�����;
-- 14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW ��
--     ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.

-- WITH CHECK OPTION; -> �������� ����� �÷� ���� "����"���� ���ϰ� �ϴ� �ɼ�.

-- WITH READ ONLY -> �⺻ ���̺��� � �÷��� ���ؼ��� �並 ���� ���� ������ �Ұ����ϰ� ����� �ɼ�
CREATE VIEW VW_�л��Ϲ����� 
AS SELECT 
        STUDENT_NO AS "�й�",
        STUDENT_NAME AS "�л��̸�",
        STUDENT_ADDRESS AS "�ּ�"
    FROM TB_STUDENT
WITH READ ONLY;

-- 15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
--     ������ �ǰ� �ִ�. �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������
--     �ۼ��غ��ÿ�.

SELECT
    J.*
FROM(
        SELECT
            CLASS_NO AS "�����ȣ",
            CLASS_NAME AS "�����̸�",
            COUNT(CLASS_NAME) AS "������������(��)"
        FROM TB_CLASS
        LEFT JOIN TB_GRADE USING(CLASS_NO)
        WHERE SUBSTR(TERM_NO , 1 , 4) BETWEEN 2005 AND 2009
        GROUP BY CLASS_NAME , CLASS_NO
        ORDER BY "������������(��)" DESC) J
WHERE ROWNUM <= 3;

---[DML]---
--------------------------------------------------------------------------------

-- 1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.

INSERT INTO TB_CLASS_TYPE VALUES('01' , '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('02' , '��������');
INSERT INTO TB_CLASS_TYPE VALUES('03' , '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('04' , '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES('05' , '������');

-- 2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�. 
--    �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)

CREATE TABLE TB_�л��Ϲ�����
AS SELECT *
FROM VW_�л��Ϲ�����;

-- 3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�. 
--    �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ�
--    �ۼ��Ͻÿ�)

CREATE TABLE TB_������а�
AS SELECT 
    STUDENT_NO AS "�й�",
    STUDENT_NAME AS "�л��̸�",
    TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN , 1 ,2),'RR') , 'YYYY') AS "����⵵",
    PROFESSOR_NAME AS "�����̸�"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE DEPARTMENT_NAME = '������а�';

-- 4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, 
--    �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�)
SELECT
    DEPARTMENT_NAME AS "�а�",
    CAPACITY  || '��' AS "���� (��) �ο�",
    ROUND((CAPACITY * 1.1)) || '��' AS "���� (��) �ο�"
FROM TB_DEPARTMENT;
---------------------------------------------------------------
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY*1.1);

-- 5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ�
--    �Ѵ�. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.

UPDATE TB_STUDENT
    SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
    WHERE STUDENT_NO = 'A413042'
    AND STUDENT_NAME = '�ڰǿ�';

-- 6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ��
--    �����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
--    (��. 830530-2124663 ==> 830530 )

SELECT
    STUDENT_SSN AS "�ֹε�Ϲ�ȣ ����(��)",
    SUBSTR(STUDENT_SSN , 1 , 6) AS "�ֹε�Ϲ�ȣ ����(��)"
FROM TB_STUDENT;    
--------------------------------------------------------------------
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN , 1 , 6);
SELECT
    STUDENT_SSN
FROM TB_STUDENT;
-- 7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������
--    �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش�
--    ������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.

UPDATE TB_GRADE
    SET POINT = 3.5
    WHERE TERM_NO = 200501 AND (CLASS_NO , STUDENT_NO) = (SELECT
                                                                CLASS_NO,
                                                                STUDENT_NO
                                                          FROM TB_GRADE
                                                          JOIN TB_STUDENT USING (STUDENT_NO)
                                                          JOIN TB_CLASS USING (CLASS_NO)
                                                          WHERE SUBSTR(TERM_NO , 1 , 4) =  2005
                                                         AND SUBSTR(TERM_NO , 5 , 2) = 1
                                                          AND STUDENT_NAME = '�����'
                                                          AND CLASS_NAME = '�Ǻλ�����'); 
SELECT
    *
FROM TB_GRADE
WHERE CLASS_NO = 'C3843900' AND STUDENT_NO = 'A331101';
-- 8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.

DELETE FROM TB_GRADE
WHERE STUDENT_NO IN (
        SELECT
            STUDENT_NO
        FROM TB_STUDENT
        WHERE ABSENCE_YN = 'Y'
);

ROLLBACK;



