USE market_db;
CREATE TABLE hongong4 (
    tinyint_col  TINYINT, # 바이트 수 1, 숫자 범위 -128~127
    smallint_col SMALLINT, # 바이트 수 2, -32,768 ~ 32,767
    int_col    INT, # 바이트 수 4, -21억 ~ 21억
    bigint_col BIGINT ); # 바이트 수 8, -900경 ~ 900경
INSERT INTO hongong4 VALUES(127, 32767, 2147483647, 9000000000000000000);

DROP TABLE IF EXISTS member; # 사용하지 않는 것이 좋으나 에러 방지
CREATE TABLE member -- 회원 테이블
( mem_id      CHAR(8) NOT NULL PRIMARY KEY, -- 회원 아이디(PK)
  mem_name        VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr          CHAR(2) NOT NULL, -- 주소(경기,서울,경남 식으로 2글자만입력)
  phone1        CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2        CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height        SMALLINT,  -- 평균 키
  debut_date    DATE  -- 데뷔 일자
);

DROP TABLE IF EXISTS member; # 사용하지 않는 것이 좋으나 에러 방지
CREATE TABLE member -- 회원 테이블
( mem_id      CHAR(8) NOT NULL PRIMARY KEY, -- 회원 아이디(PK)
  mem_name        VARCHAR(10) NOT NULL, -- 이름
  mem_number    TINYINT  NOT NULL,  -- 인원수
  addr          CHAR(2) NOT NULL, -- 주소(경기,서울,경남 식으로 2글자만입력)
  phone1        CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2        CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height        TINYINT UNSIGNED,  -- 평균 키
  debut_date    DATE  -- 데뷔 일자
);

DROP TABLE IF EXISTS member; # 사용하지 않는 것이 좋으나 에러 방지
CREATE TABLE member -- 회원 테이블
( mem_id      CHAR(8) NOT NULL PRIMARY KEY, -- 회원 아이디(PK)
  mem_name        VARCHAR(10) NOT NULL, -- 이름
  mem_number    TINYINT  NOT NULL,  -- 인원수
  addr          CHAR(2) NOT NULL, -- 주소(경기,서울,경남 식으로 2글자만입력)
  phone1        CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2        CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height        TINYINT UNSIGNED,  -- 평균 키
  debut_date    DATE  -- 데뷔 일자
);

CREATE TABLE big_table ( # 최대 자
  data1  CHAR(255), 
  data2  VARCHAR(16383) );
  
CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE movie 
  (movie_id        INT,
   movie_title     VARCHAR(30),
   movie_director  VARCHAR(20),
   movie_star      VARCHAR(20),
   movie_script    LONGTEXT, # 자막 열
   movie_film      LONGBLOB # 동영상 열
); 

USE market_db;
SET @myVar1 = 5 ;
SET @myVar2 = 4.25 ;
SELECT @myVar1 ;
SELECT @myVar1 + @myVar2 ;
SET @txt = '가수 이름==> ' ;
SET @height = 166;
SELECT @txt , mem_name FROM member WHERE height > @height ;

SET @count = 3;
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?';
EXECUTE mySQL USING @count;

SELECT AVG(price) '평균 가격' FROM buy;
SELECT CAST(AVG(price) AS SIGNED)  '평균 가격'  FROM buy ;
SELECT CONVERT(AVG(price) , SIGNED)  '평균 가격'  FROM buy ;
SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);
SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR) ,'=' ) '가격X수량', price*amount '구매액' FROM buy ;
SELECT '100' + '200' ; -- 문자와 문자, 정수로 변환되서 연산
SELECT CONCAT('100', '200'); -- 문자와 문자, 문자로 처리
SELECT CONCAT(100, '200'); -- 정수와 문자, 정수가 문자로 변환
SELECT 1 > '2mega'; -- 정수인 2로 변환
SELECT 3 > '2MEGA'; -- 정수인 2로 변환
SELECT 0 = 'mega2'; -- 문자는 0으로 변환