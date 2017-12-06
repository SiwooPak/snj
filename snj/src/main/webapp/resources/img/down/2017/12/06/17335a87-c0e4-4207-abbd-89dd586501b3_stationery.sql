-- 코드
DROP TABLE TB_COM_CODE CASCADE;
CREATE TABLE TB_COM_CODE(
  COMM_TY_CD VARCHAR(10),
  COMM_CD VARCHAR(20),
  COMM_CD_NM VARCHAR(30),

  CONSTRAINT TB_CODE_PK PRIMARY KEY(COMM_TY_CD, COMM_CD)
);

-- 전화번호
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0100', '01', '010');
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0100', '02', '011');
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0100', '03', '016');
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0100', '04', '019');

-- 분류코드
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0101', 'B', '화일/바인더');
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0101', 'D', '디자인문구');
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0101', 'O', '사무용품');
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0101', 'P', '필기류');
INSERT INTO TB_COM_CODE(COMM_TY_CD, COMM_CD, COMM_CD_NM) VALUES('CODE0101', 'S', '정리/수납용품');


-- 회원정보
DROP TABLE TB_COM_USER CASCADE;
CREATE TABLE TB_COM_USER(
  USER_CODE VARCHAR(20),             -- 유저코드
  ID VARCHAR(20),                  -- 아이디
  PW VARCHAR(20),                   -- 패스워드
  EMAIL VARCHAR(50),                      -- 이메일
  USER_IMAGE VARCHAR(100),               -- 유저이미지
  NAME VARCHAR(20),                       -- 이름
  BIRTH VARCHAR(20),                      -- 생일
  POST_NUM VARCHAR(20),                   -- 우편번호
  PHONE_CD VARCHAR(2),                    -- 전화번호앞자리 코드
  PHONE_NUM VARCHAR(20),                  -- 전화번호뒷자리
  ADDRESS1 VARCHAR(100),                   -- 주소
  ADDRESS2 VARCHAR(100),
  ENT_DATE VARCHAR(30),                   -- 회원가입일
  GRADE VARCHAR(1) DEFAULT 'M',			   -- 회원등급
  CONSTRAINT TB_COM_USER_PK PRIMARY KEY(USER_CODE)
);

INSERT INTO TB_COM_USER(USER_CODE, ID, PW, EMAIL, USER_IMAGE, NAME, BIRTH, POST_NUM, PHONE_CD, PHONE_NUM, ADDRESS, ENT_DATE, GRADE) VALUES (
          'USER0000' || USER_SEQ.NEXTVAL, 'admin', 'admin', 'admin@naver.com', 'admin.png', '관리자', '1961-01-28', '217-814',
          '01', '1434-8011', '서울시 송파구 방이동 현대아파트', '2015-11-21', 'A');

INSERT INTO TB_COM_USER(USER_CODE, ID, PW, EMAIL, USER_IMAGE, NAME, BIRTH, POST_NUM, PHONE_CD, PHONE_NUM, ADDRESS, ENT_DATE) VALUES (
          'USER0000' || USER_SEQ.NEXTVAL, 'ranone', 'ranone', 'ranone@naver.com', 'ranone.png', '존레논', '1972-06-19', '151-241',
          '01', '8822-5318', '서울시 성동구 성수2동 롯데캐슬', '2015-11-21');

INSERT INTO TB_COM_USER(USER_CODE, ID, PW, EMAIL, USER_IMAGE, NAME, BIRTH, POST_NUM, PHONE_CD, PHONE_NUM, ADDRESS, ENT_DATE) VALUES (
          'USER0000' || USER_SEQ.NEXTVAL, 'love86n', 'love86n', 'love86n@naver.com', 'love86n.png', '헤더신', '1986-12-20', '391-756',
          '01', '0235-7912', '서울시 송파구 방이3동 유라상가', '2015-12-01');

INSERT INTO TB_COM_USER(USER_CODE, ID, PW, EMAIL, USER_IMAGE, NAME, BIRTH, POST_NUM, PHONE_CD, PHONE_NUM, ADDRESS, ENT_DATE) VALUES (
          'USER0000' || USER_SEQ.NEXTVAL, 'sawol', 'sawol', 'sawol@naver.com', 'sawol.png', '금사월', '1981-09-18', '157-995',
          '01', '1753-2718', '서울시 성북구 돈암1동 브라운스톤', '2014-03-17');

INSERT INTO TB_COM_USER(USER_CODE, ID, PW, EMAIL, USER_IMAGE, NAME, BIRTH, POST_NUM, PHONE_CD, PHONE_NUM, ADDRESS, ENT_DATE) VALUES (
          'USER0000' || USER_SEQ.NEXTVAL, 'ksy', 'ksy', 'ksy@naver.com', 'ksy.png', '기성용', '1989-01-12', '134-512',
          '01', '1326-2632', '서울시 중구 동대문4가 종로빌딩', '2015-10-30');

