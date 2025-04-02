-- Netflix Project

CREATE TABLE netflix 
(
    show_id varchar(6),
    type varchar(10),
    title varchar(150),
    director varchar(208),
    casts varchar(1000),
    country varchar(150),
    date_added varchar(50),
    release_year int,
    rating varchar(10),
    duration varchar(15),
    listed_in varchar(105),
    description varchar(250)
);
select * from netflix;

-- 15 Business Problem

-- 1. count the number of movies vs tv shows
select 
    type,
    count(*) as total_content 
from netflix 
group by type;

--2  find the most common rating for movies and tv shows
select 
    type,
	rating 
from(
select 
    type, 
	rating,
	count(*),
	rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by 1,2)
where ranking = 1;

--3 list all movies released in a specific year (e.g., 2020)
select
    type,
	title
from netflix
where type = 'Movie' and release_year = 2020;

--4 Find the top 5 countries wth the most content on netflix
select 
   unnest(string_to_array(country, ',')) as new_country,
	count(show_id) as total_content
from netflix
group by country
order by total_content desc
limit 5;

--5 identify the longest movie
select 
   *
from netflix
where type = 'Movie'
and duration = (select max(duration) from netflix);

--6 Find the content added in the last 5 years
select * 
from netflix
where 
   to_date(date_added, 'Month DD, YYYY') >= current_date - interval '5 years'

--7 Find the movies/tv shows by director 'Rajiv Chilaka'
select * from netflix
where director ilike '%Rajiv Chilaka%';

--8 List all tv shows with more than 5 seasons
select 
    *
from netflix
where 
    type = 'TV Show'
	and 
	split_part(duration,' ',1)::numeric > 5;

--9 count the number of content items in each genre
select 
	unnest(string_to_array(listed_in,',')) as genre,
	count(show_id) as total_content
from netflix
group by 1;

--10 Find each year and the average numbers of content release by india on netflix.
-- return top 5 year with highest avg content release
select
     extract(year from to_date(date_added, 'Month DD,YYYY')) as year,
	 count(*) as yearly_content,
	 Round(count(*)::numeric/(select count(*) from netflix where country='India')
	 ::numeric * 100,2) as avg_content_per_year
from netflix
where country = 'India'
group by 1;

--11 list all movies that are documentaries
select * 
from netflix
where listed_in ilike '%Documentaries%'

--12 Find all the content without the director
select *
from netflix
where director is null;

--13 Find how many movie actor 'salman khan' appeared in the last 10 years
select *
from netflix
where 
    casts ilike '%salman khan%'
    and 
	release_year > extract(year from current_date) - 10;

--14 Find the top 10 actors who have appeared in the highest number of movies produced in india
select 
     unnest(string_to_array(casts, ',')) as actors,
	 count(*) as total_content
from netflix
where country ilike '%India%'
group by 1
order by 2 desc
limit 10;

-- 15 categorize the content based on the prefrence of the keywords 'kill' and 'violence' in 
-- the description field. label content containing these keywords as 'Bad' and all other content as 
-- 'good'. count how many items fall into each category
with new_table as 
(
select 
*,
     case
	 when description ilike '%kill%' or 
	      description ilike '%violence%' then 'Bad_content'
		  else 'Good_content'
	end category
from netflix
)
select 
     category,
	 count(*) as total_content
from new_table
group by 1;
