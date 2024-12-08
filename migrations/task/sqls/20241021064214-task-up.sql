-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================
-- 1. 用戶資料，資料表為 USER

-- 1. 新增：新增六筆用戶資料，資料如下：
--     1. 用戶名稱為`李燕容`，Email 為`lee2000@hexschooltest.io`，Role為`USER`
--     2. 用戶名稱為`王小明`，Email 為`wXlTq@hexschooltest.io`，Role為`USER`
--     3. 用戶名稱為`肌肉棒子`，Email 為`muscle@hexschooltest.io`，Role為`USER`
--     4. 用戶名稱為`好野人`，Email 為`richman@hexschooltest.io`，Role為`USER`
--     5. 用戶名稱為`Q太郎`，Email 為`starplatinum@hexschooltest.io`，Role為`USER`
--     6. 用戶名稱為 透明人，Email 為 opacity0@hexschooltest.io，Role 為 USER
insert into "USER" (name, email, role) values 
('李燕容', 'lee2000@hexschooltest.io', 'USER' ),
('王小明', 'wXlTq@hexschooltest.io', 'USER' ),
('肌肉棒子', 'muscle@hexschooltest.io', 'USER'),
('好野人', 'richman@hexschooltest.io', 'USER'),
('Q太郎', ' starplatinum@hexschooltest.io', 'USER' ),
('透明人', ' opacity0@hexschooltest.io','USER');

-- 1-2 修改：用 Email 找到 李燕容、肌肉棒子、Q太郎，如果他的 Role 為 USER 將他的 Role 改為 COACH

select * from "USER" ;
update "USER" 
set role = 'COACH'
where email = 'lee2000@hexschooltest.io' 
or email = 'muscle@hexschooltest.io' 
or email = 'starplatinum@hexschooltest.io';

-- 1-3 刪除：刪除USER 資料表中，用 Email 找到透明人，並刪除該筆資料
delete from "USER" 
where name = '透明人';
select * from USER;

-- 1-4 查詢：取得USER 資料表目前所有用戶數量（提示：使用count函式）
select count(*)as "user數量" from "USER";

-- 1-5 查詢：取得 USER 資料表所有用戶資料，並列出前 3 筆（提示：使用limit語法）

select * from "USER" limit 3;

--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================
-- 2. 組合包方案 CREDIT_PACKAGE、客戶購買課程堂數 CREDIT_PURCHASE
-- 2-1. 新增：在`CREDIT_PACKAGE` 資料表新增三筆資料，資料需求如下：
    -- 1. 名稱為 `7 堂組合包方案`，價格為`1,400` 元，堂數為`7`
    -- 2. 名稱為`14 堂組合包方案`，價格為`2,520` 元，堂數為`14`
    -- 3. 名稱為 `21 堂組合包方案`，價格為`4,800` 元，堂數為`21`
insert into "CREDIT_PACKAGE" (name,credit_amount, price) values
('7 堂組合包方案',7, 1400 ),
('14 堂組合包方案',14,2520  ),
('21 堂組合包方案', 21, 4800);
-- select * from "CREDIT_PACKAGE";
-- 2-2. 新增：在 `CREDIT_PURCHASE` 資料表，新增三筆資料：（請使用 name 欄位做子查詢）
    -- 1. `王小明` 購買 `14 堂組合包方案`
    -- 2. `王小明` 購買 `21 堂組合包方案`
    -- 3. `好野人` 購買 `14 堂組合包方案`

    
insert into "CREDIT_PURCHASE"
(purchased_credits,price_paid, user_id, credit_package_id)
values('14',2520, 
(select id from "USER" where name ='王小明'),
(select id from "CREDIT_PACKAGE" where credit_amount = 14));

insert into "CREDIT_PURCHASE"
(purchased_credits,price_paid, user_id, credit_package_id)
values
('21',4800, 
(select id from "USER" where name ='王小明'),
(select id from "CREDIT_PACKAGE" where credit_amount = 21));

