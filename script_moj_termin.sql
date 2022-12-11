-- Doktor ( id_doktor, embg, ime, prezime )
create table Doktor(
	id_doktor integer primary key,
	embg char(13) not null unique ,
	ime varchar(100) not null,
	prezime varchar(100) not null
);


--Specijalizacija ( id_Specijalizacija, oblastSpecijalizacija )
create table Specijalizacija(
	id_specijalizacija integer primary key,
	oblast_specijalizacija varchar(50) not null
);


-- Specijalist ( id_doktor *(Doktor), institutSpecijalizacija, datumSpecijalizacija ,
--id_Specijalizacija * ( Specijalizacija ) )
create table Specijalist(
	id_doktor integer primary key,
	institut_Specijalizacija varchar(100) not null,
	datum_specijalizacija date not null,
	id_specijalizacija integer not null ,
	constraint fk_specijalist_doktor foreign key (id_doktor)
		references Doktor(id_doktor),
	constraint fk_specijalizacija_specijalist foreign key (id_specijalizacija)
        references Specijalizacija(id_specijalizacija)
);


--Matichen ( id_doktor*(Doktor), zamenaMaticen, adresaOrdinacija  )
create table Matichen(
	id_doktor integer primary key,
	zamena_matichen varchar(100) not null,
	adresa_ordinacija varchar(100) not null,
	constraint fk_matichen_doktor foreign key (id_doktor)
		references Doktor(id_doktor)
);


--Pacient ( id_Pacient , embg, ime, prezime, id_Doktor *(Matichen)  )
create table Pacient(
	id_pacient integer primary key,
	embg char(13) not null unique ,
	ime varchar(100) not null,
	prezime varchar(100) not null,
	id_matichen_pacient integer not null,
	constraint fk_matichen_pacient foreign key (id_matichen_pacient)
		references Matichen(id_doktor)
);


--Termin ( id_Termin, vreme, datum, daliEZakazan, id_Upat*(Upat), id_Doktor *( Specijalist ))
create table Termin(
    id_termin integer primary key ,
    vreme time not null ,
    datum date not null ,
    daliEZakazan bit,
    id_doktor_specijalist integer not null ,
    constraint fk_upat_specijalist foreign key (id_doktor_specijalist)
        references Specijalist(id_doktor)

);






--Upat ( id_Upat, id_Termin *( Termin ), id_Pacient *( Pacient ),
-- id_Doktor_Matichen *( Matichen ), id_Doktor_Specijalist *( Specijalist ) )
create table Upat(
    id_upat integer primary key ,
    id_termin integer not null ,
    id_pacient integer not null ,
    id_matichen_doktor integer not null ,
    id_specijalist_doktor integer not null ,
    constraint fk_termin_upat foreign key (id_termin)
                 references Termin(id_termin),
    constraint fk_pacient_upat foreign key (id_pacient)
                 references Pacient(id_pacient),
    constraint fk_matichen_upat foreign key (id_matichen_doktor)
                 references Matichen(id_doktor),
    constraint fk_specijalist_upat foreign key (id_specijalist_doktor)
                 references Specijalist(id_doktor)
);
alter table Upat add izveshtaj varchar(300);
alter table Upat add dijagnoza_matichen varchar(300);
alter table Upat add dijagnoza_specijalist varchar(300);


--TelefonskiBroj ( id_Doktor*(Matichen) , telefonskiBroj)
create table Telefon(
    id_doktor integer,
    telefonski_broj varchar(20),
    constraint pk_telefonski_broj primary key (id_doktor,telefonski_broj),
    constraint fk_telefonski_broj foreign key (id_doktor)
                    references Matichen(id_doktor)
);


insert into Doktor(id_doktor, embg, ime, prezime) values
    ( 1, '0101966410001', 'Petko', 'Petkovski' ),
    ( 2, '0202966410002', 'Trajko', 'Trajkovski' ),
    ( 3, '1202977415033', 'Jana', 'Janevska' ),
    ( 4, '0407990415017', 'Jovana', 'Jovanovska' );

