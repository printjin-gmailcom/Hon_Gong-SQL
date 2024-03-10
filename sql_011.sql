# DROP PROCEDURE IF EXISTS a;

DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
   IF 100 = 100 THEN  
      SELECT '100은 100과 같습니다.';
   END IF;
END $$
DELIMITER ;
CALL ifProc1();

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
   DECLARE myNum INT;  -- myNum 변수선언
   SET myNum = 200;  -- 변수에 값 대입
   IF myNum = 100 THEN  
      SELECT '100입니다.';
   ELSE
      SELECT '100이 아닙니다.';
   END IF;
END $$
DELIMITER ;
CALL ifProc2();

DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
    DECLARE debutDate DATE;
    DECLARE curDate DATE; -- 오늘
    DECLARE days INT; -- 활동일수

    SELECT debut_date INTO debutDate
       FROM market_db.member
       WHERE mem_id = 'APN';

    SET curDATE = CURRENT_DATE();
    SET days =  DATEDIFF(curDATE, debutDate);

    IF (days/365) >= 5 THEN -- 5년이 지났다면
          SELECT CONCAT('데뷔한지 ', days, '일이나 지났습니다. 핑순이들 축하합니다!');
    ELSE
          SELECT '데뷔한지 ' + days + '일밖에 안되었네요. 핑순이들 화이팅~' ;
    END IF;
END $$
DELIMITER ;
CALL ifProc3();

SELECT CURRENT_DATE(), DATEDIFF('2021-12-31', '2000-1-1');

DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 88 ;
    
    CASE 
        WHEN point >= 90 THEN
            SET credit = 'A';
        WHEN point >= 80 THEN
            SET credit = 'B';
        WHEN point >= 70 THEN
            SET credit = 'C';
        WHEN point >= 60 THEN
            SET credit = 'D';
        ELSE
            SET credit = 'F';
    END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL caseProc();

SELECT mem_id, SUM(price*amount) "총구매액" FROM buyGROUP BY mem_id;
   
SELECT mem_id, SUM(price*amount) "총구매액" FROM buy GROUP BY mem_id ORDER BY SUM(price*amount) DESC ; #오름차순

# mem_id, mem_name, 총구매액 순 
SELECT B.mem_id, M.mem_name, SUM(price*amount) "총구매액" FROM buy B INNER JOIN member M ON B.mem_id = M.mem_id GROUP BY B.mem_id ORDER BY SUM(price*amount) DESC ;
SELECT M.mem_id, M.mem_name, SUM(price*amount) "총구매액" FROM buy B RIGHT OUTER JOIN member M ON B.mem_id = M.mem_id GROUP BY M.mem_id ORDER BY SUM(price*amount) DESC ;
   
SELECT M.mem_id, M.mem_name, SUM(price*amount) "총구매액",
        CASE  
           WHEN (SUM(price*amount)  >= 1500) THEN '최우수고객'
           WHEN (SUM(price*amount)  >= 1000) THEN '우수고객'
           WHEN (SUM(price*amount) >= 1 ) THEN '일반고객'
           ELSE '유령고객'
        END "회원등급"
   FROM buy B
         RIGHT OUTER JOIN member M
         ON B.mem_id = M.mem_id
   GROUP BY M.mem_id
   ORDER BY SUM(price*amount) DESC ;
   
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE i INT; -- 1에서 100까지 증가할 변수
    DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

    WHILE (i <= 100) DO
        SET hap = hap + i; 
        SET i = i + 1; 
    END WHILE;

    SELECT '1부터 100까지의 합 ==>', hap;   
END $$
DELIMITER ;
CALL whileProc();

use market_db;
PREPARE myQuery FROM 'SELECT * FROM member WHERE mem_id = "BLK"'; # 마이쿼리에 넣어두기만 하기
EXECUTE myQuery; # 필요할떄 execute로 실행하기 ~ 이것을 동적 sql이라 지칭
DEALLOCATE PREPARE myQuery;

CREATE TABLE gate_table (id INT AUTO_INCREMENT PRIMARY KEY, entry_time DATETIME);
SET @curDate = CURRENT_TIMESTAMP();
PREPARE myQuery FROM 'INSERT INTO gate_table VALUES(NULL, ?)';
EXECUTE myQuery USING @curDate;
DEALLOCATE PREPARE myQuery;
SELECT * FROM gate_table;
