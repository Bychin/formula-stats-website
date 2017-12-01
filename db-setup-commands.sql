create table formula_stats_team (
    name varchar(16) primary key,
    color_code varchar(10),
    photo varchar(100)
);

create table formula_stats_driver (
    driver_number int primary key,
    name varchar(30) unique,
    photo varchar(100)
);

create table formula_stats_track (
    name varchar(50),
    laps_number int,
    lap_record interval null,
    primary key(track),
    unique(track, driver)
);

create table formula_stats_race (
    id int primary key, --primary key(track, driver),
    laps int,
    race_time interval null,
    driver int references formula_stats_driver,
    team varchar(16) references formula_stats_team,
    track varchar(50) references formula_stats_track,
    unique(track, driver) -- remove
);

-- List track, time. driver's id and place for all race's podium places
create view formula_stats_podiums as (
    with
    GetPlaces as (
        select *, row_number() over (partition by track_id order by time asc)
            as row_id from formula_stats_race
    ),
    GetPodium as (
        select * from GetPlaces
        where row_id < 4
        order by time asc
    )
    select 
        row_number() over (order by track_id, row_id) as id,
        track_id, time, driver_id, row_id as place from GetPodium
);

create view formula_stats_driver_podiums as (
    with
    GetPlaces as (
        select *, row_number() over (partition by track_id order by time asc)
            as row_id from formula_stats_race
    ),
    GetPodium as (
        select * from GetPlaces
        where row_id < 4
        order by time asc
    )
    select driver_id, driver.name, count(1) as podiums from GetPodium
    join formula_stats_driver driver on driver_id = driver.driver_number -- driver.number 
    group by driver_id, driver.name
    order by podiums desc
);

create view formula_stats_team_podiums as (
    with
    GetPlaces as (
        select *, row_number() over (partition by track_id order by time asc)
            as row_id from formula_stats_race
    ),
    GetPodium as (
        select * from GetPlaces
        where row_id < 4
        order by time asc
    )
    select team_id, count(1) as podiums from GetPodium
    group by team_id
    order by podiums desc
);


insert into formula_stats_team values ('Mercedes',        '#00cfba', 'teams/MercedesTeam.jpg');
insert into formula_stats_team values ('Ferrari',         '#c30000', 'teams/FerrariTeam.jpg');
insert into formula_stats_team values ('Red Bull Racing', '#00007D', 'teams/RedBullTeam.jpg');
insert into formula_stats_team values ('Force India',     '#ff80c7', 'teams/ForceIndiaTeam.jpg');
insert into formula_stats_team values ('Williams',        '#FFFFFF', 'teams/WilliamsTeam.jpg');
insert into formula_stats_team values ('Toro Rosso',      '#0000FF', 'teams/ToroRossoTeam.jpg');
insert into formula_stats_team values ('Renault',         '#FFD800', 'teams/RenaultTeam.jpg');
insert into formula_stats_team values ('Haas',            '#6C0000', 'teams/HaasTeam.jpg');
insert into formula_stats_team values ('McLaren',         '#ff7b08', 'teams/McLarenTeam.jpg');
insert into formula_stats_team values ('Sauber',          '#006EFF', 'teams/SauberTeam.jpg');

