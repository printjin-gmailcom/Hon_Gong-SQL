# 스토어드 함수

SET GLOBAL log_bin_trust_function_creators = 1; # 초기 1회 설정 후 신경 쓰지 않아도 괜찮음

USE market_db;
DROP FUNCTION IF EXISTS sumFunc;
DELIMITER $$
CREATE FUNCTION sumFunc(number1 INT, number2 INT)
    RETURNS INT
BEGIN
    RETURN number1 + number2;
END $$
DELIMITER ;
SELECT sumFunc(100, 200) AS '합계';

DROP FUNCTION IF EXISTS calcYearFunc;
DELIMITER $$
CREATE FUNCTION calcYearFunc(dYear INT)
    RETURNS INT
BEGIN
    DECLARE runYear INT; -- 활동기간(연도)
    SET runYear = YEAR(CURDATE()) - dYear;
    RETURN runYear;
END $$
DELIMITER ;
SELECT calcYearFunc(2010) AS '활동햇수';
SELECT calcYearFunc(2007) INTO @debut2007;
SELECT calcYearFunc(2013) INTO @debut2013;
SELECT @debut2007-@debut2013 AS '2007과 2013 차이' ;
SELECT mem_id, mem_name, calcYearFunc(YEAR(debut_date)) AS '활동 햇수' FROM member; 
SHOW CREATE FUNCTION calcYearFunc; # 스토어드 함수 확인
DROP FUNCTION calcYearFunc;

USE market_db;
DROP PROCEDURE IF EXISTS cursor_proc;
DELIMITER $$
CREATE PROCEDURE cursor_proc()
BEGIN
    DECLARE memNumber INT; 
    DECLARE cnt INT DEFAULT 0; # 읽은 행 수
    DECLARE totNumber INT DEFAULT 0; # 총 인원
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; # 행의 끝 여부, 기본이 false

    DECLARE memberCuror CURSOR FOR # 커서 선언
        SELECT mem_number FROM member;

    DECLARE CONTINUE HANDLER # 행의 끝이면 endOfRow 변수에 TRUE를 대입 
        FOR NOT FOUND SET endOfRow = TRUE;

    OPEN memberCuror; # 커서 열기

    cursor_loop: LOOP
        FETCH  memberCuror INTO memNumber; 

        IF endOfRow THEN 
            LEAVE cursor_loop;
        END IF;

        SET cnt = cnt + 1;
        SET totNumber = totNumber + memNumber;        
    END LOOP cursor_loop;

    SELECT (totNumber/cnt) AS '회원의 평균 인원 수';

    CLOSE memberCuror; 
END $$
DELIMITER ;
CALL cursor_proc();
