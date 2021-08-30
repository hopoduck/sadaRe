-- 데이터 초기화
drop table sadare_user cascade constraints;
drop table sadare_category1 cascade constraints;
drop sequence seq_sadare_category1;
drop table sadare_category2 cascade constraints;
drop sequence seq_sadare_category2;
drop table sadare_category3 cascade constraints;
drop sequence seq_sadare_category3;
drop table sadare_product cascade constraints;
drop sequence seq_sadare_product;
drop table sadare_reply cascade constraints;
drop sequence seq_sadare_reply;
drop table sadare_wish cascade constraints;
drop sequence seq_sadare_wish;
drop table sadare_notice;
drop sequence seq_sadare_notice;
drop table sadare_alram;
drop sequence seq_sadare_alram;
drop table sadare_report;
drop sequence seq_sadare_report;

-- 작성자 : 한병조
create table sadare_user(
    user_id VARCHAR2(20) PRIMARY KEY,
    user_pwd VARCHAR2(20) NOT NULL,
    user_name VARCHAR2(50) NOT NULL,
    user_nickname VARCHAR2(50),
    user_email VARCHAR2(50) NOT NULL,
    user_tel VARCHAR2(20),
    user_postcode VARCHAR2(50),
    user_addr1 VARCHAR2(255),
    user_addr2 VARCHAR2(255),
    user_birth date,
    user_regdate date,
    user_score number,
    user_scorecount number,
    user_type number
);

-- 작성자 황선민
create table sadare_category1(
    category_num number primary key, 
    category_name varchar2(50) not null
);
create sequence seq_sadare_category1;

create table sadare_category2(
    category_num number primary key, 
    category_name varchar2(50) not null, 
    parent_category_num number references sadare_category1(category_num) on delete cascade
);
create sequence seq_sadare_category2;

create table sadare_category3(
    category_num number primary key, 
    category_name varchar2(50) not null, 
    parent_category_num number references sadare_category2(category_num) on delete cascade
);
create sequence seq_sadare_category3;

-- 작성자 한병조
create table sadare_product(
    product_num number primary key,
    product_name varchar2(50) not null,
    product_price number not null,
    product_info varchar2(500),
    category1_num number references sadare_category1(category_num),
    category2_num number references sadare_category2(category_num),
    category3_num number references sadare_category3(category_num),
    user_id varchar2(20) references sadare_user(user_id) on delete cascade,
    product_add_date date,
    product_hit number default 0,
    product_result number default 1
);
create sequence seq_sadare_product;

-- 작성자 한병조
create table sadare_reply(
    reply_num number primary key,
    user_id varchar2(50) references sadare_user(user_id) on delete cascade,
    reply_content varchar2(1000),
    product_num number references sadare_product(product_num) on delete cascade,
    reply_date date not null,
    parent_reply_num number
);
create sequence seq_sadare_reply;

--작성자 정다영
create table sadare_wish(
    wish_num number primary key,
    product_num number references sadare_product(product_num) on delete cascade,
    user_id varchar2(20) references sadare_user(user_id) on delete cascade
);
create sequence seq_sadare_wish;

--작성자 배건섭
create table sadare_notice(
   notice_num number primary key,
   notice_title varchar2(50) not null,
   notice_content varchar2(500) not null,
   notice_date date,
   notice_hits number default 0
);
create sequence seq_sadare_notice;

--작성자 한병조
create table sadare_alram(
    alram_num number primary key,
    user_id varchar2(20) references sadare_user(user_id) on delete cascade,
    product_num number references sadare_product(product_num) on delete cascade,
    alram_type number not null,
    -- 1: 판매글에 댓글 등록
    -- 2: 관심글 상태 변경
    alram_count number not null,
    alram_add_date date not null,
    alram_href varchar2(200) not null,
    alram_read number not null
);
create sequence seq_sadare_alram;

--작성자 정다영
create table sadare_report(
report_num number primary key,
product_num number not null,
report_title varchar2(50) not null,
report_content varchar2(500) not null,
report_date date,
report_writer_id varchar2(20) references sadare_user(user_id) on delete cascade,
report_user_id varchar2(20)
);
CREATE SEQUENCE seq_sadare_report;




-- 카테고리에 기본값 추가
insert into sadare_category1 values (0, 'a');
insert into sadare_category2 values (0, 'a', 0);
insert into sadare_category3 values (0, 'a', 0);


commit;
