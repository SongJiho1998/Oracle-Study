-- [Additional SELECT - Option]

-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--    ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT
    STUDENT_NAME AS "�л� �̸�",
    STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC;
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
AND SUBSTR(STUDENT_ADDRESS , 1 , 3) IN ('������' , '��⵵')
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
-- 5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
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
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
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
JOIN TB_PROFESSOR P ON (CP.PROFESSOR_NO = P.PROFESSOR_NO);
-- 9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿�
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