insert into Doktor(id_doktor, embg, ime, prezime) values
    ( 5, '0101969410021', 'Jonko', 'Jonkovski' ),
    ( 6, '0504980415202', 'Angela', 'Angelovska' ),
    ( 7, '0301969410005', 'Mile', 'Milevski' ),
    ( 8, '0103969410063', 'Dzvonko', 'Dzvonkovski' ),
    ( 9, '0705989415013', 'Milka', 'Milkovska' ),
    ( 10, '2111978415015', 'Eva', 'Evovska' );


insert into Specijalizacija values
    ( 1, 'Kozno' ),
    ( 2, 'Ocno' ),
    ( 3, 'Hirurgija' ),
    ( 4, 'Pedijatrija' ),
    ( 5, 'Nevrologija' );

insert into Matichen(id_doktor, zamena_matichen, adresa_ordinacija) values
    ( 1, 'Pavle Bozinovski', 'Partizanski Odredi 44' ),
    ( 3, 'Blazo Blazevski', 'Ruzveltova 28' );
insert into Matichen(id_doktor, zamena_matichen, adresa_ordinacija) values
    ( 5, 'Jonce Presilski', 'Solunska 13A' ),
    ( 10, 'Gabriela Gavranovska', 'Deveani 105' );


-- DA MI SE OBJASNI
select ime,prezime,adresa_ordinacija,zamena_matichen from Matichen
    join Doktor D on D.id_doktor = Matichen.id_doktor;

insert into Specijalist(id_doktor, institut_Specijalizacija, datum_specijalizacija, id_specijalizacija) values
    ( 2, 'Bolnica Zan Mitrev', now()-interval '5 years', 2),
    ( 4, 'Bolnica Plodost', now()-interval '7 years', 5 );

insert into Specijalist(id_doktor, institut_Specijalizacija, datum_specijalizacija, id_specijalizacija) values
    ( 6, 'Bolnica Trifun Panovski', '2005-10-23'::date, 1),
    ( 7, 'Bolnica Filip II','1989-03-21'::date , 4 ),
    ( 8, 'Bolnica 8 Semptemvri', '1998-07-01'::date, 3),
    ( 9, 'Bolnica Trifun Panovski', '2000-05-18'::date, 4);

insert into Pacient(id_pacient, embg, ime, prezime, id_matichen_pacient) values
    ( 1, '2905000410007', 'Leo', 'Trajcev', 1 ),
    ( 2, '2905000410008', 'Teo', 'Teonov', 1 ),
    ( 3, '2905000410009', 'Todor', 'Todorov', 3 ),
    ( 4, '2905000415010', 'Marija', 'Ristevska', 1 ),
    ( 5, '2905000415011', 'Tea', 'Trajanovska', 3 );


insert into telefon(id_doktor, telefonski_broj) VALUES
    (1, '075555468'),
    (1, '076666499'),
    (3, '071555333'),
    (3, '077525411');

insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (1,'13:30','2018-5-2','0',2 );
insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (2,'14:30','2018-5-2','0',2 );
insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (3,'15:00','2018-5-2','0',4 );
insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (4,'15:30','2018-5-2','0',4 );



insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (5,'16:0','2018-5-2','0',2 ),
 (6,'16:30','2018-5-2','0',2 ),
 (7,'17:00','2018-5-2','0',4 ),
 (8,'17:30','2018-5-2','0',4 );

insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (9,'18:00','2018-5-15','0',4 ),
        (10,'18:30','2018-5-16','0',2 ),
               (11,'19:00','2018-5-17','0',4 ),
                      (12,'19:30','2018-5-17','0',2 );

insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (13,'12:00','2022-12-06','0',7 ),
        (14,'14:00','2022-12-06','0',8 );

insert into Termin (id_termin, vreme, datum, daliEZakazan,id_doktor_specijalist)
values (15,'12:00','2022-12-06','0',9 );



insert into Upat (id_upat, id_termin, id_pacient, id_matichen_doktor, id_specijalist_doktor, dijagnoza_matichen)values
(1,1,1,1,2,'Bolki vo muskul'),
(2,2,2,1,2,'Glavobolka'),
(3,3,3,3,4,'Respiratorni Problemi'),
(4,4,4,3,4,'Problemi so srce'),
(5,5,3,1,2,'Pokacena telesna temperatura'),
(6,6,5,3,4,'Bolki vo zglobovi');
insert into Upat (id_upat, id_termin, id_pacient, id_matichen_doktor, id_specijalist_doktor, dijagnoza_matichen)values
(7,13,5,1,7,'Bronhitis'),
(8,14,3,10,8,'Bronhopneumonija');



