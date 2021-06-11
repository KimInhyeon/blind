--토픽관리 테이블 생성
--drop table "blind".BOARD_MGT;

create table "blind".BOARD_MGT (
  board_id bigint GENERATED ALWAYS AS IDENTITY
  , board_topic_name character varying(30) not null
  , board_order integer not null
  , closed_flag character(1) not null
  , anonymous_flag character(1) not null
  , board_create_date timestamp not null
  , board_update_date timestamp not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (board_id)
);

--인덱스 설정
CREATE INDEX BOARD_MGT_INDEX ON "blind".BOARD_MGT (board_id);


--게시글관리 테이블 생성
--drop table "blind".POST_MGT;

create table "blind".POST_MGT (
  post_id bigint GENERATED ALWAYS AS IDENTITY
  , board_id bigint not null
  , user_id bigint not null
  , post_title character varying(200) not null
  , post_blind_flag character(1) not null
  , post_contents text not null
  , post_create_date timestamp not null
  , post_update_date timestamp not null
  , post_password character(64)
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (post_id)
);

--인덱스 설정
CREATE INDEX POST_MGT_INDEX ON "blind".POST_MGT (post_id);


--게시글추천수정보 테이블 생성
--drop table "blind".POST_RECOMMEND_INF;

create table "blind".POST_RECOMMEND_INF (
  post_recommend_id bigint GENERATED ALWAYS AS IDENTITY
  , post_id bigint not null
  , user_id bigint not null
  , post_recommend_flag character(1) not null
  , primary key (post_recommend_id)
);

--인덱스 설정
CREATE INDEX POST_RECOMMEND_INF_INDEX ON "blind".POST_RECOMMEND_INF (post_recommend_id);


--게시글파일관리 테이블 생성
--drop table "blind".POST_FILE_MGT;

create table "blind".POST_FILE_MGT (
  post_file_id bigint GENERATED ALWAYS AS IDENTITY
  , post_id bigint not null
  , post_file_url character varying(2000) not null
  , post_file_origin_name character varying(200) not null
  , post_file_size bigint not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (post_file_id)
);

--인덱스 설정
CREATE INDEX POST_FILE_MGT_INDEX ON "blind".POST_FILE_MGT (post_file_id);


--게시글신고관리 테이블 생성
--drop table "blind".POST_REPORT_MGT;

create table "blind".POST_REPORT_MGT (
  post_report_id bigint GENERATED ALWAYS AS IDENTITY
  , post_id bigint not null
  , user_id bigint not null
  , post_report_date timestamp not null
  , report_reason_code character(2) not null
  , report_reason_content character varying(400)
  , verify_flag character(1) not null
  , complete_flag character(1) not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (post_report_id)
);

--인덱스 설정
CREATE INDEX POST_REPORT_MGT_INDEX ON "blind".POST_REPORT_MGT (post_report_id);


--댓글관리 테이블 생성
--drop table "blind".REPLY_MGT;

create table "blind".REPLY_MGT (
  reply_id bigint GENERATED ALWAYS AS IDENTITY
  , post_id bigint not null
  , target_reply_id bigint
  , user_id bigint not null
  , reply_contents character varying(400) not null
  , reply_blind_flag character(1) not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (reply_id)
);

--인덱스 설정
CREATE INDEX REPLY_MGT_INDEX ON "blind".REPLY_MGT (reply_id);


--댓글추천수정보 테이블 생성
--drop table "blind".REPLY_RECOMMEND_INF;

create table "blind".REPLY_RECOMMEND_INF (
  reply_recommend_id bigint GENERATED ALWAYS AS IDENTITY
  , reply_id bigint not null
  , user_id bigint not null
  , reply_recommend_flag integer not null
  , primary key (reply_recommend_id)
);

--인덱스 설정
CREATE INDEX REPLY_RECOMMEND_INF_INDEX ON "blind".REPLY_RECOMMEND_INF (reply_recommend_id);


--댓글신고관리 테이블 생성
--drop table "blind".REPLY_REPORT_MGT;

create table "blind".REPLY_REPORT_MGT (
  reply_report_id bigint GENERATED ALWAYS AS IDENTITY
  , reply_id bigint not null
  , user_id bigint not null
  , reply_report_date timestamp not null
  , report_reason_code character(2) not null
  , report_reason_content character varying(400)
  , verify_flag character(1) not null
  , complete_flag character(1) not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (reply_report_id)
);