insert into formula_stats_driver values ('Lewis Hamilton',     44, 'drivers/LewisHamilton.jpg'); --,    'Mercedes');
insert into formula_stats_driver values ('Valtteri Bottas',    77, 'drivers/ValtteriBottas.jpg'); --,   'Mercedes');
insert into formula_stats_driver values ('Sebastian Vettel',    5, 'drivers/SebastianVettel.jpg'); --,  'Ferrari');
insert into formula_stats_driver values ('Kimi Raikkonen',      7, 'drivers/KimiRaikkonen.jpg'); --,    'Ferrari');
insert into formula_stats_driver values ('Daniel Ricciardo',    3, 'drivers/DanielRicciardo.jpg'); --,  'Red Bull Racing');
insert into formula_stats_driver values ('Max Verstappen',     33, 'drivers/MaxVerstappen.jpg'); --,    'Red Bull Racing');
insert into formula_stats_driver values ('Sergio Perez',       11, 'drivers/SergioPerez.jpg'); --,      'Force India');
insert into formula_stats_driver values ('Esteban Ocon',       31, 'drivers/EstebanOcon.jpg'); --,      'Force India');
insert into formula_stats_driver values ('Felipe Massa',       19, 'drivers/FelipeMassa.jpg'); --,      'Williams');
insert into formula_stats_driver values ('Lance Stroll',       18, 'drivers/LanceStroll.jpg'); --,      'Williams');
insert into formula_stats_driver values ('Pierre Gasly',       10, 'drivers/PierreGasly.jpg'); --,      'Toro Rosso');
insert into formula_stats_driver values ('Brendon Hartley',    28, 'drivers/BrendonHartley.jpg'); --,   'Toro Rosso');
insert into formula_stats_driver values ('Nico Hulkenberg',    27, 'drivers/NicoHulkenberg.jpg'); --,   'Renault');
insert into formula_stats_driver values ('Carlos Sainz',       55, 'drivers/CarlosSainz.jpg'); --,      'Renault');
insert into formula_stats_driver values ('Romain Grosjean',     8, 'drivers/RomainGrosjean.jpg'); --,   'Haas');
insert into formula_stats_driver values ('Kevin Magnussen',    20, 'drivers/KevinMagnussen.jpg'); --,   'Haas');
insert into formula_stats_driver values ('Fernando Alonso',    14, 'drivers/FernandoAlonso.jpg'); --,   'McLaren');
insert into formula_stats_driver values ('Stoffel Vandoorne',   2, 'drivers/StoffelVandoorne.jpg'); --, 'McLaren');
insert into formula_stats_driver values ('Pascal Wehrlein',    94, 'drivers/PascalWehrlein.jpg'); --,   'Sauber');
insert into formula_stats_driver values ('Marcus Ericsson',     9, 'drivers/MarcusEricsson.jpg'); --,   'Sauber');
insert into formula_stats_driver values ('Jolyon Palmer',      30, 'drivers/JolyonPalmer.jpg'); --, 'Renault');
insert into formula_stats_driver values ('Daniil Kvyat',       26, 'drivers/DaniilKvyat.jpg'); --, 'Toro Rosso');
insert into formula_stats_driver values ('Antonio Giovinazzi', 50, 'drivers/AntonioGiovinazzi.jpg'); --, 'Haas');
insert into formula_stats_driver values ('Jenson Button',      22, 'drivers/JensonButton.jpg'); --, 'McLaren');

insert into formula_stats_track values ('Melbourne Circut',              58);
insert into formula_stats_track values ('Shanghai International Circut', 56);
insert into formula_stats_track values ('Bahrain International Circut',  57);
insert into formula_stats_track values ('Sochi Autodrom',                53);
insert into formula_stats_track values ('Circut de Barcelona-Catalunya', 66);
insert into formula_stats_track values ('Circut de Monaco',              78);

insert into formula_stats_event values ('Australian Grand Prix', '2017-03-26', 'events/AustralianGP.jpg', 'Melbourne Circut');
insert into formula_stats_event values ('Chinese Grand Prix',    '2017-04-09', 'events/ChineseGP.jpg',    'Shanghai International Circut');
insert into formula_stats_event values ('Bahrain Grand Prix',    '2017-04-16', 'events/BahrainGP.jpg',    'Bahrain International Circut');
insert into formula_stats_event values ('Russian Grand Prix',    '2017-04-30', 'events/RussianGP.jpg',    'Sochi Autodrom');
insert into formula_stats_event values ('Spanish Grand Prix',    '2017-05-14', 'events/SpanishGP.jpg',    'Circut de Barcelona-Catalunya');
insert into formula_stats_event values ('Monaco Grand Prix',     '2017-05-28', 'events/MonacoGP.jpg',     'Circut de Monaco');

