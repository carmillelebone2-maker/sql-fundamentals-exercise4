--Exercise 4 (JOINS)

--Table 1 (users)
CREATE TABLE IF NOT EXISTS brightlearn.intelligence.users
(user_id INT, user_name STRING,city STRING);

INSERT INTO brightlearn.intelligence.users VALUES
(1, 'Nomvula', 'Johannesburg'),
(2, 'David', 'Cape Town'),
(3, 'Anele', 'Durban'),
(4, 'Kabelo', 'Pretoria'),
(5, 'Lerato', 'Port Elizabeth');

SELECT * FROM brightlearn.intelligence.users;

--Table 2 (plans)
CREATE TABLE IF NOT EXISTS brightlearn.intelligence.plans
(plan_id INT, plan_name STRING, monthly_price INT);

INSERT INTO brightlearn.intelligence.plans VALUES
(10, 'Basic', 79),
(11, 'Standard', 129),
(12, 'Premiun', 199),
(13, 'Family',249),
(14, 'Mobile', 59);

SELECT * FROM brightlearn.intelligence.plans;

--Table 3 (subscriptions)
CREATE TABLE IF NOT EXISTS brightlearn.intelligence.subscriptions
(subscription_id INT, user_id INT, plan_id INT, start_date DATE);

INSERT INTO brightlearn.intelligence.subscriptions VALUES
(501, 1, 10, '2026-01-15'),
(502, 2 , 11, '2026-02-01'),
(503, 1, 12, '2026-03-10'),
(504, 6 , 11, '2026-03-20'),
(505, 3, 13, '2026-04-05');

SELECT * FROM brightlearn.intelligence.subscriptions;

--Table 4 (shows)
CREATE TABLE IF NOT EXISTS brightlearn.intelligence.shows
(show_id INT, show_title STRING, genre STRING);

INSERT INTO brightlearn.intelligence.shows VALUES
(701, 'Comedy Hour', 'Comedy'),
(702, 'Crime Time', 'Drama'),
(703, 'Tech Tales', 'Documentary'),
(704, 'Cooking Lab','Lifestyle'),
(706, 'Wild Earth', 'Documentary');

SELECT * FROM brightlearn.intelligence.shows;

--Table 5 (viewing_sessions)
CREATE TABLE IF NOT EXISTS brightlearn.intelligence.viewing_sessions
(session_id INT, user_id INT, show_id INT, watch_minutes INT);

INSERT INTO brightlearn.intelligence.viewing_sessions VALUES
(901, 1, 701,45),
(902, 2, 703, 30),
(903, 1, 702, 60),
(904, 7,701, 20),
(905, 3, 705, 90);

SELECT * FROM brightlearn.intelligence.viewing_sessions;

--PART A - INNER JOIN

--Question 1: Show every user who has a subscription. Match users to subscriptions

SELECT users.user_id,
       user_name,
       subscription_id,
       start_date
FROM brightlearn.intelligence.users
INNER JOIN brightlearn.intelligence.subscriptions
ON subscriptions.user_id = users.user_id;

--Question 2: Show every subscription with its matching plan name and monthly price

SELECT subscription_id,
       user_id,
       plan_name,
       monthly_price
FROM brightlearn.intelligence.subscriptions
INNER JOIN brightlearn.intelligence.plans
ON subscriptions.plan_id = plans.plan_id;


--Question 3: Show every viewing session that has a matching show. Include the show title and genre

SELECT session_id,
       user_id
       show_title,
       genre,
       watch_minutes
FROM brightlearn.intelligence.viewing_sessions
INNER JOIN brightlearn.intelligence.shows
ON viewing_sessions.show_id = shows.show_id;

--Question 4: Show every viewing session with the user who watched it. Only show sessions with a matching user

SELECT user_name,
       city,
       session_id,
       show_id,
       watch_minutes
FROM brightlearn.intelligence.users
INNER JOIN brightlearn.intelligence.viewing_sessions
ON users.user_id = viewing_sessions.user_id;

--Question 5: Show users along with their subscriptions, the plan name, and the price. Use only users who have both a subscription and a valid plan

SELECT user_name,
       city,
       plan_name,
       monthly_price,
       start_date
FROM brightlearn.intelligence.users
INNER JOIN brightlearn.intelligence.subscriptions
ON users.user_id = subscriptions.user_id
INNER JOIN brightlearn.intelligence.plans
ON subscriptions.plan_id = plans.plan_id;

--PART B - LEFT JOIN
--Question 06: Show every user and any subscription they have. Users without subscriptions must still appear.

SELECT users.user_id,
       user_name,
       subscription_id,
       start_date
FROM brightlearn.intelligence.users
LEFT JOIN brightlearn.intelligence.subscriptions
ON users.user_id = subscriptions.user_id;

--Question 7: Show every plan and the subscriptions on it. Plans with no subscribers must still appear.
SELECT plans.plan_id,
       plan_name,
       subscription_id,
       user_id