insert into "CREDIT_PURCHASE"
(purchased_credits,price_paid, user_id, credit_package_id)
values
('14',2520, 
(select id from "USER" where name ='好野人'),
(select id from "CREDIT_PACKAGE" where credit_amount = 14));

SELECT "USER".name, "CREDIT_PACKAGE".name
FROM "CREDIT_PURCHASE"
INNER JOIN "USER"
ON "CREDIT_PURCHASE".user_id = "USER".id
inner JOIN "CREDIT_PACKAGE"
ON "CREDIT_PURCHASE".credit_package_id  = "CREDIT_PACKAGE".id;


-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================
-- 3. 教練資料 ，資料表為 COACH ,SKILL,COACH_LINK_SKILL
-- 3-1 新增：在`COACH`資料表新增三筆教練資料，資料需求如下：
    -- 1. 將用戶`李燕容`新增為教練，並且年資設定為2年（提示：使用`李燕容`的email ，取得 `李燕容` 的 `id` ）
    select email from "USER" where name = '李燕容';
    --獲取email
insert into "COACH" (user_id, experience_years)
values
((select id from "USER" where email =(select email from "USER" where name = '李燕容') ), 2);

--使用了雙重子查詢去新增id
select "USER".name, *  from "COACH" inner join "USER" on "COACH".user_id 
= "USER".id;
--確認是否新增

-- 2. 將用戶`肌肉棒子`新增為教練，並且年資設定為2年
-- 3. 將用戶`Q太郎`新增為教練，並且年資設定為2年
insert into "COACH" (user_id, experience_years)
select id, 2
from "USER"
WHERE name = '肌肉棒子' or name = 'Q太郎';

select *, "USER".name from "COACH" inner join "USER" on "COACH".user_id = "USER".id;
--查看是否有新增


-- 3-2. 新增：承1，為三名教練新增專長資料至 `COACH_LINK_SKILL` ，資料需求如下：
    -- 1. 所有教練都有 `重訓` 專長
    -- 2. 教練`肌肉棒子` 需要有 `瑜伽` 專長
    -- 3. 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長
--3-2-1
insert into "COACH_LINK_SKILL" (coach_id, skill_id) 
select "COACH".id, "SKILL".id from
"COACH","SKILL" where "SKILL".name = '重訓';
--新增資料
SELECT 
    "USER".name AS coach_name, 
    "SKILL".name AS skill_name
FROM 
    "COACH_LINK_SKILL"
INNER JOIN "COACH" ON "COACH_LINK_SKILL".coach_id = "COACH".id
INNER JOIN "USER" ON "COACH".user_id = "USER".id
INNER JOIN "SKILL" ON "COACH_LINK_SKILL".skill_id = "SKILL".id
ORDER BY coach_name, skill_name;
---查看
-- 3-2-2
 insert into "COACH_LINK_SKILL" (coach_id, skill_id) 
 select "COACH".id, "SKILL".id from
 "COACH"
 inner join "USER" on "COACH".user_id ="USER".id
  inner join "SKILL" on "SKILL".name = '瑜伽'
 where "USER".name = '肌肉棒子';
-- 3-2-3
insert into "COACH_LINK_SKILL" 
(coach_id, skill_id)
select "COACH".id, "SKILL".id 
from "COACH"
inner join "SKILL" on "SKILL".name in ('有氧運動', '復健訓練')
inner join "USER" on "COACH".user_id = "USER".id
where "USER".name = 'Q太郎';

-- 3-3 修改：更新教練的經驗年數，資料需求如下：
    -- 1. 教練`肌肉棒子` 的經驗年數為3年
    -- 2. 教練`Q太郎` 的經驗年數為5年
update "COACH"
set experience_years  = 3
from "USER"
where "USER".id = "COACH".user_id and "USER".email = 'muscle@hexschooltest.io';

