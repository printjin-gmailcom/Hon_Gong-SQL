DELIMITER //
create procedure myProc()
begin
	select * from member where member_name = '나흔아님';
	select * from product where product_name = '삼각김밥';
END //
DELIMITER ;

CALL myProc() ;