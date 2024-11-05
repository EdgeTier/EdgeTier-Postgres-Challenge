create table clients (
    client_id integer primary key generated always as identity,
    client text not null unique
);

create table languages (
    language_id integer primary key generated always as identity,
    language text not null unique
);

create table chats (
    chat_id integer generated always as identity,
    client_id integer references clients on delete cascade not null,
    language_id integer references languages on delete cascade not null,
    started_at timestamptz not null default now(),
    ended_at timestamptz,
    primary key (client_id, chat_id),
    constraint valid_start CHECK(started_at < ended_at)
) partition by list(client_id);

create table chats_dangerous_airlines partition of chats for values in (1);
create table chats_sketchy_car_rental partition of chats for values in (2);

create table tag_groups (
    tag_group_id integer primary key generated always as identity,
    client_id integer references clients on delete cascade,
    tag_group text not null unique
);

create table tags (
    tag_id integer primary key generated always as identity,
    tag_group_id integer references tag_groups on delete cascade,
    client_id integer references clients on delete cascade,
    tag text not null,
    unique (client_id, tag_group_id, tag)
);

create table chat_tags (
    chat_tag_id integer primary key generated always as identity,
    chat_id integer not null,
    client_id integer not null,
    tag_id integer references tags,
    constraint client_chat_foreign_key foreign key (client_id, chat_id) references chats(client_id, chat_id) on delete cascade
);

-- Fake clients.
insert into clients (client) values ('Dangerous Airlines'), ('Sketchy Car Rental');

insert into languages (language) values ('English'), ('Spanish'), ('French');

-- Fake tag groups.
insert into tag_groups (client_id, tag_group)
values
  (1, 'Contact Reason'),
  (1, 'Tier'),
  (2, 'Region'),
  (2, 'Disposition Code');

-- Fake tags.
insert into tags (client_id, tag_group_id, tag)
values

  -- Dangerous Airlines "Contact Reason".
  (1, 1, 'Complaints'),
  (1, 1, 'Sales'),
  (1, 1, 'Refunds'),
  (1, 1, 'Returns'),

  -- Dangerous Airlines "Tier".
  (1, 2, 'Premium'),
  (1, 2, 'Standard'),

  -- Sketchy Car Rental "Region".
  (2, 3, 'AMER'),
  (2, 3, 'APAC'),
  (2, 3, 'EMEA'),

  -- Sketchy Car Rental "Disposition Code".
  (2, 4, 'Complaints'),
  (2, 4, 'Claims'),
  (2, 4, 'Terms & Conditions'),
  (2, 4, 'Mechanical'),
  (2, 4, 'Other');

  -- Fake chats.
  insert into chats (client_id, language_id, started_at, ended_at)
  values
    (1, 1, now() - '24 hours'::interval, now() - '23.1 hours'::interval),
    (1, 1, now() - '22 hours'::interval, now() - '21.4 hours'::interval),
    (1, 1, now() - '18 hours'::interval, now() - '17.4 hours'::interval),
    (1, 1, now() - '16 hours'::interval, now() - '15.2 hours'::interval),
    (1, 2, now() - '15 hours'::interval, now() - '14.9 hours'::interval),
    (1, 1, now() - '15 hours'::interval, now() - '14.4 hours'::interval),
    (1, 1, now() - '14 hours'::interval, now() - '13.2 hours'::interval),
    (1, 1, now() - '13 hours'::interval, now() - '11.8 hours'::interval),
    (1, 1, now() - '12 hours'::interval, now() - '9.9 hours'::interval),
    (1, 1, now() - '7 hours'::interval, now() - '2.3 hours'::interval),
    (1, 1, now() - '3 hours'::interval, now() - '1.3 hours'::interval),
    (1, 2, now() - '2 hours'::interval, now() - '0.3 hours'::interval),
    (1, 3, now() - '1 hours'::interval, now() - '5 minutes'::interval),
    (1, 1, now() - '1 hours'::interval, null),
    (1, 2, now() - '30 minutes'::interval, null),
    (1, 1, now() - '5 minutes'::interval, null),
    (2, 3, now() - '20 hours'::interval, now() - '19 hours'::interval),
    (2, 3, now() - '12 hours'::interval, now() - '11.4 hours'::interval),
    (2, 1, now() - '7 hours'::interval, now() - '6.3 hours'::interval),
    (2, 3, now() - '2 hours'::interval, null);

insert into chat_tags (chat_id, client_id, tag_id)
values

    -- Dangerous Airlines "Contact Reason".
    (1, 1, 1),
    (2, 1, 1),
    (3, 1, 3),
    (4, 1, 4),
    (5, 1, 1),
    (6, 1, 4),
    (7, 1, 2),
    (8, 1, 3),
    (9, 1, 1),
    (10, 1, 4),
    (11, 1, 1),
    (12, 1, 2),
    (13, 1, 3),
    (14, 1, 3),
    (15, 1, 1),
    (16, 1, 2),

    -- Dangerous Airlines "Tier".
    (1, 1, 5),
    (2, 1, 6),
    (3, 1, 6),
    (4, 1, 6),
    (5, 1, 5),
    (6, 1, 5),
    (7, 1, 6),
    (8, 1, 5),
    (9, 1, 6),
    (10, 1, 6),
    (11, 1, 6),
    (12, 1, 6),
    (13, 1, 6),
    (14, 1, 5),
    (15, 1, 6),
    (16, 1, 6),

    -- Sketchy Car Rental "Region".
    (17, 2, 8),
    (18, 2, 8),
    (19, 2, 9),
    (20, 2, 7)
;