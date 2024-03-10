use market_db ;
select * from member ;
select * from market_db.member ; # 두개가 동일한 결과 
select mem_name from member ;
select addr, debute_date, mem_name from member ;
select * from member where mem_name = '블랙핑크' ;
select * from member where mem_number = 4;
select mem_id, mem_name from member where height <= 162 ;
select mem_name, height, mem_number from member where height >= 162 and mem_number > 6;
select mem_name, height from member where height >= 163 and height <= 165 ;
select mem_name, height from member where height between 163 and 165 ;
select mem_name, addr from member where addr = '경기' or addr = '경남' ;
select mem_name, addr from member where addr in ('경기', '전남', '경남') ;
select * from member where mem_name like '우%' ;
select * from member where mem_name like '__핑크' ;