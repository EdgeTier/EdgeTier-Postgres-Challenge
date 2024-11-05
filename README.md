# EdgeTier Postgres Challenge

**Note:** Please do not put your solution in a public repository (GitHub etc.). We are sending this to multiple candidates and do not want anyone to have an unfair advantage.

This task should hopefully take only 1–2 hours to complete.

# Introduction

At EdgeTier, we build products for the customer support industry. This involves storing chats, calls, and emails and related data. This task contains a tiny subset of the type of data we typically store.

# Setup

A sample database, including data, has been provided in `data.sql`. You can either copy/paste it into an editor to work on a local Postgres database, use `pg_restore`, or just use something like [DB Fiddle](https://www.db-fiddle.com/)/[SQL Fiddle](https://sqlfiddle.com/postgresql/online-compiler) (we really don't mind which). The data was generated with Postgres 17 but should be compatible with older versions.

# Task

Please write the five requested queries below without changing the schema of the database:

1. Count chats per client (columns: `client`, `chat_count`).
2. Find the oldest chat (by `started_at`) with at least two tags (columns: `chat_id`, `started_at`, `tag_count`).
3. Show the three most recent chats (by `started_at`) for client "Dangerous Airlines" that have the "Premium" tag (columns: `chats.*`).
4. Show the top three longest chats and how much their duration differs from the client's average chat duration (columns: `client`, `chat_id`, `duration`, `duration_from_average`).
5. For "Dangerous Airlines", count the number of "Premium" chats that are "Complaints" OR "Returns", and also what percentage of them are in English (columns: `chat_count`, `percentage_english`).

# Submission

Please create a private GitHub repository with your solution and send invites to Ciarán (https://github.com/ciarantobin) and Guillem (https://github.com/g-abello-edgetier). Inside `/solution` you can see where to put your answers.

# Data

## `clients`

Names and IDs of all our clients.

| client_id | client             |
| :-------- | :----------------- |
| 1         | Dangerous Airlines |
| 2         | Sketchy Car Rental |

## `tags`

Categorical data that can be associated with a chat.

| tag_id | tag_group_id | client_id | tag                |
| :----- | :----------- | :-------- | :----------------- |
| 1      | 1            | 1         | Complaints         |
| 2      | 1            | 1         | Sales              |
| 3      | 1            | 1         | Refunds            |
| 4      | 1            | 1         | Returns            |
| 5      | 2            | 1         | Premium            |
| 6      | 2            | 1         | Standard           |
| 7      | 3            | 2         | AMER               |
| 8      | 3            | 2         | APAC               |
| 9      | 3            | 2         | EMEA               |
| 10     | 4            | 2         | Complaints         |
| 11     | 4            | 2         | Claims             |
| 12     | 4            | 2         | Terms & Conditions |
| 13     | 4            | 2         | Mechanical         |
| 14     | 4            | 2         | Other              |

## `tag_groups`

Categories for the tags.

| tag_group_id | client_id | tag_group        |
| :----------- | :-------- | :--------------- |
| 1            | 1         | Contact Reason   |
| 2            | 1         | Region           |
| 3            | 2         | Queue            |
| 4            | 2         | Tier             |
| 5            | 2         | Disposition Code |

## `chats`

Active and previous chats.

| chat\_id | client\_id | language\_id | started\_at | ended\_at |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 1 | 1 | 2024-11-06 09:13:43.070946 +00:00 | 2024-11-06 10:07:43.070946 +00:00 |
| 2 | 1 | 1 | 2024-11-06 11:13:43.070946 +00:00 | 2024-11-06 11:49:43.070946 +00:00 |
| 3 | 1 | 1 | 2024-11-06 15:13:43.070946 +00:00 | 2024-11-06 15:49:43.070946 +00:00 |
| 4 | 1 | 1 | 2024-11-06 17:13:43.070946 +00:00 | 2024-11-06 18:01:43.070946 +00:00 |
| 5 | 1 | 2 | 2024-11-06 18:13:43.070946 +00:00 | 2024-11-06 18:19:43.070946 +00:00 |

(first 5 rows)

## `chat_tags`

Mapping table between chats and tags.

| chat_tag_id | chat_id | client_id | tag_id |
| :---------- | :------ | :-------- | :----- |
| 1           | 1       | 1         | 1      |
| 2           | 2       | 1         | 1      |
| 3           | 3       | 1         | 3      |
| 4           | 4       | 1         | 4      |
| 5           | 5       | 1         | 1      |

(first 5 rows)

## `languages`

Language of a chat. 

| language\_id | language |
| :--- | :--- |
| 1 | English |
| 2 | Spanish |
| 3 | French |

