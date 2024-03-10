USE market_db;
SELECT * FROM buy INNER JOIN member ON buy.mem_id = member.mem_id WHERE buy.mem_id = 'GRL';

SELECT * FROM buy INNER JOIN member ON buy.mem_id = member.mem_id;

SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) AS '연락처' FROM buy INNER JOIN member ON buy.mem_id = member.mem_id;

SELECT buy.mem_id, member.mem_name, buy.prod_name, addr, CONCAT(member.phone1, member.phone2) AS '연락처' FROM buy INNER JOIN member ON buy.mem_id = member.mem_id;
     
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) AS '연락처'  FROM buy B INNER JOIN member M ON B.mem_id = M.mem_id; # 별칭
          
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM buy B INNER JOIN member M ON B.mem_id = M.mem_id ORDER BY M.mem_id;

SELECT DISTINCT M.mem_id, M.mem_name, M.addr FROM buy B INNER JOIN member M ON B.mem_id = M.mem_id ORDER BY M.mem_id;
   
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM member M LEFT OUTER JOIN buy B ON M.mem_id = B.mem_idORDER BY M.mem_id; # 왼쪽에 있는 회원 테이블을 기준으로 외부 조인

SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM buy B RIGHT OUTER JOIN member M ON M.mem_id = B.mem_id ORDER BY M.mem_id; # 오른쪽에 있는 회원 테이블을 기준으로 외부 조인
   
SELECT DISTINCT M.mem_id, B.prod_name, M.mem_name, M.addr FROM member M LEFT OUTER JOIN buy B ON M.mem_id = B.mem_id WHERE B.prod_name IS NULL ORDER BY M.mem_id; # 구매 내역 없는 회원

SELECT * FROM buy CROSS JOIN member ;

SELECT COUNT(*) "데이터 개수" FROM sakila.inventory CROSS JOIN world.city; # 상호조인 = 카티션 곱 (on구문 불가, 랜덤으로 조인하기에 결과 내용 의미x, 테스트용으로 주로 사용)

SELECT COUNT(*) "데이터 개수" FROM sakila.inventory CROSS JOIN world.city;

CREATE TABLE cross_table SELECT * FROM sakila.actor CROSS JOIN world.country;
SELECT * FROM cross_table LIMIT 5;

USE market_db;
CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));
INSERT INTO emp_table VALUES('대표', NULL, '0000');
INSERT INTO emp_table VALUES('영업이사', '대표', '1111');
INSERT INTO emp_table VALUES('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES('정보이사', '대표', '3333');
INSERT INTO emp_table VALUES('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUES('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUES('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUES('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUES('개발주임', '정보이사', '3333-1-1');

SELECT A.emp "직원" , B.emp "직속상관", B.phone "직속상관연락처" FROM emp_table A INNER JOIN emp_table B ON A.manager = B.emp WHERE A.emp = '경리부장';