INSERT INTO TB_COM_USER(USER_CODE, ID, PW, EMAIL, USER_IMAGE, NAME, BIRTH, POST_NUM, PHONE_CD, PHONE_NUM, ADDRESS, ENT_DATE) VALUES (
          'USER0000' || USER_SEQ.NEXTVAL, 'shm', 'shm', 'shm@naver.com', 'shm.png', '손흥민', '1992-05-07', '613-844',
          '01', '5551-3774', '서울시 노원구 상계3동 한신아파트', '2012-08-02');

commit;

-- 제품정보
DROP TABLE TB_PRODUCT CASCADE;
CREATE TABLE TB_PRODUCT(
  PRODUCT_CODE VARCHAR(20),                  -- 제품코드
  PRODUCT_IMAGE VARCHAR(70),                 -- 제품이미지
  PRODUCT_NAME VARCHAR(200),                  -- 제품명
  PRODUCT_UNIT_PRICE integer,			  -- 제품단가
  PRODUCT_COUNT integer,					  -- 제품재고수량
  PRODUCT_CATEGORY_CD VARCHAR(20),              -- 제품카테고리코드
  PRODUCT_REG_DATE VARCHAR(20),              -- 제품등록일

  CONSTRAINT TB_PRODUCT_PK PRIMARY KEY(PRODUCT_CODE)
);

INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p1.jpg', '오렌지 유성펜', 500, 2, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p2.jpg', '엠소프트', 1000, 10, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p3.jpg', '싸인펜 어데나500', 250, 30, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p4.jpg', '유성병매직', 1500, 20, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p5.jpg', '유성둥근촉매직', 700, 35, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p6.jpg', '보드마카 콤비세트', 3300, 15, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p7.jpg', '형광펜 언더라인펜 5색세트', 1500, 20, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p8.jpg', '수채화 붓펜 - 홍색(紅色)', 4000, 20, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p9.jpg', '트라이클릭 샤프 1360', 1000, 50, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('P00' || PRODUCT_SEQ.NEXTVAL, 'p10.jpg', 'SLEEVE 지우개', 3500, 20, 'P', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));

INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd1.jpg', '박스테이프 투명 OPP 48mm*35M', 1400, 50, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd2.jpg', '고정펀치 503 2공 7cm', 10000, 10, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd3.jpg', '실버크립', 1300, 30, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd4.jpg', '딱풀 400 8g', 400, 40, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd5.jpg', '인주 원터치555', 16000, 30, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd6.jpg', '걸이용 안내판(상담중)4902', 4400, 20, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd7.jpg', '화이트보드지우개 1겹(낱개)', 550, 15, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd8.jpg', '분필 백색(1갑=12입)', 1500, 10, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd9.jpg', '화이트보드 스탠드(보드사이드600*900mm)', 70000, 5, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('O00' || PRODUCT_SEQ.NEXTVAL, 'd10.jpg', '컬러 방안자 15cm(색상랜덤발송)', 1000, 5, 'O', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));

INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c1.jpg', '[시스맥스]멀티책꽃이 3단', 1200, 10, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c2.jpg', '북앤드 102', 4300, 5, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c3.jpg', '서류함 1213k 개인3단', 4400, 3, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c4.jpg', '서류함 오픈형4단', 34000, 4, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c5.jpg', '다이나믹 책꽂이 MH-505대', 24000, 10, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c6.jpg', '멀티책꽂이/4단', 14000, 8, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c7.jpg', '서류꽂이 K93091 3단', 22000, 9, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('S00' || PRODUCT_SEQ.NEXTVAL, 'c8.jpg', '핸디박스', 1000, 15, 'S', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));

INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f1.jpg', '정부화일 A4', 4000, 20, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f2.jpg', '클리어화일내지 일반 A4', 1700, 50, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f3.jpg', '칼라클리어화일 A4 40P', 3500, 4, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f4.jpg', '크리스탈 클리어화일 20P', 3300, 70, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f5.jpg', '프리미엄 링클리어화일 30P', 8000, 5, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f6.jpg', '문서보관상자(신) A4 (1팩=5입)', 10000, 60, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f7.jpg', '엠보 클리어화일 30P', 2800, 81, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('B00' || PRODUCT_SEQ.NEXTVAL, 'f8.jpg', '고주파 명함첩 180S', 15000, 20, 'B', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));

INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's1.jpg', '연수용멀티노트v.3', 3000, 10, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's2.jpg', '한지로 가죽 여권케이스', 33000, 15, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's3.jpg', '부직포주머니', 2000, 20, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's4.jpg', '스프링귀마개', 3500, 4, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's5.jpg', '크리스마스 머리띠', 2500, 78, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's6.jpg', '캐릭터 카드케이스', 3000, 25, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's7.jpg', '핼로캣 주차알림인형', 10000, 23, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's8.jpg', '데코팩-미니', 4800, 100, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's9.jpg', '포스트 월렛', 28000, 25, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's10.jpg', 'A6 미니 캐쉬북', 3200, 34, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's11.jpg', '스마트파우치', 18800, 6, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));
INSERT INTO TB_PRODUCT(PRODUCT_CODE, PRODUCT_IMAGE, PRODUCT_NAME, PRODUCT_UNIT_PRICE, PRODUCT_COUNT,  PRODUCT_CATEGORY_CD, PRODUCT_REG_DATE)
VALUES('D00' || PRODUCT_SEQ.NEXTVAL, 's12.jpg', '포켓스티커 코너', 1500, 19, 'D', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));

-- 판매내역정보
DROP TABLE TB_SELL CASCADE;
CREATE TABLE TB_SELL(
  SELL_CODE VARCHAR(20),          -- 판매내역코드
  PRODUCT_CODE VARCHAR(20),       -- 제품코드
  USER_CODE VARCHAR(20),          -- 유저코드
  SELL_PRICE integer,         -- 판매총가격
  SELL_COUNT integer,         -- 판매총수량
  SELL_YN VARCHAR(1) DEFAULT 'N',  -- 판매여부
  SELL_DATE VARCHAR(30),          -- 판매일

  CONSTRAINT TB_SELL_PK PRIMARY KEY(SELL_CODE),
  CONSTRAINT TB_SELL_FK_PRODUCT FOREIGN KEY(PRODUCT_CODE) REFERENCES TB_PRODUCT(PRODUCT_CODE),
  CONSTRAINT TB_SELL_FK_USER FOREIGN KEY(USER_CODE) REFERENCES TB_COM_USER(USER_CODE)
);

-- 장바구니정보
DROP TABLE TB_CART CASCADE;
CREATE TABLE TB_CART(
  CART_CODE VARCHAR(20),          -- 장바구니코드
  PRODUCT_CODE VARCHAR(20),       -- 제품코드
  USER_CODE VARCHAR(20),          -- 유저코드
  CART_PRICE integer,         -- 해당제품총가격
  CART_COUNT integer,         -- 해당제품총수량
  CART_DATE VARCHAR(30),          -- 장바구니 저장일

  CONSTRAINT TB_CART_PK PRIMARY KEY(CART_CODE),
  CONSTRAINT TB_CART_FK_PRODUCT FOREIGN KEY(PRODUCT_CODE) REFERENCES TB_PRODUCT(PRODUCT_CODE),
  CONSTRAINT TB_CART_FK_USER FOREIGN KEY(USER_CODE) REFERENCES TB_COM_USER(USER_CODE)
);

-- 댓글정보
DROP TABLE TB_REPLY CASCADE;
CREATE TABLE TB_REPLY(
  PRODUCT_CODE VARCHAR(30),                  -- 투표코드
  USER_CODE VARCHAR(20),                  -- 유저코드
  USER_REPLY_NO Integer,           -- 댓글일련번호
  USER_REPLY VARCHAR(1000),         -- 댓글내용
  REPLY_DATE VARCHAR(30),           -- 댓글날짜
  CONSTRAINT TB_REPLY_PK PRIMARY KEY(PRODUCT_CODE, USER_CODE, USER_REPLY_NO),
  CONSTRAINT TB_REPLY_FK_PRODUCT FOREIGN KEY(PRODUCT_CODE) REFERENCES TB_PRODUCT(PRODUCT_CODE),
  CONSTRAINT TB_REPLY_FK_USER FOREIGN KEY(USER_CODE) REFERENCES TB_COM_USER(USER_CODE)
);

-- 별점정보
DROP TABLE TB_MARK CASCADE;
CREATE TABLE TB_MARK(
  PRODUCT_CODE VARCHAR(30),                  -- 투표코드
  USER_CODE VARCHAR(20),                  -- 유저코드
  MARK_RATING int,        		 -- 별점(5점만점)
  CONSTRAINT TB_MARK_PK PRIMARY KEY(PRODUCT_CODE, USER_CODE),
  CONSTRAINT TB_MARK_FK_PRODUCT FOREIGN KEY(PRODUCT_CODE) REFERENCES TB_PRODUCT(PRODUCT_CODE),
  CONSTRAINT TB_MARK_FK_USER FOREIGN KEY(USER_CODE) REFERENCES TB_COM_USER(USER_CODE)
);

commit;