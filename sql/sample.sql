INSERT INTO blind.board_mgt (
    board_id
  , board_topic_name
  , board_order
  , closed_flag
  , anonymous_flag
  , board_create_date
  , board_update_date
  , rec_create_user_id
  , rec_create_date
  , rec_update_user_id
  , rec_update_date
  , logical_del_flag
) VALUES (
    DEFAULT
  , 'board1'
  , 1
  , '0'
  , '1'
  , now()
  , now()
  , 1
  , now()
  , 1
  , now()
  , '1'
);

INSERT INTO blind.business_type_mst (
    business_type_id
  , business_type_code
  , business_type_name
  , logical_del_flag
) VALUES (
    DEFAULT
  , '01'
  , '農業，林業'
  , '1'
);
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '02', '漁業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '03', '鉱業，採石業，砂利採取業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '04', '建設業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '05', '製造業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '06', '電気・ガス・熱供給・水道業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '07', '情報通信業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '08', '運輸業，郵便業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '09', '卸売業・小売業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '10', '金融業・保険業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '11', '不動産業，物品賃貸業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '12', '学術研究，専門・技術サービス業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '13', '宿泊業，飲食サービス業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '14', '生活関連サービス業，娯楽業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '15', '教育，学習支援業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '16', '医療，福祉', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '17', '複合サービス事業', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '18', 'サービス業（他に分類されないもの）', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '19', '公務（他に分類されるものを除く）', '1');
INSERT INTO blind.business_type_mst VALUES (DEFAULT, '20', '分類不能の産業', '1');

INSERT INTO blind.company_mgt (
    company_id
  , user_id
  , company_name
  , business_type_code
  , company_address
  , founding_date
  , workers_count
  , app_date
  , company_domain
  , company_homepage
  , company_explain
  , verify_flag
  , closing_flag
  , rec_create_user_id
  , rec_create_date
  , rec_update_user_id
  , rec_update_date
  , logical_del_flag
) VALUES (
    DEFAULT
  , 1
  , 'KS情報システム'
  , '07'
  , '東京都中央区'
  , '2014-11-14'
  , '10~50'
  , '2021-05-06'
  , 'ks-infosys.com'
  , 'http://ks-infosys.com/'
  , '管理会社'
  , '0'
  , '0'
  , 1
  , now()
  , 1
  , now()
  , '1'
);
INSERT INTO blind.user_mgt (
    user_id
  , user_generation
  , last_generation_flag
  , user_password
  , user_email
  , user_nickName
  , nickName_change_date
  , company_id
  , user_auth
  , reported_count
  , rec_create_user_id
  , rec_create_date
  , rec_update_user_id
  , rec_update_date
  , logical_del_flag
) VALUES (
    DEFAULT
  , 1
  , '1'
  , 'testpassword'
  , 'changju.lee@ks-infosys.com'
  , 'changju.lee'
  , now()
  , 1
  , 'SV'
  , 0
  , 1
  , now()
  , 1
  , now()
  , '1'
);

INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword2', 'testAdmin2@ks-infosys.com', 'testAdmin2', now(), 1, 'SV', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword3', 'testAdmin3@ks-infosys.com', 'testAdmin3', now(), 1, 'SV', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword4', 'testAdmin4@ks-infosys.com', 'testAdmin4', now(), 1, 'SV', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword5', 'testAdmin5@ks-infosys.com', 'testAdmin5', now(), 1, 'SV', 0, 1, now(), 1, now(), '1');

INSERT INTO blind.company_mgt VALUES (DEFAULT, 2, 'testcompany2', '02', '神奈川県横浜市', '1998-12-26', '10-100', '2021-06-01', 'testcompany2.com', 'http://www.testcompany2.com', '2番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 3, 'testcompany3', '03', '千葉県千葉市', '1998-12-27', '1000-2000', '2021-06-02', 'testcompany3.com', 'http://www.testcompany3.com', '3番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 4, 'testcompany4', '04', '埼玉県さいたま市', '1998-12-28', '100-500', '2021-06-03', 'testcompany4.com', 'http://www.testcompany4.com', '4番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 5, 'testcompany5', '05', '北海道札幌市', '1998-12-29', '500-1000', '2021-06-04', 'testcompany5.com', 'http://www.testcompany5.com', '5番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 2, 'testcompany6', '06', '京都府京都市', '1998-12-30', '1-10', '2021-06-04', 'testcompany6.com', 'http://www.testcompany6.com', '6番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 2, 'testcompany7', '05', '福岡県福岡市', '1998-12-31', '1000-2000', '2021-06-05', 'testcompany7.com', 'http://www.testcompany7.com', '7番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 1, 'testcompany8', '04', '佐賀県佐賀市', '1999-01-01', '2000-3000', '2021-06-06', 'testcompany8.com', 'http://www.testcompany8.com', '8番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 1, 'testcompany9', '03', '沖縄県沖縄市', '1999-01-02', '3000-4000', '2021-06-06', 'testcompany9.com', 'http://www.testcompany9.com', '9番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 3, 'testcompany10', '02', '広島県広島市', '1999-01-03', '4000-5000', now(), 'testcompany10.com', 'http://www.testcompany10.com', '10番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');
INSERT INTO blind.company_mgt VALUES (DEFAULT, 4, 'testcompany11', '01', '大阪府大阪市', '1999-01-04', '5000-10000', now(), 'testcompany11.com', 'http://www.testcompany11.com', '11番目のテストコンパニー', '0', '0', 1, now(), 1, now(), '1');

INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword6', 'testuser5@testcompany5.com', 'testuser6', now(), 5, 'NM', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword7', 'testuser6@testcompany6.com', 'testuser7', now(), 6, 'RM', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword8', 'testuser7@testcompany7.com', 'testuser8', now(), 7, 'RM', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword9', 'testuser8@testcompany1.com', 'testuser9', now(), 1, 'NM', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword10', 'testuser9@testcompany1.com', 'testuser10', now(), 1, 'NM', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword11', 'testuser10@testcompany2.com', 'testuser11', now(), 2, 'RM', 0, 1, now(), 1, now(), '1');
INSERT INTO blind.user_mgt VALUES (DEFAULT, 1, '1', 'testpassword12', 'testuser11@testcompany3.com', 'testuser12', now(), 3, 'RM', 0, 1, now(), 1, now(), '1');