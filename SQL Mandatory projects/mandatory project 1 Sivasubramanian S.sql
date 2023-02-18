use moviedb;

show tables;

select * from actors;

select * from director;

select * from genres;

select * from movie;

select * from movie_cast;

select * from movie_direction;

select * from movie_genres;

select * from rating;

select * from reviewer;


/* 1. Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role. */

/* Solution */

select * from actors;

select * from movie;

select * from movie_cast;


select a.act_fname, a.act_lname, mo.role
from actors as a join movie_cast as mo
on a.act_id = mo.act_id
join movie as m 
on mo.mov_id = m.mov_id
where mov_title = 'Annie Hall';


/* 2. From the following tables, write sql query to find the director who directed a movie 'eyes wide shut' return director firstname, lastname and movietitle */

/* Solution */

select * from director;

select * from movie;

select * from movie_direction;

SELECT d.dir_fname, d.dir_lname, m.mov_title
from movie as m natural join director as d
natural join movie_direction 
where mov_title = 'eyes wide shut';

/* 3. write sql query to find who directed a movie that casted a role as 'sean maguire'. return director firstname, lastname, and movietitle */

select * from movie_cast;

select * from director;

select * from movie_direction;

select * from movie;

/* Solution */

select d.dir_fname, d.dir_lname, m.mov_title 
from director as d join movie_direction as md
on d.dir_id = md.dir_id
join movie as m 
on m.mov_id = md.mov_id
join movie_cast as mc
on mc.mov_id = m.mov_id
where mc.role = 'sean maguire';

/* 4. Write sql query to find actors who have not acted in any movie between 1990 and 2000. return actor firstname, lastname, movietitle and release year */

select * from actors;

select * from movie;

select * from movie_cast;

/* Solution */

select a.act_fname, a.act_lname, m.mov_title, m.mov_year
from actors as a join movie_cast as mc
on a.act_id = mc.act_id
join movie as m
on m.mov_id = mc.mov_id
where m.mov_year not between 1990 and 2000;

/* 5. write sql query to find directors with number of genres of movies. group the result set on director firstname, lastname, and generic title. sort the result set in 
      ascending order by director firstname, and lastname. return director firstname, lastname and number of genres of movies */
      
select * from director;

select * from genres;

select * from movie_genres;

select * from movie_direction;

/* solution */

select d.dir_fname, d.dir_lname, count(gen_title) as count_genres, g.gen_title
from director as d natural join movie_direction as md
natural join genres as g
natural join movie_genres
group by d.dir_fname, d.dir_lname, gen_title
order by d.dir_fname, d.dir_lname;