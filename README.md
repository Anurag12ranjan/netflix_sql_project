# Netflix Movies and Tv shows Data Analysis using sql

Netflix SQL Project

Project Overview
This project analyzes Netflix's content catalog using SQL. It includes data extraction, transformation, and answering business-related questions to gain insights into Netflix's movie and TV show distribution.

Dataset
The dataset consists of a table named netflix, which includes details about shows, such as:
show_id: Unique identifier
type: Movie or TV Show
title: Name of the content
director: Director(s)
casts: Cast members
country: Country of production
date_added: Date added to Netflix
release_year: Year of release
rating: Content rating
duration: Length of the content
listed_in: Genre categories
description: Short summary

 Business Problems Addressed
The project solves 15 business problems, including:
Counting the number of movies vs. TV shows.
Identifying the most common rating.
Listing movies released in a specific year.
Finding the top 5 countries with the most content.
Analyzing the most popular genres.
Determining the trend of content added over time.
Identifying the top directors by content count.
Analyzing content distribution by country.
Filtering TV Shows with multiple seasons.
Finding the oldest movies available.
Grouping content by release year.
Identifying directors with the most hits.
Analyzing Netflix's rating distribution.
Filtering content with specific keywords in descriptions.
Finding the most frequent actors in Netflix content.

 SQL Queries
The project contains various SQL queries to extract insights, such as:

-- Count movies vs. TV shows
SELECT type, COUNT(*) AS total_content
FROM netflix
GROUP BY type;

-- Find the most common rating for movies and TV shows
SELECT type, rating FROM (
    SELECT type, rating, COUNT(*),
    RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix
    GROUP BY type, rating
) WHERE ranking = 1;

-- List movies released in a specific year
SELECT title FROM netflix WHERE type = 'Movie' AND release_year = 2020;

 Tools Used
PostgreSQL / MySQL (for querying the dataset)
SQL Window Functions, Aggregations, and String Manipulations
Data Cleaning Techniques

How to Use
Load the dataset into an SQL database.
Run the SQL queries to explore the data.
Modify the queries to extract further insights.

 Insights & Findings
Movies dominate Netflix's catalog compared to TV shows.
The most common rating varies by content type.
Content production and additions follow noticeable trends.