SELECT * FROM "USER";
-- 查看email
UPDATE "COACH"
SET experience_years = 3
FROM "USER"
WHERE "COACH".user_id = "USER".id
  AND "USER".email = 'muscle@hexschooltest.io';

UPDATE "COACH"
SET experience_years = 5
FROM "USER"
WHERE "COACH".user_id = "USER".id
AND "USER".email = 'starplatinum@hexschooltest.io';

-- UPDATE無法使用INNER.JOIN(使用FROM)

select "USER".name, "COACH".experience_years from "COACH"
inner join "USER" on "COACH".user_id = "USER".id;
--查閱

-- 3-4 刪除：新增一個專長 空中瑜伽 至 SKILL 資料表，之後刪除此專長。
select * from "SKILL";
insert into "SKILL" (name) values ('空中瑜伽');
select * from "SKILL";
delete from "SKILL" where name = '空中瑜伽';
select * from "SKILL";


--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 
-- 4. 課程管理 COURSE 、組合包方案 CREDIT_PACKAGE

-- 4-1. 新增：在`COURSE` 新增一門課程，資料需求如下：
    -- 1. 教練設定為用戶`李燕容` 
    -- 2. 在課程專長 `skill_id` 上設定為「 `重訓` 」
    -- 3. 在課程名稱上，設定為「`重訓基礎課`」
    -- 4. 授課開始時間`start_at`設定為2024-11-25 14:00:00
    -- 5. 授課結束時間`end_at`設定為2024-11-25 16:00:00
    -- 6. 最大授課人數`max_participants` 設定為10
    -- 7. 授課連結設定`meeting_url`為 https://test-meeting.test.io
-- insert into "COURSE" (user_id, skill_id, name, start_at, end_at, max_participants, meeting_url)
-- select "USER".id, "SKILL".id ,'重訓基礎課', '2024-11-25 14:00:00', '2024-11-25 16:00:00', 10,'https://test-meeting.test.io' 
-- from "USER"
-- inner join "SKILL" on "SKILL".name = '重訓'
-- where "USER".name = '李燕容'


-- ████████  █████   █    █████ 
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █         █ 
--   █ █   █████ █   █    ████  
-- ===================== ====================

-- 5. 客戶預約與授課 COURSE_BOOKING
-- 5-1. 新增：請在 `COURSE_BOOKING` 新增兩筆資料：
    -- 1. 第一筆：`王小明`預約 `李燕容` 的課程
        -- 1. 預約人設為`王小明`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課
        
    -- insert into "COURSE_BOOKING" (user_id,course_id,booking_at,status)
	-- select "USER".id, "COURSE".id, '2024-11-24 17:10:25', '即將授課'
	-- from "USER"
	-- inner join "COURSE" on "COURSE".user_id = (select id from "USER" where name ='李燕容' )
	-- where "USER".name = '王小明';
    --寫入
-- select "USER".name, "COURSE".name from "COURSE_BOOKING"
-- inner join "USER" on "COURSE_BOOKING".user_id  = "USER".id
-- inner join "COURSE" on "COURSE_BOOKING".course_id = "COURSE".id

    --查詢

    -- 2. 新增： `好野人` 預約 `李燕容` 的課程
        -- 1. 預約人設為 `好野人`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課
--  insert into "COURSE_BOOKING" (user_id, course_id, booking_at, status)
--  select "USER".id, "COURSE".id, '2024-11-24 16:00:00', '即將授課'
--  FROM "USER"
--  inner join "COURSE" on "COURSE".user_id  = (select id from "USER" where name ='李燕容')
--  where "USER".name = '好野人'

-- 5-2. 修改：`王小明`取消預約 `李燕容` 的課程，請在`COURSE_BOOKING`更新該筆預約資料：
    -- 1. 取消預約時間`cancelled_at` 設為2024-11-24 17:00:00
    -- 2. 狀態`status` 設定為課程已取消