--------------------------------------------------------Views----------------------------------------------------------------------
--Матичниот може да ги добие сите слободни термини за да може да закаже

create view termini_za_matichen as
select * from Termin  as t where daliEZakazan = '0'
and extract(year from t.datum) >= extract(year from now())
    and extract(month from t.datum) >= extract(month from now())
          and extract(day from t.datum) >= extract(day from now())
            and extract(hour from t.vreme) > extract(hour from now());

select * from termini_za_matichen;




--Специјалистот да може да ги добие сите термини со тоа на кој пациент припаѓаат за тековниот ден.
create view  listaj_deneshni_termini_kaj_specijalist as
select D.prezime as Specijalist,t.id_termin,t.vreme,t.datum,extract(Day from now()) as Den ,u.id_upat,p.ime as PacientIme,
       p.prezime as PacientPrezime, u.dijagnoza_matichen as Dijagnoza from Specijalist as s
join Doktor D on D.id_doktor = s.id_doktor
join  Termin T on s.id_doktor = T.id_doktor_specijalist
join Upat U on u.id_termin = T.id_termin
join Pacient P on U.id_pacient = P.id_pacient
where extract(DAY from t.datum) = extract(DAY from now())
    and extract(Month from t.datum) = extract(Month from now())
        and extract(Year from t.datum) = extract(Year from now());

select * from listaj_deneshni_termini_kaj_specijalist;



--- Пациентот може да ги добие сите термини и упати кои му припаѓаат нему
create view listaj_termini_i_upati_za_pacient as
select p.ime,p.prezime,u.dijagnoza_matichen,t.vreme,t.datum,d.prezime as Specijalist from Pacient as p
join upat as u on u.id_pacient = p.id_pacient
join termin t on u.id_termin = t.id_termin
join Specijalist as s on s.id_doktor = t.id_doktor_specijalist
join Doktor D on s.id_doktor = D.id_doktor;

select * from listaj_termini_i_upati_za_pacient;

-------------------------------------------------Forms-----------------------------------------------------------------
--Матичниот треба да може да внесе пациент
begin;
savepoint sp_vnes_pacient;
insert into pacient
values ('6','2202999410088','Jonche','Jonchevski','6' );
commit;


--Специјалистот треба да може да објави термини
begin;
savepoint sp_objavi_termin;
insert into Termin (id_termin, vreme,
                    datum, daliEZakazan,id_doktor_specijalist)
values (9,'18:00','2018-5-15','0',4 ),
        (10,'18:30','2018-5-16','0',2 );
commit;

--Матичниот може да генерира упат и со него да закаже термин
begin;
savepoint sp_zakazi_termin;
insert into Upat (id_upat, id_termin, id_pacient,
                  id_matichen_doktor, id_specijalist_doktor,
                  dijagnoza_matichen)
    values
    (9,7,3,10,8,'Tahikardija');
update termin set daliezakazan = '1'
    where id_termin = 7;
commit;

--Специјалистот после прегледот може да внеси податоци во извештајот
begin;
savepoint sp_vnesi_izveshtaj;
update upat set izveshtaj = 'Skrshenica na zglob na leva noga pri sporuvanje',
                dijagnoza_specijalist = 'Skrshenica'
where id_upat = '6';
commit;













---Vezbanje left,right,inner,outer join--
/*select d.id_doktor as id, ime as Ime, prezime as Prezime, institut_Specijalizacija as Institut,oblast_specijalizacija as Oblast from Doktor as d
full outer join  Specijalist S on d.id_doktor = S.id_doktor
left join Specijalizacija as sp on S.id_specijalizacija = sp.id_specijalizacija;

select prezime as doktor,id_upat as Upat, oblast_specijalizacija as oblast,
       p.ime,p.prezime,dijagnoza_matichen as dijagnoza from Doktor as D
left join Specijalist as s on D.id_doktor = s.id_doktor
left join Specijalizacija as sp on s.id_specijalizacija = sp.id_specijalizacija
left join Pacient as p
left join Upat U on s.id_doktor = U.id_specijalist_doktor;*/
--where s.id_doktor = 3;