insert into formula_stats_race values (0,   57, '01:24:11.672',  5, 'Australian Grand Prix', 'Ferrari');
insert into formula_stats_race values (1,   57, '01:24:21.647', 44, 'Australian Grand Prix', 'Mercedes');
insert into formula_stats_race values (2,   57, '01:24:22.922', 77, 'Australian Grand Prix', 'Mercedes');
insert into formula_stats_race values (3,   57, '01:24:34.065',  7, 'Australian Grand Prix', 'Ferrari');
insert into formula_stats_race values (4,   57, '01:24:40.499', 33, 'Australian Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (5,   57, '01:25:35.058', 19, 'Australian Grand Prix', 'Williams');
insert into formula_stats_race values (6,   56, null,           11, 'Australian Grand Prix', 'Force India');
insert into formula_stats_race values (7,   56, null,           55, 'Australian Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (8,   56, null,           26, 'Australian Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (9,   56, null,           31, 'Australian Grand Prix', 'Force India');
insert into formula_stats_race values (10,  56, null,           27, 'Australian Grand Prix', 'Renault');
insert into formula_stats_race values (11,  55, null,           50, 'Australian Grand Prix', 'Sauber');
insert into formula_stats_race values (12,  55, null,            2, 'Australian Grand Prix', 'McLaren');
insert into formula_stats_race values (13,  50, null,           14, 'Australian Grand Prix', 'McLaren');
insert into formula_stats_race values (14,  46, null,           20, 'Australian Grand Prix', 'Haas');
insert into formula_stats_race values (15,  40, null,           18, 'Australian Grand Prix', 'Williams');
insert into formula_stats_race values (16,  25, null,            3, 'Australian Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (17,  21, null,            9, 'Australian Grand Prix', 'Sauber');
insert into formula_stats_race values (18,  15, null,           30, 'Australian Grand Prix', 'Renault');
insert into formula_stats_race values (19,  13, null,            8, 'Australian Grand Prix', 'Haas');
 
insert into formula_stats_race values (20,  56, '01:37:36.158', 44, 'Chinese Grand Prix', 'Mercedes');
insert into formula_stats_race values (21,  56, '01:37:42.408',  5, 'Chinese Grand Prix', 'Ferrari');
insert into formula_stats_race values (22,  56, '01:38:21.350', 33, 'Chinese Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (23,  56, '01:38:22.193',  3, 'Chinese Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (24,  56, '01:38:24.234',  7, 'Chinese Grand Prix', 'Ferrari');
insert into formula_stats_race values (25,  56, '01:38:24.966', 77, 'Chinese Grand Prix', 'Mercedes');
insert into formula_stats_race values (26,  56, '01:38:49.051', 55, 'Chinese Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (27,  55, null,           20, 'Chinese Grand Prix', 'Haas');
insert into formula_stats_race values (28,  55, null,           11, 'Chinese Grand Prix', 'Force India');
insert into formula_stats_race values (29,  55, null,           31, 'Chinese Grand Prix', 'Force India');
insert into formula_stats_race values (30,  55, null,            8, 'Chinese Grand Prix', 'Haas');
insert into formula_stats_race values (31,  55, null,           27, 'Chinese Grand Prix', 'Renault');
insert into formula_stats_race values (32,  55, null,           30, 'Chinese Grand Prix', 'Renault');
insert into formula_stats_race values (33,  55, null,           19, 'Chinese Grand Prix', 'Williams');
insert into formula_stats_race values (34,  55, null,            9, 'Chinese Grand Prix', 'Sauber');
insert into formula_stats_race values (35,  33, null,           14, 'Chinese Grand Prix', 'McLaren');
insert into formula_stats_race values (36,  18, null,           26, 'Chinese Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (37,  17, null,            2, 'Chinese Grand Prix', 'McLaren');
insert into formula_stats_race values (38,   3, null,           50, 'Chinese Grand Prix', 'Sauber');
insert into formula_stats_race values (39,   0, null,           18, 'Chinese Grand Prix', 'Williams');

insert into formula_stats_race values (40,  57, '01:33:53.374',  5, 'Bahrain Grand Prix', 'Ferrari');
insert into formula_stats_race values (41,  57, '01:34:00.034', 44, 'Bahrain Grand Prix', 'Mercedes');
insert into formula_stats_race values (42,  57, '01:34:13.771', 77, 'Bahrain Grand Prix', 'Mercedes');
insert into formula_stats_race values (43,  57, '01:34:15.849',  7, 'Bahrain Grand Prix', 'Ferrari');
insert into formula_stats_race values (44,  57, '01:34:32.720',  3, 'Bahrain Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (45,  57, '01:34:47.700', 19, 'Bahrain Grand Prix', 'Williams');
insert into formula_stats_race values (46,  57, '01:34:55.980', 11, 'Bahrain Grand Prix', 'Force India');
insert into formula_stats_race values (47,  57, '01:35:08.239',  8, 'Bahrain Grand Prix', 'Haas');
insert into formula_stats_race values (48,  57, '01:35:13.562', 27, 'Bahrain Grand Prix', 'Renault');
insert into formula_stats_race values (49,  57, '01:35:29.085', 31, 'Bahrain Grand Prix', 'Force India');
insert into formula_stats_race values (50,  56, null,           94, 'Bahrain Grand Prix', 'Sauber');
insert into formula_stats_race values (51,  56, null,           26, 'Bahrain Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (52,  56, null,           30, 'Bahrain Grand Prix', 'Renault');
insert into formula_stats_race values (53,  54, null,           14, 'Bahrain Grand Prix', 'McLaren');
insert into formula_stats_race values (54,  50, null,            9, 'Bahrain Grand Prix', 'Sauber');
insert into formula_stats_race values (55,  12, null,           55, 'Bahrain Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (56,  12, null,           18, 'Bahrain Grand Prix', 'Williams');
insert into formula_stats_race values (57,  11, null,           33, 'Bahrain Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (58,   8, null,           20, 'Bahrain Grand Prix', 'Haas');
insert into formula_stats_race values (59,   0, null,            2, 'Bahrain Grand Prix', 'McLaren');

insert into formula_stats_race values (60,  52, '01:28:08.743', 77, 'Russian Grand Prix', 'Mercedes');
insert into formula_stats_race values (61,  52, '01:28:09.360',  5, 'Russian Grand Prix', 'Ferrari');
insert into formula_stats_race values (62,  52, '01:28:19.743',  7, 'Russian Grand Prix', 'Ferrari');
insert into formula_stats_race values (63,  52, '01:28:45.063', 44, 'Russian Grand Prix', 'Mercedes');
insert into formula_stats_race values (64,  52, '01:29:09.159', 33, 'Russian Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (65,  52, '01:29:35.531', 11, 'Russian Grand Prix', 'Force India');
insert into formula_stats_race values (66,  52, '01:29:43.747', 31, 'Russian Grand Prix', 'Force India');
insert into formula_stats_race values (67,  52, '01:29:44.931', 27, 'Russian Grand Prix', 'Renault');
insert into formula_stats_race values (68,  51, null,           19, 'Russian Grand Prix', 'Williams');
insert into formula_stats_race values (69,  51, null,           55, 'Russian Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (70,  51, null,           18, 'Russian Grand Prix', 'Williams');
insert into formula_stats_race values (71,  51, null,           26, 'Russian Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (72,  51, null,           20, 'Russian Grand Prix', 'Haas');
insert into formula_stats_race values (73,  51, null,            2, 'Russian Grand Prix', 'McLaren');
insert into formula_stats_race values (74,  51, null,            9, 'Russian Grand Prix', 'Sauber');
insert into formula_stats_race values (75,  50, null,           94, 'Russian Grand Prix', 'Sauber');
insert into formula_stats_race values (76,   5, null,            3, 'Russian Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (77,   0, null,           30, 'Russian Grand Prix', 'Renault');
insert into formula_stats_race values (78,   0, null,            8, 'Russian Grand Prix', 'Haas');
insert into formula_stats_race values (79,   0, null,           14, 'Russian Grand Prix', 'McLaren');

insert into formula_stats_race values (80,  66, '01:35:56.497', 44, 'Spanish Grand Prix', 'Mercedes');
insert into formula_stats_race values (81,  66, '01:35:59.987',  5, 'Spanish Grand Prix', 'Ferrari');
insert into formula_stats_race values (82,  66, '01:37:12.317',  3, 'Spanish Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (83,  65, null,           11, 'Spanish Grand Prix', 'Force India');
insert into formula_stats_race values (84,  65, null,           31, 'Spanish Grand Prix', 'Force India');
insert into formula_stats_race values (85,  65, null,           27, 'Spanish Grand Prix', 'Renault');
insert into formula_stats_race values (86,  65, null,           55, 'Spanish Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (87,  65, null,           94, 'Spanish Grand Prix', 'Sauber');
insert into formula_stats_race values (88,  65, null,           26, 'Spanish Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (89,  65, null,            8, 'Spanish Grand Prix', 'Haas');
insert into formula_stats_race values (90,  64, null,            9, 'Spanish Grand Prix', 'Sauber');
insert into formula_stats_race values (91,  64, null,           14, 'Spanish Grand Prix', 'McLaren');
insert into formula_stats_race values (92,  64, null,           19, 'Spanish Grand Prix', 'Williams');
insert into formula_stats_race values (93,  64, null,           20, 'Spanish Grand Prix', 'Haas');
insert into formula_stats_race values (94,  64, null,           30, 'Spanish Grand Prix', 'Renault');
insert into formula_stats_race values (95,  64, null,           18, 'Spanish Grand Prix', 'Williams');
insert into formula_stats_race values (96,  38, null,           77, 'Spanish Grand Prix', 'Mercedes');
insert into formula_stats_race values (97,  32, null,            2, 'Spanish Grand Prix', 'McLaren');
insert into formula_stats_race values (98,   1, null,           33, 'Spanish Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (99,   0, null,            7, 'Spanish Grand Prix', 'Ferrari');

insert into formula_stats_race values (100, 78, '01:44:44.340', 44, 'Monaco Grand Prix', 'Mercedes');
insert into formula_stats_race values (101, 78, '01:44:47.485',  5, 'Monaco Grand Prix', 'Ferrari');
insert into formula_stats_race values (102, 78, '01:44:48.085',  3, 'Monaco Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (103, 78, '01:44:49.857', 11, 'Monaco Grand Prix', 'Force India');
insert into formula_stats_race values (104, 78, '01:44:50.539', 31, 'Monaco Grand Prix', 'Force India');
insert into formula_stats_race values (105, 78, '01:44:56.378', 27, 'Monaco Grand Prix', 'Renault');
insert into formula_stats_race values (106, 78, '01:45:00.141', 55, 'Monaco Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (107, 78, '01:45:02.490', 94, 'Monaco Grand Prix', 'Sauber');
insert into formula_stats_race values (108, 78, '01:45:03.785', 26, 'Monaco Grand Prix', 'Toro Rosso');
insert into formula_stats_race values (109, 78, '01:45:05.783',  8, 'Monaco Grand Prix', 'Haas');
insert into formula_stats_race values (110, 78, '01:45:07.077',  9, 'Monaco Grand Prix', 'Sauber');
insert into formula_stats_race values (111, 78, '01:45:08.065', 14, 'Monaco Grand Prix', 'McLaren');
insert into formula_stats_race values (112, 78, '01:45:33.429', 19, 'Monaco Grand Prix', 'Williams');
insert into formula_stats_race values (113, 71, null,           20, 'Monaco Grand Prix', 'Haas');
insert into formula_stats_race values (114, 71, null,           30, 'Monaco Grand Prix', 'Renault');
insert into formula_stats_race values (115, 66, null,           18, 'Monaco Grand Prix', 'Williams');
insert into formula_stats_race values (116, 63, null,           77, 'Monaco Grand Prix', 'Mercedes');
insert into formula_stats_race values (117, 57, null,            2, 'Monaco Grand Prix', 'McLaren');
insert into formula_stats_race values (118, 57, null,           33, 'Monaco Grand Prix', 'Red Bull Racing');
insert into formula_stats_race values (119, 15, null,            7, 'Monaco Grand Prix', 'Ferrari');