--     update "COURSE_BOOKING"
-- set 
-- cancelled_at  = '2024-11-24 17:00:00',
-- status ='課程已取消'
-- from "USER"
-- where "USER"."name"='王小明' and "COURSE_BOOKING".user_id ="USER".id

-- 5-3. 新增：`王小明`再次預約 `李燕容`   的課程，請在`COURSE_BOOKING`新增一筆資料：
    -- 1. 預約人設為`王小明`
    -- 2. 預約時間`booking_at` 設為2024-11-24 17:10:25
    -- 3. 狀態`status` 設定為即將授課
-- insert into "COURSE_BOOKING" (user_id, course_id, booking_at, status)
-- select "USER".id, "COURSE".id, '2024-11-24 17:10:25', '即將授課'
-- from "USER"
-- inner join "COURSE" on "COURSE".user_id = (select id from "USER" where name = '李燕容')
-- where "USER".name = '王小明';

--再度新增

-- select "USER".name, "COURSE".name, "COURSE_BOOKING".status from 
-- "COURSE_BOOKING"
-- inner join "USER" on "COURSE_BOOKING".user_id = "USER".id 
-- inner join "COURSE" on "COURSE_BOOKING".course_id ="COURSE".id

--查詢


-- 5-4. 查詢：取得王小明所有的預約紀錄，包含取消預約的紀錄
-- select "USER".name, "COURSE".name, "COURSE_BOOKING".status from 
-- "COURSE_BOOKING"
-- inner join "USER" on "COURSE_BOOKING".user_id = "USER".id 
-- inner join "COURSE" on "COURSE_BOOKING".course_id ="COURSE".id
-- where "COURSE_BOOKING".user_id =(select id from "USER" where name = '王小明')

-- 5-5. 修改：`王小明` 現在已經加入直播室了，請在`COURSE_BOOKING`更新該筆預約資料（請注意，不要更新到已經取消的紀錄）：
    -- 1. 請在該筆預約記錄他的加入直播室時間 `join_at` 設為2024-11-25 14:01:59
    -- 2. 狀態`status` 設定為上課中
--  update "COURSE_BOOKING"
--  set join_at = '2024-11-25 14:01:59',
--   "status" = '上課中'
--  from "USER"
--  where "COURSE_BOOKING".user_id = "USER".id 
--  and"USER".name = '王小明' 
--  and "COURSE_BOOKING".cancelled_at IS NULL

--FROM有連結的作用
--但是如果不再where篩選條件有做id連結他她就算指定name='王小明'也會更新到'好野人'

-- select "USER".name, "COURSE_BOOKING".status, "COURSE_BOOKING".join_at 
-- from "COURSE_BOOKING"
-- inner join "USER" on "COURSE_BOOKING".user_id = "USER".id
--確認一下

-- 5-6. 查詢：計算用戶王小明的購買堂數，顯示須包含以下欄位： user_id , total。 (需使用到 SUM 函式與 Group By)

-- select "USER".id, "USER".name, SUM("CREDIT_PURCHASE".purchased_credits) as total
-- from "CREDIT_PURCHASE" 
-- inner join "USER" on "CREDIT_PURCHASE".user_id ="USER".id
-- where "USER".email = 'wXlTq@hexschooltest.io'
-- group by user_id, "USER".name, "USER".id
--group by裡面一定要包含你選的東西

-- 5-7. 查詢：計算用戶王小明的已使用堂數，顯示須包含以下欄位： user_id , total。 (需使用到 Count 函式與 Group By)
-- select "USER".name, COUNT(*) from "COURSE_BOOKING" 
-- inner join "USER" on "COURSE_BOOKING".user_id ="USER".id
-- where "COURSE_BOOKING".status!='課程已取消' and "USER".name = '王小明'
-- group by "USER".name

