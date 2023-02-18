use ig_clone;

show tables;

select * from comments;

select * from follows;

select * from likes;

select * from photo_tags;

select * from photos;

select * from tags;

select * from users;


-- 1. we want to reward the user who has been around the longest, find the 5 oldest user
-- Solution

select * from users;

select * from users
order by created_at desc
limit 5;


-- 2. to understand when to run ad campaign, figure out day of the week most users register on
-- Solution


select * from users;

select dayname(created_at) as 'dayofweek', count(id) as 'register'   -- using dayname() date func we can extract name of the day from a particular date
from users
group by dayofweek;

-- alternate solution

select date_format(created_at, '%W') as 'dayofweek', count(id) as 'register' -- using date_format() date func also we can extract name of the day from a particular date
from users
group by dayofweek;

-- alternate solution

set lc_time_names = 'en_US'; -- using lc_time_names we can change language of the days for example german, french, english (USA)
select dayname(created_at) as 'dayofweek', count(id) as 'register' 
from users
group by dayofweek;


-- 3. to target inactive users in an email id campaign, find the users who have never posted a photo
-- Solution

show tables;

select * from users;

select * from photos;

select u.username, p.image_url from users as u
left join photos as p
on u.id = p.user_id
where p.id is null;

-- alternate solution using subquery
 
select username from 
users where id not in (select user_id from photos);

 
-- 4. suppose you are running on a contest to find out who got most likes on a photo. find out who won.
-- Solution

select * from users;

select * from likes;

select * from photos;


select u.username, p.image_url, count(*) as 'most_likes'
from likes as l
join photos as p
on l.user_id = p.user_id
join users as u
on u.id = p.id
group by u.id
order by most_likes desc;

-- alternate solution without joining condition

select u.username, p.image_url, count(*) as 'most_likes'
from likes as l, photos as p, users as u
where l.user_id = p.user_id
and u.id = p.id
group by u.id
order by most_likes desc;


-- 5. the investors want to know how many times does the average users post
-- Solution

select * from users;

select * from photos;


select round(avg(photo_count), 1) as avg_post_count
from (select users.id, username, count(*) as photo_count
from users join photos
on users.id = photos.user_id
group by username
order by users.id) as photo_count_1; 


-- 6. a brand wants to know which hashtag to use on a post and find the top 5 most used hashtags
-- Solution

select * from tags;

select * from photo_tags;

select t.tag_name, count(*) as 'total_tags'
from tags as t 
join photo_tags
on t.id = photo_tags.tag_id
group by tag_id
order by total_tags desc
limit 5;

-- alternate solution using CTE

with tags_names as 
(select t.tag_name, count(*) as 'total_tags'
from tags as t 
join photo_tags
on t.id = photo_tags.tag_id
group by tag_id
order by total_tags desc
limit 5)
select * from tags_names;


-- 7. To find out if there are bots, find users who have liked every single photos
-- Solution

select * from users;

select * from likes;

select u.username, count(*) as 'liked'
from users as u
join likes as l
on l.user_id = u.id
group by u.id
having liked = 
( select count(*)
from photos);


-- 8. To know who the celebrities are, find the users who have never commented on a photo
-- Solution

select * from users;

select * from comments;

select u.username, c.comment_text
from users as u
left join comments as c
on c.user_id = u.id
where c.id is null;

-- alternate solution using subquery

select username from 
users where id not in (select user_id from comments);

 
 -- 9. now its time to find both of them together find the users who have never commented on any photo or have commented on every photo
-- Solution

select * from users;

select * from comments;

select u.username, c.comment_text
from users as u
right join comments as c
on c.user_id = u.id
where c.id is null or c.id is not null
group by u.id;

-- alternate solution using UNION

select u.username, c.comment_text
from users as u
right join comments as c
on c.user_id = u.id
where c.id is null
union
select u.username, c.comment_text
from users as u
right join comments as c
on c.user_id = u.id
where c.id is not null
group by u.id;