FROM brightlearn.intelligence.plans
LEFT JOIN brightlearn.intelligence.subscriptions
ON plans.plan_id = subscriptions.subscription_id;

--Question 8: Show every show and any viewing sessions on it. Shows that were never watched must still appear

SELECT shows.show_id,
       show_title,
       session_id,
       watch_minutes
FROM brightlearn.intelligence.shows
LEFT JOIN brightlearn.intelligence.viewing_sessions
ON shows.show_id = viewing_sessions.show_id;

--Question 9: Show every viewing session and the user who watched it. Sessions referencing users that do not exist must still appear (with NULL user details)

SELECT viewing_sessions.session_id,
       show_id,
       watch_minutes,
       viewing_sessions.user_id,
       user_name
FROM brightlearn.intelligence.viewing_sessions
LEFT JOIN brightlearn.intelligence.users
ON viewing_sessions.user_id = users.user_id;


--Question 10: Show every user, the plan they are on (if any), and the monthly price. Users wiithout a subscription must still appear

SELECT user_name,
       city,
       plan_name,
       monthly_price
FROM brightlearn.intelligence.users
LEFT JOIN brightlearn.intelligence.subscriptions
ON users.user_id = subscriptions.user_id
LEFT JOIN brightlearn.intelligence.plans
ON subscriptions.plan_id = plans.plan_id;


--PART C (FULL OUTER JOIN)
--Question 11: Show every user and every subscription, including users without subscriptions AND subscriptions referencing users that do not exist

SELECT users.user_id,
       user_name,
       subscription_id,
       start_date
FROM brightlearn.intelligence.users
FULL OUTER JOIN brightlearn.intelligence.subscriptions
ON users.user_id = subscriptions.subscription_id;

--Question 12: Show every plan and every subscription, including plans without subscribers AND any subscription referencing a plan that does not exist

SELECT plans.plan_id,
       plan_name,
       subscription_id,
       user_id
FROM brightlearn.intelligence.plans
FULL OUTER JOIN brightlearn.intelligence.subscriptions
ON plans.plan_id = subscriptions.plan_id;

--Question 13: Show every show and every viewing session, inclduing shows that were never watched AND sessions referencing shows that do not exist
 SELECT shows.show_id,
       show_title,
       session_id,
       watch_minutes
FROM brightlearn.intelligence.shows
FULL OUTER JOIN brightlearn.intelligence.viewing_sessions
ON shows.show_id = viewing_sessions.show_id;


--Question 14: Show every user and every viewing session, including users with no sessions AND sessions referencing users who do not exist
 
 SELECT users.user_id,
        user_name,
        session_id,
        show_id,
        watch_minutes
FROM brightlearn.intelligence.users
FULL OUTER JOIN brightlearn.intelligence.viewing_sessions
ON users.user_id = viewing_sessions.user_id;


--Question 15: Show every user, every subscription and every plan in one query - using FULL OUTER JOIN throughout. This is the hardest question - get all gaps visible at once

SELECT users.user_id,
       user_name,
       subscription_id,
       plans.plan_id,
       plan_name
FROM brightlearn.intelligence.users
FULL OUTER JOIN brightlearn.intelligence.subscriptions
ON users.user_id = subscriptions.user_id
FULL OUTER JOIN brightlearn.intelligence.plans
ON subscriptions.plan_id = plans.plan_id;

--BONUS CHALLENGE
--Bonus 1: Which users have not subscribed to any plan

SELECT user_name
FROM brightlearn.intelligence.users
LEFT JOIN brightlearn.intelligence.subscriptions
ON users.user_id = subscriptions.user_id
WHERE subscription_id IS NULL;

--Bonus 2: Which subscriptions reference users that do not exist in the users table

SELECT subscription_id
FROM brightlearn.intelligence.subscriptions
LEFT JOIN brightlearn.intelligence.users
ON subscriptions.user_id = users.user_id
WHERE users.user_id IS NULL;

--Bonus 3: Which shows have never been watched

SELECT show_title,
       shows.show_id
FROM brightlearn.intelligence.shows
LEFT JOIN brightlearn.intelligence.viewing_sessions
ON shows.show_id = viewing_sessions.show_id
WHERE session_id IS NULL;

--Bonus 4: Which viewing sessions reference shows that do not exist

SELECT session_id,
       viewing_sessions.show_id
FROM brightlearn.intelligence.viewing_sessions
LEFT JOIN brightlearn.intelligence.shows
ON viewing_sessions.show_id = shows.show_id
WHERE shows.show_id IS NULL;

--Bonus 5: Which plans have no subscribers
SELECT plan_name,
       plans.plan_id
FROM brightlearn.intelligence.plans
LEFT JOIN brightlearn.intelligence.subscriptions
ON plans.plan_id = subscriptions.plan_id
WHERE subscription_id IS NULL;