--인덱스 설정
CREATE INDEX REPLY_REPORT_MGT_INDEX ON "blind".REPLY_REPORT_MGT (reply_report_id);


--유저관리 테이블 생성
--drop table "blind".USER_MGT;

create table "blind".USER_MGT (
  user_id bigint GENERATED ALWAYS AS IDENTITY
  , user_generation integer not null
  , last_generation_flag character(1) not null
  , user_password character(64) not null
  , user_email character(64) not null
  , user_nickName character varying(30)
  , nickName_change_date date not null
  , company_id bigint
  , user_auth character(2) not null
  , reported_count integer not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (user_id)
);

--인덱스 설정
CREATE INDEX USER_MGT_INDEX ON "blind".USER_MGT (user_id);


--북마크관리 테이블 생성
--drop table "blind".BOOKMARK_MGT;

create table "blind".BOOKMARK_MGT (
  bookmark_id bigint GENERATED ALWAYS AS IDENTITY
  , post_id bigint not null
  , user_id bigint not null
  , bookmark_create_date timestamp not null
  , bookmark_update_date timestamp not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (bookmark_id)
);

--인덱스 설정
CREATE INDEX BOOKMARK_MGT_INDEX ON "blind".BOOKMARK_MGT (bookmark_id);


--게시글조회수정보 테이블 생성
--drop table "blind".POST_COUNT_INF;

create table "blind".POST_COUNT_INF (
  post_count_id bigint GENERATED ALWAYS AS IDENTITY
  , post_id bigint not null
  , post_count bigint not null
  , primary key (post_count_id)
);

--인덱스 설정
CREATE INDEX POST_COUNT_INF_INDEX ON "blind".POST_COUNT_INF (post_count_id);


--기업관리 테이블 생성
--drop table "blind".COMPANY_MGT;

create table "blind".COMPANY_MGT (
  company_id bigint GENERATED ALWAYS AS IDENTITY
  , user_id bigint not null
  , company_name character varying(50) not null
  , business_type_code character(2)
  , company_address character varying(200)
  , founding_date date
  , workers_count character varying(30)
  , app_date date not null
  , company_domain character varying(50) not null
  , company_homepage character varying(50) not null
  , company_explain character varying(600) not null
  , verify_flag character(1) not null
  , closing_flag character(1) not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (company_id)
);

--인덱스 설정
CREATE INDEX COMPANY_MGT_INDEX ON "blind".COMPANY_MGT (company_id);


--기업업종마스터 테이블 생성
--drop table "blind".BUSINESS_TYPE_MST;

create table "blind".BUSINESS_TYPE_MST (
  business_type_id bigint GENERATED ALWAYS AS IDENTITY
  , business_type_code character(2) not null
  , business_type_name character varying(50) not null
  , logical_del_flag character(1) not null
  , primary key (business_type_id)
);

--인덱스 설정
CREATE INDEX BUSINESS_TYPE_MST_INDEX ON "blind".BUSINESS_TYPE_MST (business_type_id);


--신고사유마스터 테이블 생성
--drop table "blind".REPORT_REASON_MST;

create table "blind".REPORT_REASON_MST (
  report_reason_id bigint GENERATED ALWAYS AS IDENTITY
  , report_reason_code character(2) not null
  , report_reason_contents character varying(200) not null
  , logical_del_flag character(1) not null
  , primary key (report_reason_id)
);

--인덱스 설정
CREATE INDEX REPORT_REASON_MST_INDEX ON "blind".REPORT_REASON_MST (report_reason_id);


--기업리뷰관리 테이블 생성
--drop table "blind".COMPANY_REVIEW_MGT;

create table "blind".COMPANY_REVIEW_MGT (
  company_review_id bigint GENERATED ALWAYS AS IDENTITY
  , user_id bigint not null
  , company_id bigint not null
  , job_group_code character(2) not null
  , all_point numeric(2, 1) not null
  , career_point integer not null
  , work_life_balance_point integer not null
  , pay_point integer not null
  , company_culture_point integer not null
  , head_point integer not null
  , work_start_date date not null
  , work_end_date date not null
  , simple_comment character varying(60) not null
  , resign_reason character varying(150) not null
  , work_area character varying(50) not null
  , advantages character varying(400) not null
  , disadvantages character varying(400) not null
  , verify_flag character(1) not null
  , complete_flag character(1) not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (company_review_id)
);

--인덱스 설정
CREATE INDEX COMPANY_REVIEW_MGT_INDEX ON "blind".COMPANY_REVIEW_MGT (company_review_id);


