select * from tab;
select * from book;
select * from movie;
select * from rating;
select * from premium_seat;
select * from standard_seat;
select * from on_screen;
select * from theater;
select * from member;
select * from user_constraints;
select * from user_cons_columns;
select * from user_tab_cols;




select substr(screen_num,0,1)
from on_screen;

--
insert into premium_seat(seat_num, book_number)
values(inparameter, inparameter


insert into on_screen(screen_num, screen_date, start_time, end_time, movie_code, screen_name)
values('N_1901311440', '2019-01-31', '1440', '1650', 'M_000018', 'N');

insert into on_screen(screen_num, screen_date, start_time, end_time, movie_code, screen_name)
values('P_1901311440', '2019-01-31', '1440', '1650', 'M_000018', 'P');

insert into on_screen(screen_num, screen_date, start_time, end_time, movie_code, screen_name)
values('N_1901311441', '2019-01-31', '1440', '1650', 'M_000018', 'N');

insert into on_screen(screen_num, screen_date, start_time, end_time, movie_code, screen_name)
values('P_1901311441', '2019-01-31', '1440', '1650', 'M_000018', 'P');

delete from on_screen
where movie_code = 'M_000018';
rollback;
commit;

--����, ��������, ���� ����
select movie_img, movie_title, movie_grade, genre, runningtime, playdate, actor, movie_code
from movie;

select count(substr(book_number,2,8)) audience
from book
group by substr(book_number,2,8);

--��ȭ �ڵ�� ���� ������
select substr(book_number,2,8) aa, sum(personnel)
from book
group by substr(book_number,2,8);

--��ȭ �ڵ�� ����
select substr(book_number,2,8) aa, trunc(avg(movie_rate),1)
from rating
group by substr(book_number,2,8);

--��ȭ����� ä�� ������
select movie_img, movie_title, movie_grade, genre, runningtime, playdate, actor, movie_code, audience
from
(select movie_img, movie_title, movie_grade, genre, runningtime, playdate, actor, movie_code,
		nvl(sum(personnel), 0) audience
from movie m
left join book b
on substr(b.book_number,2,8)= movie_code
group by movie_img, movie_title, movie_grade, genre, runningtime, playdate, actor, movie_code
order by audience desc, movie_title
) t
left join rating r
on  substr(r.book_number,2,8)= t.movie_code;

----��ȭ����� ä�� ���� �Ϻ��� ������
select movie_img, movie_title, movie_grade, audience, nvl(rating_avg, 0) rating_avg, genre,
		runningtime, playdate, actor, movie_code
from
(
select movie_img, movie_title, movie_grade, genre, runningtime, playdate, actor, movie_code,
		nvl(sum(personnel), 0) audience
from movie m
left join book
on substr(book_number,2,8)= movie_code
group by movie_img, movie_title, movie_grade, genre, runningtime, playdate, actor, movie_code
order by audience desc, movie_title
)
left join
(
select substr(book_number,2,8) r_movie_code, trunc(avg(movie_rate),1) rating_avg
from rating r
group by substr(book_number,2,8)
)
on r_movie_code = movie_code
order by audience desc, movie_title;


--��ȭ �������� ��ȸ�ϴ� ������
select movie_title, movie_img, genre, country, director, movie_grade, playdate, synopsis,
	actor, runningtime
from movie
where movie_code = 'M_000016';


--��ȭ�� �󿵽ð��� ��ȸ�ϴ� ������
select screen_date, start_time, end_time
from on_screen
where movie_code = 'M_000021';


--�󿵹�ȣ�� ���� ���Ͻ�, ����ð�, ���� �ܿ��¼� ���� ���ϴ� ���� �Ϻ��� ������
select o.screen_num, screen_date, start_time, end_time , seat_count
from theater t
left join on_screen o
on t.screen_name = o.screen_name
where screen_num = 'N_1901290830';

select screen_num, count(book_number) reserved
from book
group by screen_num;

select screen_date, start_time, end_time, screen_name, seat_count-nvl(reserved,0) remain_seat, a.screen_num
from
(
select o.screen_num, screen_date, start_time, end_time , seat_count, o.screen_name
from theater t
left join on_screen o
on t.screen_name = o.screen_name
where movie_code = 'M_000021'
) a
left join (
select screen_num, sum(personnel) reserved
from book
group by screen_num) b
on a.screen_num = b.screen_num
order by screen_num;


--�ش� �󿵹�ȣ�� ������ �¼��� ���ϴ� ������
select * from standard_seat;



select screen_num, b.book_number, seat_num
from book b
right join standard_seat s
on b.book_number = s.book_number;

select seat_num, screen_num
from book b
right join premium_seat p
on b.book_number = p.book_number
where screen_num ='P_1901290830';

select seat_num
from
(
select b.screen_num, book_number
from book b
left join on_screen o
on o.screen_num = b.screen_num
) sq
right join standard_seat s
on s.book_number = sq.book_number
where screen_num = 'N_1901291650';



--�α��εǾ��ִ� ȸ���� ���並 �ۼ��� �ڰ��� �ִ��� ��ȸ�ϴ� ������
select book_number
from
(
select screen_num, book_number
from book
where member_id= 'guest'
) a
inner join
(
select screen_num
from on_screen
where movie_code = 'M_000021'
) b
on a.screen_num = b.screen_num;

select asdfsaf
from book
where book_number = ?;


select movie_code, screen_num
from on_screen
where movie_code = 'M_000021' and screen_num = 'P_1901291300';
select screen_num
from book
where member_id='guest';


--�ش� ��ȭ�� �������� �������� ������
select movie_rate, review, member_id
from rating
where substr(book_number, 2, 8) = 'M_000021';
