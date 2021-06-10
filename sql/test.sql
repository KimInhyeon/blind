--유저생성
CREATE ROLE ksinfo WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  REPLICATION
  PASSWORD ksinfosys;

--데이터베이스 생성
CREATE DATABASE blind
    WITH 
    OWNER = ksinfo
    ENCODING = 'UTF8'
    LC_COLLATE = 'Japanese_Japan.932'
    LC_CTYPE = 'Japanese_Japan.932'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

--스키마 생성  
CREATE SCHEMA blind
    AUTHORIZATION ksinfo;  

--테스트용 테이블 생성
create table "blind".test (
  test character varying(300) not null
);

--테스트용 데이터 투입
INSERT INTO blind.test (
  test
) VALUES (
  'KSINFOSYS BLIND Project env setting Complete.'
);