--리뷰추천수정보 테이블 생성
--drop table "blind".REVIEW_RECOMMEND_INF;

create table "blind".REVIEW_RECOMMEND_INF (
  review_recommend_id bigint GENERATED ALWAYS AS IDENTITY
  , company_review_id bigint not null
  , company_id bigint not null
  , user_id bigint not null
  , helpful integer not null
  , primary key (review_recommend_id)
);

--인덱스 설정
CREATE INDEX REVIEW_RECOMMEND_INF_INDEX ON "blind".REVIEW_RECOMMEND_INF (review_recommend_id);


--기업리뷰신고관리 테이블 생성
--drop table "blind".REVIEW_REPORT_MGT;

create table "blind".REVIEW_REPORT_MGT (
  review_report_id bigint GENERATED ALWAYS AS IDENTITY
  , company_review_id bigint not null
  , user_id bigint not null
  , review_report_date timestamp not null
  , report_reason_code character(2) not null
  , report_reason_content character varying(400)
  , verify_flag character(1) not null
  , complete_flag character(1) not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (review_report_id)
);

--인덱스 설정
CREATE INDEX REVIEW_REPORT_MGT_INDEX ON "blind".REVIEW_REPORT_MGT (review_report_id);


--직군마스터 테이블 생성
--drop table "blind".JOB_GROUP_MST;

create table "blind".JOB_GROUP_MST (
  job_group_id bigint GENERATED ALWAYS AS IDENTITY
  , job_group_code character(2) not null
  , job_group_name character varying(100) not null
  , logical_del_flag character(1) not null
  , primary key (job_group_id)
);

--인덱스 설정
CREATE INDEX JOB_GROUP_MST_INDEX ON "blind".JOB_GROUP_MST (job_group_id);


--기업추천정보 테이블 생성
--drop table "blind".COMPANY_RECOMMEND_INF;

create table "blind".COMPANY_RECOMMEND_INF (
  company_recommend_id bigint GENERATED ALWAYS AS IDENTITY
  , user_id bigint not null
  , company_id bigint not null
  , good integer not null
  , bad integer not null
  , primary key (company_recommend_id)
);

--인덱스 설정
CREATE INDEX COMPANY_RECOMMEND_INF_INDEX ON "blind".COMPANY_RECOMMEND_INF (company_recommend_id);


--급료랭킹관리 테이블 생성
--drop table "blind".SALARY_RANK_MGT;

create table "blind".SALARY_RANK_MGT (
  salary_rank_id bigint GENERATED ALWAYS AS IDENTITY
  , user_id bigint not null
  , salary bigint not null
  , job_group_code character(2) not null
  , rec_create_user_id bigint not null
  , rec_create_date timestamp not null
  , rec_update_user_id bigint not null
  , rec_update_date timestamp not null
  , logical_del_flag character(1) not null
  , primary key (salary_rank_id)
);

--인덱스 설정
CREATE INDEX SALARY_RANK_MGT_INDEX ON "blind".SALARY_RANK_MGT (salary_rank_id);


--디렉토리정보 테이블 생성
--drop table "blind".DIRECTORY_INF;

create table "blind".DIRECTORY_INF (
  directory_id bigint GENERATED ALWAYS AS IDENTITY
  , company_id bigint not null
  , directory_keireki character varying(80) not null
  , directory_keireki_resume character varying(80) not null
  , directory_comapny_culture character varying(80) not null
  , directory_comapny_evaluation character varying(80) not null
  , directory_interview character varying(80) not null
  , directory_culture character varying(80) not null
  , directory_welfare character varying(80) not null
  , directory_salary character varying(80) not null
  , directory_salary_negotiation character varying(80) not null
  , directory_work_life_balance character varying(80) not null
  , directory_turnover character varying(80) not null
  , directory_turnover_consulting character varying(80) not null
  , directory_hire character varying(80) not null
  , directory_employment character varying(80) not null
  , directory_find_job character varying(80) not null
  , directory_career character varying(80) not null
  , directory_company_atmosphere character varying(80) not null
  , directory_company_review character varying(80) not null
  , directory_kaisya_culture character varying(80) not null
  , directory_kaisya_info character varying(80) not null
  , directory_kaisya_evaluation character varying(80) not null
  , primary key (directory_id)
);

--인덱스 설정
CREATE INDEX DIRECTORY_INF_INDEX ON "blind".DIRECTORY_INF (directory_id);
