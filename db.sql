create table customer (
    id bigint not null,
    name varchar(200) not null,
    age integer not null
);


insert into customer (id, name, age) values (1, 'Harald', 41);
insert into customer (id, name, age) values (2, 'Paul', 23);
insert into customer (id, name, age) values (3, 'Stefan', 31);