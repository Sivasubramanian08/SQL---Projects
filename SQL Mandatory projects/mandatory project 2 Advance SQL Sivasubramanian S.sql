use ig_clone;

SHOW TABLES;

select * from comments;

select * from follows;

select * from likes;

select * from photo_tags;

select * from photos;

select * from tags;

select * from users;

/* 2. we want to reward the user who has been around the longest. find the 5 oldest user */

/* Solution */

select * from users;

select * from users
order by created_at
limit 5;


/* 3. To understand when to run campaign, figure out day of the week most users register on */

/* Solution */

select * from users;

select dayname(created_at) as 'dayweek', count(*) as 'register'
from users
group by dayweek;


/* 4. To target inactive users in an email ad campaign, find the users who have never posted photo */

/* Solution */

select * from users;

select * from photos;

select u.username from users as u
left join photos as p
on u.id=p.user_id
where p.id is null;


/* 5. Suppose you are running a contest to find out who got most likes on a photo. find out who won */

/* Solution */

select * from users;

select * from photos;

select * from likes;

select u.username, p.image_url, count(*) as 'most_likes'
from likes as l
right join photos as p
on p.id = l.photo_id
right join users as u
on u.id = l.photo_id
group by p.id
order by most_likes desc;


/* 6. The investors want to know how many times does the average user post */

/* Solution */

select * from users;

select count(*) from users;

select * from photos;

select count(*) from photos;

select round((select count(*) from photos) / (select count(*) from users), 1) as average;

/* 7. A brand wants to know which hashtag to use on a post and find top 5 most used hashtags */

/* Solution */

select * from photo_tags;

select * from tags;

select t.id, t.tag_name, count(*) as 'total_tags'
from tags as t
join photo_tags
on t.id = photo_tags.tag_id
group by tag_id
order by total_tags desc
limit 5;


/* 8. to find out if there are bots, find users who have liked every single photo of the site */

/* Solution */

select * from users;

select * from likes;

select u.username, count(*) as 'user_likes' 
from users as u 
join likes as l
on u.id = l.user_id
group by u.id
having user_likes = (
select count(*) 
from photos);

/* 9. To know who the celebrities are, find users who have never commented on a photo */

/* Solution */

select * from users;

select * from comments;

select u.username
from users as u
left join comments as c
on u.id = c.user_id
where c.id is null
group by u.id;


/* 10. now its time to find both of them together, find the users who have never commented on any photo or have commented on every photo */

/* Solution */

select * from users;

select * from comments;

select u.username, c.comment_text
from users as u
right join comments as c
on u.id = c.user_id
where c.id is null or c.id is not null
group by u.id;