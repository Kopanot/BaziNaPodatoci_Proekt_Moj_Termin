--CREATE TABLE--
create table bands(
    id_band int primary key,
    name varchar(255) not null
);


create table albums(
    id_album int primary key ,
    name varchar(100) not null ,
    release_year int,
    band_id int not null ,
    foreign key (band_id) references bands(id_band)
);

--INSERT INTO , VALUES--
insert into bands(id_band, name) values (1,'Irona Maiden');
insert into bands(id_band, name) values (2,'Deuce'),(3,'Avenged Sevenfold'),(4,'Anckor');

--SELECT *-- everything from bands
select * from bands;

--LIMIT--select first 2 from bands
select * from bands limit 2;

--select only NAMES of bands
select name from bands;

--ORDER BY, ASC/DESC--select bands alphabeticly
select * from bands order by name asc ;


insert into albums(id_album, name, release_year, band_id)
    values(1,'The Number of the Beasts',1985,1),
          (2,'Power Slave', 1984, 1),
          (3, 'Nightmare', 2018, 2),
          (4, 'Nightmare', 2010, 3),
          (5,'Test Album',null, 3);

select  * from albums;

--DISTINCT-- eliminate duplicates
select distinct name from albums;

--UPDATE, SET, WHERE-- statement changes the value of a variable where you specify it,
update albums set release_year = 1982 where id_album=1;

--<--
select * from albums
    where release_year < 2000;

--LIKE, OR, '%S'--
select * from albums where name like '%er%' or band_id=2;

--AND
select *from albums where release_year=1984 and band_id=1;

--BETWEEN
select *from  albums where release_year between 2000 and 2020;

--IS NULL--
select * from albums where release_year is null;

--DELETE--
delete from albums where id_album = 5;

select *from albums;

--JOIN-- + ORDER BY
select *from bands
    join albums on bands.id_band = albums.band_id order by release_year;

--INNER JOIN--
select *from bands
    inner join albums on bands.id_band = albums.band_id;

--LEFT JOIN--
select *from bands
    left join albums on bands.id_band = albums.band_id;

--RIGHT JOIN--
select *from albums
    right join bands on bands.id_band = albums.band_id;

--AVG FUNCTION--
select avg(release_year) from albums;

--SUM FUNCTION--
select sum(release_year) from albums;

--GROUP BY--
select band_id, count(band_id) from albums
    group by band_id;

select b.name as band_name, count(a.id_album) as num_albums from bands as b
    left join albums a on b.id_band = a.band_id
    group by b.id_band;