-- 5-8. [挑戰題] 查詢：請在一次查詢中，計算用戶王小明的剩餘可用堂數，顯示須包含以下欄位： user_id , remaining_credit
    -- 提示：
    -- select ("CREDIT_PURCHASE".total_credit - "COURSE_BOOKING".used_credit) as remaining_credit, ...
    -- from ( 用戶王小明的購買堂數 ) as "CREDIT_PURCHASE"
    -- inner join ( 用戶王小明的已使用堂數) as "COURSE_BOOKING"
    -- on "COURSE_BOOKING".user_id = "CREDIT_PURCHASE".user_id;

select "USER".name, 
(SUM("CREDIT_PURCHASE".purchased_credits)-(select COUNT(*)
from "COURSE_BOOKING" 
where "COURSE_BOOKING".user_id = "USER".id and "COURSE_BOOKING".status!='課程已取消' and "USER".name = '王小明' ) )
as remaining_credit
from "USER"
inner join "CREDIT_PURCHASE" on "USER".id = "CREDIT_PURCHASE".user_id 
where "USER".name = '王小明'
group by "USER".id


-- ████████  █████   █     ███  
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █     █   █ 
--   █ █   █████ █   █     ███  
-- ===================== ====================
-- 6. 後台報表
-- 6-1 查詢：查詢專長為重訓的教練，並按經驗年數排序，由資深到資淺（需使用 inner join 與 order by 語法)
-- 顯示須包含以下欄位： 教練名稱 , 經驗年數, 專長名稱
-- select "USER".name as 教練名稱, "COACH".experience_years as 經驗年數, 
-- "SKILL".name as 專長名稱
-- from "USER"
-- inner join "COACH" on "USER".id = "COACH".user_id 
-- inner join "COACH_LINK_SKILL" on "COACH".id = "COACH_LINK_SKILL".coach_id 
-- inner join "SKILL" on "COACH_LINK_SKILL".skill_id ="SKILL".id
-- where "SKILL".name = '重訓'
-- order by experience_years desc

-- 6-2 查詢：查詢每種專長的教練數量，並只列出教練數量最多的專長（需使用 group by, inner join 與 order by 與 limit 語法）
-- 顯示須包含以下欄位： 專長名稱, coach_total
-- select "SKILL".name,COUNT("SKILL".name) as coach_total
-- from "COACH_LINK_SKILL"
-- inner join "SKILL" on "COACH_LINK_SKILL".skill_id  = "SKILL".id
-- group by "SKILL".name
-- order by "SKILL".name desc limit 1

-- 6-3. 查詢：計算 11 月份組合包方案的銷售數量
-- 顯示須包含以下欄位： 組合包方案名稱, 銷售數量
-- select (select "CREDIT_PACKAGE".name 
-- from "CREDIT_PACKAGE" where "CREDIT_PACKAGE".id = 
-- "CREDIT_PURCHASE".credit_package_id) as 方案名稱,
-- COUNT (*) as 數量
-- from "CREDIT_PURCHASE"
-- inner join "USER" on "CREDIT_PURCHASE".user_id ="USER".id
-- group by credit_package_id
-- 6-4. 查詢：計算 11 月份總營收（使用 purchase_at 欄位統計）
-- 顯示須包含以下欄位： 總營收
-- select SUM(price_paid) as 總營收 from "CREDIT_PURCHASE"
-- where purchase_at >='2024-11-01 00:00:00' 
-- and purchase_at <='2024-11-30 23:59:59'

-- 6-5. 查詢：計算 11 月份有預約課程的會員人數（需使用 Distinct，並用 created_at 和 status 欄位統計）
-- 顯示須包含以下欄位： 預約會員人數
-- select  COUNT(DISTINCT("USER".id)) as 預約會員人數 from "COURSE_BOOKING" 
-- inner join "USER" on "USER".id = "COURSE_BOOKING".user_id 
-- where 
-- booking_at >= '2024-11-01 00:00:00'
-- and booking_at <='2024-11-30 23:59:59' 

-- and "COURSE_BOOKING".status!= '課程已取消'

